![GH language](https://img.shields.io/github/languages/top/TangoMan75/calculatrice-salaire-net)
[![GH tag](https://img.shields.io/github/v/tag/TangoMan75/calculatrice-salaire-net)](https://github.com/TangoMan75/calculatrice-salaire-net/tags)
[![GH release](https://img.shields.io/github/v/release/TangoMan75/calculatrice-salaire-net)](https://github.com/TangoMan75/calculatrice-salaire-net/releases)
![GH license](https://img.shields.io/github/license/TangoMan75/calculatrice-salaire-net)
![GH stars](https://img.shields.io/github/stars/TangoMan75/calculatrice-salaire-net)

![Node CI](https://github.com/TangoMan75/calculatrice-salaire-net/workflows/Node%20CI/badge.svg)

![visiteurs](https://visitor-badge.glitch.me/badge?page_id=TangoMan75.calculatrice-salaire-net)

Calculatrice Salaire Net TangoMan
=================================

La **Calculatrice Salaire Net TangoMan** permet de convertir votre salaire brut en net horaire, journalier, mensuel, annuel sur une base de 35 heures ou 39 heures par semaine en fonction des charges auxquelles vous êtes soumis et de votre nombre de congés par an.

[Pour tester l'application c'est ici !](https://tangoman75.github.io/calculatrice-salaire-net).

🎯 Fonctionalités
-----------------

La **Calculatrice Salaire Net TangoMan** est disponible en mode PWA (Progressive Web App), vous pouvez donc l'installer et l'utiliser hors connection avec une expérience utilisateur proche de celle d'une application native (mobile ou ordinateur de bureau).

🚀 Installation
---------------

Les PWA permettent une expérience utilisateur semblable aux applications natives sur mobile ou application de bureau. Elles sont installables sur toute plateforme comforme aux standards web et fonctionnent hors connexion.

### ⚡ Installer une PWA sur Android
Une pop up apparaît automatiquement lors du premier chagement de la page. Sinon selectionnez "Ajouter à l'écran d'acceuil"

Sur Android les PWA permettent la reception de notifications push et la synchronisation en arrière-plan entre autres fonctionalités natives.

### ⚡ Installer une PWA sur iOS
Pour installer une PWA sur iOS, il faut ouvrir le menu de partage de Safari et sélectionner l'option "Sur l'écran d'accueil".

Depuis la version 12.2 iOS améliore la prise en charge des PWA, mais Apple est toujours rétissant à les prendre en charge complètement dans la mesure ou elles permettent de contourner l'App Store.

### ⚡ Installer une PWA sur desktop
Pour installer une PWA sur ordinateur de bureau, ouvrez les paramètres de votre navigateur (en haut à droite sur chrome) une option est disponible pour installer l'application.

### ⚡ manifest.json
Pour plus d'informations sur le standard du fichier manifest.json : [json.schemastore.org](http://json.schemastore.orgweb-manifest)

💻 Dépendances
--------------

La **Calculatrice Salaire Net TangoMan** utilise :

- [Vue.js 2.6.10](https://vuejs.org/v2/guide)
- [Bootstrap 4.3.1](https://getbootstrap.com/docs/4.3/getting-started/introduction)
- [sass](https://sass-lang.com)
- [Mocha 3.9.0](https://mochajs.org)
- [Chai 4.1.2](https://www.chaijs.com)
- [GitHub Actions](https://github.com/features/actions)
- Awk
- git
- Make
- Node.js
- npm
- Sass
- Yarn

🔥 Développement
----------------

### ⏳ TL;DR
Pour installer l'environnement de développement et ouvrir la **Calculatrice Salaire Net TangoMan** dans votre navigateur en une seule commande:
```bash
$ make up
```

### 🤖 Environnement de développemnt

Vous aurez besoin de yarn et de "vue-cli"

Vous pouvez entrer les commandes suivante pour installer automatiquement l'environnment de developpement.

```bash
$ make yarn-install
$ make vue-cli-install
```

### 🤖 Pour installer la Calculatrice Salaire Net

Entrez la commande suivante

```bash
$ make install
```

### 🤖 Pour démarrer la Calculatrice Salaire Net dans un serveur local

Entrez la commande suivante

```bash
$ make serve
```

### 🤖 Pour déployer la Calculatrice Salaire Net sur github pages

Entrez la commande suivante

```bash
$ make deploy
```

---

### 🔖 git

#### 🐧 Installer git (Linux)

```bash
$ sudo apt-get install --assume-yes git
```

#### 🏁 Installer git (Windows)

Téléchargez et installez la dernière version à partir de [git-scm.com](https://git-scm.com/download/win)

#### 🍎 Installer git (OSX)

```bash
$ brew install git
```

#### 🔧 Configuration de git

Pousser la branche actuelle uniquement si l'amont existe

```bash
$ git config --global push.default simple
```

Définir vim comme éditeur par défaut de git

```bash
$ git config --global core.editor 'vim'
```

### ⚡ Initialiser les sous-modules

Afin de télécharger des sous-modules de projet, entrez la commande suivante

```bash
$ git submodule update --init --recursive
```

---

### 🛠 Make

#### 🐧 Installer Make (Linux)

Sur une machine sous Linux, entrez la commande suivante

```bash
$ sudo apt-get install --assume-yes make
```

#### 🏁 Installer Make (Windows)

Sur Windows, vous devrez d'abord installer [cygwin](http://www.cygwin.com/) ou [GnuWin make](http://gnuwin32.sourceforge.net/packages/make.htm) pour exécuter le script.

#### 🍎 Install Make (OSX)

Make devrait être disponible par défaut sur OSX, mais vous pouvez le mettre à jour avec la commande suivante

```bash
$ brew install make
```

---

### 🦖 Node.js

#### 🐧 Installer Node.js (Linux)

Sur une machine sous Linux, installez _Node_ globalement avec les commandes suivantes (nécessite _curl_):

```bash
$ curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
$ sudo apt-get install --assume-yes nodejs
```

#### 🏁 Installer Node.js (Windows)

Téléchargez et installez la version LTS à partir de [Node.js](https://nodejs.org/en/download)

#### 🍎 Installer Node.js (OSX)

Téléchargez et installez la version LTS à partir de [Node.js](https://nodejs.org/en/download)

---

### 🦄 Sass

#### 🐧 Installer Sass (Linux)

Sur une machine sous Linux, installez _sass_ globalement avec les commandes suivantes

With yarn:
```bash
$ sudo yarn global add sass
```

With npm:
```bash
$ sudo npm install sass -g
```

---

### 🧶 Yarn

#### 🐧 Installer Yarn (Linux)

Sur une machine sous Linux, installez _yarn_ globalement avec les commandes suivantes (nécessite _curl_):

```bash
$ curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
$ echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
$ sudo apt-get update
$ sudo apt-get install --assume-yes yarn
```

#### 🏁 Installer Yarn (Windows)

Téléchargez et installez la dernière version à partir de: [yarnpkg.com](https://classic.yarnpkg.com/en/docs/install/#windows-stable)

#### 🍎 Installer Yarn (OSX)

Vous pouvez installer Yarn via le gestionnaire de paquets _"Homebrew"_. Cela installera également Node.js s'il n'est pas déjà installé.

```bash
$ brew install yarn
```

---

### 🕶 Vue-Cli

#### 🧶 Installer avec Yarn

Installez _vue-cli_ globalement avec la commande suivante

```bash
$ sudo yarn global add @vue/cli
```

#### 📦 Installer avec npm

Installez _vue-cli_ globalement avec la commande suivante

```bash
$ sudo npm install -g @vue/cli-service-global
```

---

📝 Notes
--------

D'autres calculatices sur le web:
- [salaire-brut-en-net.fr](https://www.salaire-brut-en-net.fr)
- [salairebrutnet.fr](https://www.salairebrutnet.fr)
- [mon-entreprise.fr](https://mon-entreprise.fr/simulateurs)

La calculatrice du gouvernement pour l'impôt sur le revenu:
- [www.impots.gouv.fr](https://www.impots.gouv.fr/portail/simulateurs)

🤝 Contribuer
-------------

Merci pour votre intérêt à apporter votre contribution à **Calculatrice Salaire Net TangoMan**.

Veuillez consulter le [code de conduite](./CODE_OF_CONDUCT.md) et les [directives de contribution](./CONTRIBUTING.md) avant de commencer à travailler sur des fonctionnalités.

Si vous souhaitez ouvrir un rapport de bug, veuillez d'abord vérifier qu'il n'a pas [déjà été signalé](https://github.com/TangoMan75/calculatrice-salaire-net/issues) avant d'en créer un nouveau.

📜 License
----------

Copyrights (c) 2024 &quot;Matthias Morin&quot; &lt;mat@tangoman.io&gt;

[![License](https://img.shields.io/badge/Licence-MIT-green.svg)](LICENSE)
Distribué sous la licence MIT.

Si vous aimez **Calculatrice Salaire Net TangoMan**, mettez une étoile, suivez-moi ou publiez un tweet.

[![GitHub stars](https://img.shields.io/github/stars/TangoMan75/calculatrice-salaire-net?style=social)](https://github.com/TangoMan75/calculatrice-salaire-net/stargazers)
[![GitHub followers](https://img.shields.io/github/followers/TangoMan75?style=social)](https://github.com/TangoMan75)
[![Twitter](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2FTangoMan75%2Fcalculatrice-salaire-net)](https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2FTangoMan75%2Fcalculatrice-salaire-net)

... Et jetez un oeil à mes autres projets.

🙏 Remerciements
----------------

Ce script a été généré avec [makefile-generator](https://github.com/TangoMan75/makefile-generator)
