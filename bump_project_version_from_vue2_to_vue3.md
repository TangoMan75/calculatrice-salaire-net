# From Vue 2 + Vue CLI to Vue 3 + Vite: A Complete Migration Guide

## Introduction

Modernising a legacy Vue 2 project is a task many teams face as the ecosystem moves on. Vue 2 reached End of Life in December 2023, and Vue CLI — the stalwart build tool — has been in maintenance mode since July 2023, superseded by Vite. This article walks through a real-world migration of **Calculatrice Salaire Net TangoMan**, a salary calculator PWA, from Vue 2.6.10 + Vue CLI 3 to Vue 3.4 + Vite 5 + Vitest, covering every breaking change, dependency swap, and config rewrite encountered along the way.

## The Challenge

The project was a typical mid-sized Vue 2 SPA with the following characteristics:

- **Vue 2.6.10** with Options API components
- **Vue CLI 3.9** (Webpack 4-based) for building and serving
- **Vue CLI plugins** for Babel, ESLint, PWA (Workbox), and unit testing via Mocha
- **`@vue/test-utils 1.x`** with **Mocha + Chai** for unit tests
- **`babel-eslint`** as the ESLint parser for class field support
- **`register-service-worker`** for manual PWA lifecycle management
- **`core-js@2`** for polyfills via Babel
- **`sass-loader@7`** for SCSS compilation (Webpack 4 era)
- **`vue-template-compiler`** (required by Vue 2 but incompatible with Vue 3)

Several hard constraints shaped the migration strategy:

1. **No composition API refactor** — the existing Options API code had to remain untouched to minimise risk. Vue 3 supports Options API natively.
2. **Test coverage must be preserved** — all 22 existing unit tests (entity logic + component mount) must pass without alteration to test logic.
3. **PWA must remain functional** — offline support via Workbox service worker is a core feature for the calculator app.
4. **GitHub Pages deployment** — the `publicPath`/`base` configuration must support sub-path deployment at `/calculatrice-salaire-net/`.

## The Solution

The migration was decomposed into two phases: **Vue 3 core upgrade** (keeping Vue CLI 5 as an interim step), followed by **build tool migration** from Vue CLI to Vite. Each phase is presented with its exact changes and rationale.

---

### Phase 1: Vue 3 Core Upgrade (Vue CLI 5 Intermediate)

The first pass upgraded Vue and its CLI plugins to versions compatible with Vue 3 while keeping the Webpack-based build chain intact.

#### 1.1 Dependency Bump (package.json)

```json
{
  "dependencies": {
    "vue": "^3.4.0",
    "core-js": "^3.30.0"
  },
  "devDependencies": {
    "@vue/cli-service": "^5.0.8",
    "@vue/cli-plugin-babel": "^5.0.8",
    "@vue/cli-plugin-eslint": "^5.0.8",
    "@vue/cli-plugin-pwa": "^5.0.8",
    "@vue/cli-plugin-unit-mocha": "^5.0.8",
    "@vue/test-utils": "^2.4.0",
    "vue-template-compiler": "removed",
    "@vue/compiler-sfc": "^3.4.0",
    "sass-loader": "^13.3.0",
    "eslint-plugin-vue": "^9.0.0",
    "@babel/eslint-parser": "^7.22.0"
  }
}
```

Key decisions:
- **`vue-template-compiler` removed** — Vue 3 uses `@vue/compiler-sfc` instead; this package is mutually exclusive with Vue 3 and will cause build failures if present.
- **`eslint-plugin-vue@9`** — this major version switches the lint preset from `plugin:vue/essential` (Vue 2) to `plugin:vue/vue3-essential`, which enforces Vue 3-specific rules including `vue/multi-word-component-names`.
- **`@vue/test-utils@2`** — v2 is rewritten for Vue 3's component mounting model; the `shallowMount`/`propsData` API is preserved.
- **`sass-loader@13`** — the Webpack 5 compatible version required by Vue CLI 5.

#### 1.2 Application Entry Point (src/main.js)

```javascript
// Vue 2 — OLD
import Vue from 'vue'
import App from './App.vue'

Vue.config.productionTip = false

new Vue({
  render: h => h(App),
}).$mount('#app')

// Vue 3 — NEW
import { createApp } from 'vue'
import App from './App.vue'

createApp(App).mount('#app')
```

The `createApp` function replaces the `new Vue()` constructor pattern. Note that `Vue.config.productionTip` was removed in Vue 3 — it is no longer needed as Vite handles dev/production mode natively.

#### 1.3 Filters → Methods Migration (src/components/Card.vue)

Vue 3 **removed filters** entirely. The previous code used a `filters` block:

```javascript
// Vue 2 — OLD (removed in Vue 3)
filters: {
    format_euro(number) {
        return Intl.NumberFormat('fr-FR', {style: 'currency', currency: 'EUR'}).format(number)
    }
}
```

This was converted to a regular method and all `| format_euro` pipe syntax in the template was replaced with explicit method calls:

```javascript
// Vue 3 — NEW
methods: {
    formatEuro(number) {
        return Intl.NumberFormat('fr-FR', {style: 'currency', currency: 'EUR'}).format(number)
    },
    // ... other methods
}
```

Template change:
```html
<!-- OLD (Vue 2 filter) -->
<span class="editable">{{ calc.salary.annual_gross | format_euro }}</span>

<!-- NEW (Vue 3 method call) -->
<span class="editable">{{ formatEuro(calc.salary.annual_gross) }}</span>
```

#### 1.4 ESLint Configuration (.eslintrc.js)

```javascript
module.exports = {
  extends: [
    'plugin:vue/vue3-essential',  // was 'plugin:vue/essential'
    'eslint:recommended'
  ],
  rules: {
    'vue/multi-word-component-names': 'off',  // single-word components like "Card" are intentional
    'vue/no-reserved-component-names': 'off',  // "Footer" is a valid component name here
  },
  parserOptions: {
    parser: '@babel/eslint-parser',  // was 'babel-eslint' (renamed package)
    requireConfigFile: false,        // no Babel config needed with Vite
    ecmaVersion: 2022,
    sourceType: 'module'
  }
}
```

The `vue/multi-word-component-names` rule is new in eslint-plugin-vue v9 and will flag single-word component names (`Card`, `Footer`). These were explicitly disabled since they are intentional in this project.

#### 1.5 Class Field Support

Class fields (also called public class fields) are the `property = value` syntax defined directly on a class body, outside the constructor. They are commonly used in Vue components for data, computed properties, methods, and lifecycle hooks within the Options API, and are also present in the project's entity classes (`src/entities/Calc.js`, `Salary.js`, `Hours.js`).

```javascript
// Example class field usage across Vue 2 / Vue 3
export default {
  data: () => ({
    someField: 'value'    // Class field syntax in .js entity files
  }),
  methods: {
    handleClick() { ... }
  }
}
```

**Before (Vue 2 + Vue CLI 3):**

Class fields were a Stage 3 proposal in 2019 and were only supported through transpilation. The project relied on two layers to handle them:

|          Layer           |                      Package                      |                                       Role                                       |
|--------------------------|---------------------------------------------------|----------------------------------------------------------------------------------|
| Build-time transpilation | `@vue/cli-plugin-babel` (via `@babel/preset-env`) | Transforms class fields into ES5-compatible code for older browsers              |
| ESLint parsing           | `babel-eslint` (v10)                              | Parses class field syntax so ESLint can lint files without throwing parse errors |

Without `babel-eslint`, ESLint would fail on any file using class field syntax — including all `.vue` SFCs and entity classes — since ESLint's default parser (Espree) did not yet support the syntax.

**After (Vue 3 + Vue CLI 5, intermediate step):**

During Phase 1 (Vue 3 core upgrade while keeping Webpack), the changes were:

1. **ESLint parser renamed**: `babel-eslint` → `@babel/eslint-parser` (the Babel team moved all packages under the `@babel` npm scope).
2. **Parser options aligned**: `ecmaVersion` was set to `2022` in `.eslintrc.js`, which tells ESLint to recognise class fields as standard JavaScript rather than relying solely on the Babel parser to enable them.
3. **Babel preset updated**: `@vue/app` → `@vue/cli-plugin-babel/preset`, which internally uses `@babel/preset-env` with the appropriate class field transforms for the target browsers.

```javascript
// Phase 1 ESLint config
parserOptions: {
  parser: '@babel/eslint-parser',  // was 'babel-eslint'
  ecmaVersion: 2022,               // class fields are standard as of ES2022
  sourceType: 'module'
}
```

**After (Vue 3 + Vite 5, final state):**

In Phase 2 (Vite migration), the class field support landscape shifted significantly:

1. **Babel transpilation removed**: Vite uses esbuild for production builds and the native Node.js module system for development. Since class fields are part of the ES2022 standard and the project targets modern browsers, no transpilation is needed. The `babel.config.js` file was deleted entirely.
2. **`@babel/eslint-parser` retained**: Even though esbuild handles class fields natively, ESLint still needs a parser that understands them. `@babel/eslint-parser` (or equivalently `@eslint/eslint-parser` with `ecmaVersion: 2022`) continues to serve this role. The key change is that class field parsing is no longer a "special feature" — it is simply standard JavaScript syntax.
3. **`core-js` removed**: Polyfills for class fields are no longer needed since modern browsers (and Node 18+) implement ES2022 natively.

**What did not change:**

- The actual class field syntax in the codebase (entity classes, Vue component options) required **zero modifications**. Class fields are a JavaScript language feature, not a Vue API, so Vue's version bump had no impact on how they are written.
- The `ecmaVersion: 2022` setting, once introduced in Phase 1, remained unchanged through Phase 2.

**Summary of the class field support evolution:**

|       Aspect       |      Vue 2 + Vue CLI 3      |           Vue 3 + Vue CLI 5            |     Vue 3 + Vite 5     |
|--------------------|-----------------------------|----------------------------------------|------------------------|
| ESLint parser      | `babel-eslint`              | `@babel/eslint-parser`                 | `@babel/eslint-parser` |
| Transpilation      | Babel (`@babel/preset-env`) | Babel (`@vue/cli-plugin-babel/preset`) | esbuild (native)       |
| Polyfill source    | `core-js@2`                 | `core-js@3`                            | none (native)          |
| ESLint ecmaVersion | implicit (Espree default)   | `2022`                                 | `2022`                 |
| Node.js minimum    | 8                           | 12                                     | 18                     |

**Bottom line**: The Vue version bump itself had **zero direct impact** on class field support — class fields are a JavaScript language feature, independent of Vue. The perceived changes were driven by the parallel build tool migration (Babel → esbuild) and the natural maturation of JavaScript (Stage 3 → ES2022 standard), which happened to coincide with the move to Node 18+.

#### 1.6 Babel Configuration (babel.config.js)

```javascript
// Vue CLI 3 — OLD
module.exports = {
  presets: ['@vue/app']
}

// Vue CLI 5 — NEW
module.exports = {
  presets: ['@vue/cli-plugin-babel/preset']
}
```

With the eventual move to Vite, `babel.config.js` was later removed entirely since Vite uses esbuild for transpilation, not Babel.

---

### Phase 2: Vite Migration (Webpack → esbuild)

With the Vue 3 core upgrade validated, the second phase replaced the build tooling entirely.

#### 2.1 Complete Dependency Swap (package.json)

```json
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "lint": "eslint --ext .js,.vue src --fix",
    "test:unit": "vitest run"
  },
  "dependencies": {
    "vue": "^3.4.0"
    // core-js removed: Vite targets modern browsers by default
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^5.0.0",
    "vite": "^5.0.0",
    "vitest": "^1.0.0",
    "jsdom": "^24.0.0",
    "vite-plugin-pwa": "^0.19.0",
    "@vue/test-utils": "^2.4.0",
    "chai": "^4.3.0",
    "eslint": "^7.32.0",
    "eslint-plugin-vue": "^9.0.0",
    "sass": "^1.60.0"
    // sass-loader removed: Vite has built-in SCSS support
    // @vue/cli-* removed: replaced by Vite
    // @vue/compiler-sfc removed: included in @vitejs/plugin-vue
  }
}
```

Total package count dropped from **1237** (Webpack) to **631** (Vite) — a ~49% reduction.

#### 2.2 Vite Configuration (vite.config.js)

```javascript
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { VitePWA } from 'vite-plugin-pwa'
import { fileURLToPath, URL } from 'node:url'

export default defineConfig({
    // GitHub Pages sub-path deployment
    base: process.env.NODE_ENV === 'production' ? '/calculatrice-salaire-net/' : '/',

    plugins: [
        vue(),                          // Vue 3 SFC compiler
        VitePWA({                       // Replaces @vue/cli-plugin-pwa
            registerType: 'autoUpdate',
            workbox: {
                globPatterns: ['**/*.{js,css,html,ico,png,svg,jpg,json}']
            },
            manifest: {
                name: 'TangoMan | Calculatrice Salaire Net',
                short_name: 'Calculatrice Salaire Net',
                theme_color: '#5599FF',
                // ...icons and other PWA manifest fields
            }
        })
    ],

    css: {
        preprocessorOptions: {
            scss: {
                api: 'modern'  // Use new Sass JS API (avoids deprecation warning)
            }
        }
    },

    resolve: {
        alias: {
            '@': fileURLToPath(new URL('./src', import.meta.url))  // @ → src/
        }
    },

    // Vitest configuration (inline)
    test: {
        environment: 'jsdom',
        include: ['tests/unit/**/*.spec.js'],
        globals: true
    }
})
```

Key architectural decisions:

- **`base` replaces `publicPath`** — Vite uses the `base` config option (analogous to Webpack's `output.publicPath`).
- **`vite-plugin-pwa` replaces `@vue/cli-plugin-pwa`** — it generates the Workbox service worker and PWA manifest during `vite build`. With `registerType: 'autoUpdate'`, it injects a registration script (`registerSW.js`) that handles the SW lifecycle automatically, eliminating the need for the manual `register-service-worker` package.
- **Sass `api: 'modern'`** — Dart Sass 2.0 will remove the legacy JS API. Vite 5.4+ allows opting into the new API via `css.preprocessorOptions.scss.api`.
- **`test` config inline** — Vitest configuration is colocated in `vite.config.js` to avoid a separate `vitest.config.js` file.

#### 2.3 index.html Restructuring

With Vue CLI, `public/index.html` was an EJS template processed by HtmlWebpackPlugin, supporting `<%= BASE_URL %>` interpolation:

```html
<!-- Vue CLI — OLD (public/index.html) -->
<link rel="canonical" href="https://tangoman75.github.io<%= BASE_URL %>" />
<link rel="icon" href="./favicon.ico" />
<!-- built files will be auto injected -->
```

With Vite, `index.html` lives at **project root** and is a pure HTML file with a module script tag:

```html
<!-- Vite — NEW (index.html at root) -->
<link rel="canonical" href="https://tangoman75.github.io/calculatrice-salaire-net/" />
<link rel="icon" href="/favicon.ico" />
<div id="app"></div>
<script type="module" src="/src/main.js"></script>
```

Static assets (`favicon.ico`, `css/bootstrap.min.css`, `images/`) remain in the `public/` directory and are served as-is. All `<% %>` EJS tags were replaced with static paths. The `public/index.html` file was deleted.

#### 2.4 Service Worker Simplification

The old flow used `register-service-worker` with manual event dispatching:

```javascript
// OLD: src/registerServiceWorker.js (44 lines, deleted)
import { register } from 'register-service-worker';
if (process.env.NODE_ENV === 'production') {
    register(`${process.env.BASE_URL}service-worker.js`, {
        updated(registration) {
            document.dispatchEvent(
                new CustomEvent('swUpdated', { detail: registration })
            );
        },
        // ... other lifecycle hooks
    });
}
```

The `vite-plugin-pwa` with `registerType: 'autoUpdate'` handles this automatically in ~40 lines of generated code. The custom `swUpdated` event and the corresponding `showRefreshUI`/`refreshApp` methods in `Card.vue` were removed, along with the update button in the template.

#### 2.5 Test Framework Migration (Mocha → Vitest)

The transition from `@vue/cli-plugin-unit-mocha` to Vitest required:

1. **Package swap**: Remove `@vue/cli-plugin-unit-mocha`, add `vitest` + `jsdom`.
2. **Environment config**: Set `environment: 'jsdom'` in the Vite `test` config for DOM API support.
3. **Global API**: Enable `globals: true` so `describe`/`it`/`assert` work without explicit imports.
4. **Test ESLint config**: Update `tests/unit/.eslintrc.js` from `mocha` to `vitest` env.

```javascript
// tests/unit/.eslintrc.js
module.exports = {
  env: { vitest: true }  // was mocha: true
}
```

Vitest is API-compatible with Mocha: `describe`/`it` blocks, `beforeEach`/`afterEach` hooks, and Chai assertions all work identically. The 22 existing tests required **zero code changes** to the test files themselves.

#### 2.6 Deleted Files

After migration, the following files were removed as they have no Vite equivalent:

|              File              |          Purpose           |             Replacement             |
|--------------------------------|----------------------------|-------------------------------------|
| `vue.config.js`                | Webpack config via Vue CLI | `vite.config.js`                    |
| `babel.config.js`              | Babel transpilation        | esbuild (built into Vite)           |
| `postcss.config.js`            | Autoprefixer config        | Vite handles PostCSS natively       |
| `src/registerServiceWorker.js` | Manual SW registration     | `vite-plugin-pwa` auto-registration |
| `public/index.html`            | EJS template               | Root `index.html` (static HTML)     |

## Results

```
Before (Vue CLI 3 + Webpack 4):
  Build time:         4,279 ms
  Node modules:       1,237 packages
  Test framework:     Mocha + @vue/test-utils v1
  PWA:                @vue/cli-plugin-pwa + register-service-worker

After (Vite 5 + esbuild):
  Build time:         602 ms       (86% faster)
  Node modules:       631 packages  (49% fewer)
  Test framework:     Vitest + @vue/test-utils v2
  PWA:                vite-plugin-pwa (auto-update)
  Tests:              22/22 passing (unchanged)
  Lint:               Clean (0 errors, 0 warnings)
```

## Key Takeaways

- **Vue 3's Options API compatibility** made this migration possible without rewriting any component logic. The only template-level breaking change was the removal of filters, which were replaced with method calls.
- **Vue CLI 5 as an intermediate step** is not strictly necessary but reduces risk: it validates Vue 3 compatibility before touching the build tooling. However, going directly from Vue CLI 3 to Vite is also feasible if you're comfortable with parallel debugging.
- **`vite-plugin-pwa` eliminates boilerplate** — the manual `register-service-worker` setup with custom event dispatching was replaced by a declarative plugin config in `vite.config.js`. The `autoUpdate` register type provides a better UX than the previous "update available" banner.
- **Vitest is a drop-in replacement for Mocha** when using Chai assertions in describe/it blocks. The migration required zero test file modifications — only the ESLint env and framework configuration changed.
- **Package count halved** — Vite's bundling of esbuild, Rollup, and its opinionated defaults eliminates dozens of transitive Webpack dependencies (loaders, plugins, polyfills).
- **Build performance scales with project size** — for this small PWA, the 7× speedup (4.3s → 0.6s) is dramatic. For larger projects, the improvement is even more pronounced due to esbuild's native-code parsing.

## Conclusion

Migrating from Vue 2 + Vue CLI to Vue 3 + Vite is a significant but well-documented path. The Vue core team has provided migration builds, a comprehensive migration guide, and the `@vue/compat` runtime for incremental adoption. Combined with Vite's maturity as a production-grade build tool and Vitest's seamless Mocha compatibility, there are few reasons to remain on the legacy stack.

The project now benefits from faster builds, a smaller dependency footprint, a modern PWA setup, and a test framework aligned with the wider Vite ecosystem. The next step would be evaluating whether migrating individual components to the Composition API provides measurable maintainability gains — but with Options API fully supported in Vue 3, there is no urgency.

## References

- [Vue 3 Migration Guide](https://v3-migration.vuejs.org/)
- [Vite Documentation](https://vite.dev/guide/)
- [Vitest Documentation](https://vitest.dev/guide/)
- [vite-plugin-pwa](https://vite-pwa-org.netlify.app/guide/)
- [Vue ESLint Plugin v9](https://eslint.vuejs.org/user-guide/)
- [Vue 3 Filters Removal](https://v3-migration.vuejs.org/breaking-changes/filters.html)
