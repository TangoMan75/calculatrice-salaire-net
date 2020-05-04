Calculatrice Salaire Net TangoMan
=================================

La **Calculatrice Salaire Net TangoMan** permet de convertir votre salaire brut en net horaire, journalier, mensuel, annuel sur une base de 35 heures ou 39 heures par semaine en fonction des charges auxquelles vous êtes soumis et de votre nombre de congés par an.

La **Calculatrice Salaire Net TangoMan** est disponible en mode PWA (Progressive Web App), vous pouvez donc l'installer et l'utiliser hors connection avec une expérience utilisateur proche de celle d'une application native (mobile ou ordinateur de bureau).

La **Calculatrice Salaire Net TangoMan** utilise :
- [Vue.js 2.6.10](https://vuejs.org/v2/guide)
- [Bootstrap 4.3.1](https://getbootstrap.com/docs/4.3/getting-started/introduction)
- [sass](https://sass-lang.com)
- [Mocha 3.9.0](https://mochajs.org)
- [Chai 4.1.2](https://www.chaijs.com)
- [travis-ci](https://travis-ci.org)

[Pour tester l'application c'est ici !](https://tangoman75.github.io/calculatrice-salaire-net).

D'autres calculatices sur le web:
- [salaire-brut-en-net.fr](https://www.salaire-brut-en-net.fr)
- [salairebrutnet.fr](https://www.salairebrutnet.fr)
- [mon-entreprise.fr](https://mon-entreprise.fr/sécurité-sociale/salarié)

La calculatrice du gouvernement pour l'impôt sur le revenu:
- [www.impots.gouv.fr](https://www.impots.gouv.fr/portail/simulateurs)

Progressive Web App
-------------------

Les PWA permettent une expérience utilisateur semblable aux applications natives sur mobile ou application de bureau. Elles sont installables sur toute plateforme comforme aux standards web et fonctionnent hors connexion.

### Installer une PWA sur Android
Une pop up apparaît automatiquement lors du premier chagement de la page. Sinon selectionnez "Ajouter à l'écran d'acceuil"

Sur Android les PWA permettent la reception de notifications push et la synchronisation en arrière-plan entre autres fonctionalités natives.

### Installer une PWA sur iOS
Pour installer une PWA sur iOS, il faut ouvrir le menu de partage de Safari et sélectionner l'option "Sur l'écran d'accueil".

Depuis la version 12.2 iOS améliore la prise en charge des PWA, mais Apple est toujours rétissant à les prendre en charge complètement dans la mesure ou elles permettent de contourner l'App Store.

### Installer une PWA sur desktop
Pour installer une PWA sur ordinateur de bureau, ouvrez les paramètres de votre navigateur (en haut à droite sur chrome) une option est disponible pour installer l'application.

### manifest.json
Pour plus d'informations sur le standard du fichier manifest.json : [json.schemastore.org](http://json.schemastore.orgweb-manifest)

Développement
-------------

### Environnement de développemnt
Vous aurez besoin de yarn
```bash
$ curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
$ echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
$ sudo apt-get update
$ sudo apt-get install -y yarn
```
et de "vue-serve"
```bash
$ sudo npm install -g @vue/cli-service-global
# ou
$ sudo yarn global add @vue/cli
```
Vous pouvez également la commande suivante pour installer automatiquement l'environnment de developpement.
```bash
$ make dev-install
```

### Pour installer la Calculatrice Salaire Net
Entrez la commande suivante
```bash
$ make install
```

### Pour démarrer la Calculatrice Salaire Net dans un serveur local
Entrez la commande suivante
```bash
$ make run
```

### Pour déployer la Calculatrice Salaire Net sur github pages
Entrez la commande suivante
```bash
$ make deploy
```

Intégration Continue
--------------------

[![Build Status](https://travis-ci.org/TangoMan75/calculatrice-salaire-net.svg?branch=master)](https://travis-ci.org/TangoMan75/calculatrice-salaire-net) 
Si vous rencontrez un bug n'hésitez pas à le signaler ici : [Issues](https://github.com/TangoMan75/calculatrice-salaire-net/issues/new)

License
=======

Copyrights (c) 2020 &quot;Matthias Morin&quot; &lt;mat@tangoman.io&gt;

[![License](https://img.shields.io/badge/Licence-MIT-green.svg)](LICENCE)
Distribué sous license MIT.

Si vous aimez la **Calculatrice Salaire Net TangoMan** clickez sur l'étoile, suivez moi ou twittez!

[![GitHub stars](https://img.shields.io/github/stars/TangoMan75/calculatrice-salaire-net?style=social)](https://github.com/TangoMan75/calculatrice-salaire-net/stargazers)
[![GitHub followers](https://img.shields.io/github/followers/TangoMan75?style=social)](https://github.com/TangoMan75)
[![Twitter](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2FTangoMan75%2Fcalculatrice-salaire-net)](https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2FTangoMan75%2Fcalculatrice-salaire-net)

... N'hésitez pas à jetter un oeil à mes autres projets.

[![LinkedIn](https://img.shields.io/static/v1?style=social&logo=linkedin&label=LinkedIn&message=morinmatthias)](https://www.linkedin.com/in/morinmatthias)

