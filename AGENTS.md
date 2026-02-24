# Project Overview

The "Calculatrice Salaire Net TangoMan" is a Vue.js web application designed to convert gross salaries to net salaries. It supports various salary bases (hourly, daily, monthly, annual) and considers charges and annual leave days. This project also functions as a Progressive Web App (PWA), enabling offline usage and an app-like experience.

**Key Technologies:**
- **Frontend Framework:** Vue.js 2.6.10
- **Styling:** Bootstrap 4.3.1, Sass
- **Testing:** Mocha, Chai
- **Build Tool:** Vue CLI
- **Development Environment:** Docker
- **Dependency Management:** npm, Yarn
- **CI/CD:** GitHub Actions (inferred from `.github/workflows/node.yml` and `README.md` badges)

# Building and Running

The project utilizes `npm` (or `yarn`) for dependency management and `vue-cli-service` for various development tasks. Many commands are wrapped in `Makefile` targets and executed within a Docker container.

## Prerequisites

- Docker
- Node.js (for `npm` or `yarn`)
- Make

## Commands

- **Start Docker container, install dependencies, and serve the application locally:**
  ```bash
  make up
  ```

- **Install dependencies:**
  ```bash
  make install
  # or
  npm install
  # or
  yarn install
  ```

- **Serve with hot reload at localhost:**
  ```bash
  make serve
  # or
  npm run serve
  ```

- **Build for production with minification:**
  ```bash
  make build
  # or
  npm run build
  ```

- **Run unit tests:**
  ```bash
  make tests
  # or
  npm run test:unit
  ```

- **Lint and fix files:**
  ```bash
  make lint
  # or
  npm run lint
  ```

- **Deploy to GitHub Pages:**
  ```bash
  make deploy
  ```

# Development Conventions

- **Linting:** The project uses ESLint with recommended rules for Vue and standard JavaScript. Console logs and debuggers are disallowed in production builds.
- **Testing:** Unit tests are written using Mocha and Chai, favoring the `assert` style. Tests are located in the `tests/unit/` directory.
- **Component Structure:** Vue components are organized in `src/components/`. The main application logic resides in `src/App.vue` and `src/main.js`.
- **State Management/Calculations:** Core calculation logic is encapsulated in JavaScript classes within the `src/entities/` directory (e.g., `Calc.js`, `Salary.js`, `Hours.js`).
- **Styling:** Sass is used for pre-processing CSS, integrated into Vue components.
- **Configuration:** Vue CLI configurations are managed through `vue.config.js`, including `publicPath` settings for deployment.
- **Dockerized Development:** Development commands are primarily executed within a Docker container, ensuring a consistent development environment.
