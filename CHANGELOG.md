Change Log
==========

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## 2026 Update [2.0.0](https://github.com/TangoMan75/calculatrice-salaire-net/releases/tag/2.0.0)
### Added
- AGENTS.md
- Reference wages for years 2026 and 2025 in `src/data/reference_wages.json`.
- Vite configuration (`vite.config.js`) with PWA plugin.
### Changed
- Copyright year in `LICENSE` to 2026 and in `src/components/Card.vue` footer.
- Unit tests for `footer.spec.js` to reflect new copyright and version.
- Migrated from Vue 2 to Vue 3.
- Migrated from Vue CLI to Vite for development and build.
- Migrated from Mocha to Vitest for unit tests.
- Updated `package.json` scripts: `serve` replaced by `dev`, added `preview`.
- Removed `vue.config.js`; config moved to `vite.config.js`.
- `public/index.html` moved to root `index.html`.
- Updated ESLint config from `babel-eslint` to `@babel/eslint-parser`.
### Removed
- Docker development environment (`Makefile`, `docker-compose.yaml`, `entrypoint.sh`).
- Service worker registration (`src/registerServiceWorker.js`).
- `postcss.config.js` and `babel.config.js`.

## Initial Release [1.0.0](https://github.com/TangoMan75/calculatrice-salaire-net/releases/tag/1.0.0)

