# Project Overview

The "Calculatrice Salaire Net TangoMan" is a Vue.js web application designed to convert gross salaries to net salaries. It supports various salary bases (hourly, daily, monthly, annual) and considers charges and annual leave days. This project also functions as a Progressive Web App (PWA), enabling offline usage and an app-like experience.

**Key Technologies:**
- **Frontend Framework:** Vue.js 3.4
- **Styling:** Bootstrap 4.3.1, Sass
- **Testing:** Vitest, Chai
- **Build Tool:** Vite 5
- **Dependency Management:** npm, Yarn
- **CI/CD:** GitHub Actions (`.github/workflows/node.yml`)

# Building and Running

The project uses `npm` (or `yarn`) for dependency management and `vite` for development and build tasks.

## Prerequisites

- Node.js (for `npm` or `yarn`)

## Commands

- **Install dependencies:**
  ```bash
  npm install
  ```

- **Serve with hot reload at localhost:**
  ```bash
  npm run dev
  ```

- **Build for production with minification:**
  ```bash
  npm run build
  ```

- **Preview production build:**
  ```bash
  npm run preview
  ```

- **Run unit tests:**
  ```bash
  npm run test:unit
  ```

- **Lint and fix files:**
  ```bash
  npm run lint
  ```

# Development Conventions

- **Linting:** The project uses ESLint with recommended rules for Vue and standard JavaScript. Console logs and debuggers are disallowed in production builds.
- **Testing:** Unit tests are written using Vitest and Chai, favoring the `assert` style. Tests are located in the `tests/unit/` directory.
- **Component Structure:** Vue components are organized in `src/components/`. The main application logic resides in `src/App.vue` and `src/main.js`.
- **State Management/Calculations:** Core calculation logic is encapsulated in JavaScript classes within the `src/entities/` directory (e.g., `Calc.js`, `Salary.js`, `Hours.js`).
- **Styling:** Sass is used for pre-processing CSS, integrated into Vue components.
- **Configuration:** Vite configurations are managed through `vite.config.js`, including `base` path for deployment and PWA plugin settings.
