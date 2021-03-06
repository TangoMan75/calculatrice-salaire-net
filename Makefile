#/**
# * Calculatrice Salaire Net
# *
# * Run `make` to print help
# * If you want to add a help message for your rule, just add : "## Foo bar", on the previous line
# * use : "### Foobar" to group rules by categories
# * You can pass arguments with this syntax: `make COMMAND PARAMETER=VALUE`
# *
# * @version  0.1.0
# * @author   "Matthias Morin" <mat@tangoman.io>
# * @licence  MIT
# * @link     https://github.com/TangoMan75/calculatrice-salaire-net
# * @link     https://www.linkedin.com/in/morinmatthias
# */

.PHONY: help install serve build tests lint deploy uninstall dev-install 

# Colors
TITLE     = \033[1;42m
CAPTION   = \033[1;44m
BOLD      = \033[1;34m
LABEL     = \033[1;32m
DANGER    = \033[31m
SUCCESS   = \033[32m
WARNING   = \033[33m
SECONDARY = \033[34m
INFO      = \033[35m
PRIMARY   = \033[36m
DEFAULT   = \033[0m
NL        = \033[0m\n

# Local operating system (Windows_NT, Darwin, Linux)
ifeq ($(OS),Windows_NT)
	SYSTEM=$(OS)
else
	SYSTEM=$(shell uname -s)
endif

# app port
port?=8080

## Print this help
help:
	@printf "${TITLE} Calculatrice Salaire Net ${NL}\n"
	@printf "${CAPTION} Infos:${NL}"
	@printf "${PRIMARY} %-12s${INFO} %s${NL}" "system" "$(shell uname -s)"
	@printf "${PRIMARY} %-12s${INFO} %s${NL}" "node"   "$(shell node --version)"
	@printf "${PRIMARY} %-12s${INFO} %s${NL}" "npm"    "$(shell npm --version)"
	@printf "${PRIMARY} %-12s${INFO} %s${NL}" "yarn"   "$(shell yarn --version)"
	@printf "${PRIMARY} %-12s${INFO} %s${NL}" "port"   "${port}"
	@printf "${NL}"

	@printf "${CAPTION} Description:${NL}"
	@printf "${WARNING}  manage Vue.js project${NL}\n"

	@printf "${CAPTION} Usage:${NL}"
	@printf "${WARNING}  make [command] port=[port]${NL}\n"

	@printf "${CAPTION} Commands:${NL}"
	@awk '/^### /{printf"\n${BOLD}%s${NL}",substr($$0,5)} \
	/^[a-zA-Z0-9_-]+:/{HELP="";if(match(PREV,/^## /))HELP=substr(PREV, 4); \
		printf " ${LABEL}%-12s${DEFAULT} ${PRIMARY}%s${NL}",substr($$1,0,index($$1,":")),HELP \
	}{PREV=$$0}' ${MAKEFILE_LIST}

##################################################
### Vue
##################################################

## Install and serve locally
up: yarn-install vue-cli-install install serve

## Install dependencies
install:
	@if [ ! -d node_modules ] && [ -f yarn.lock ]; then \
		printf "${INFO}yarn install${NL}"; \
		yarn install; \
	elif [ ! -d node_modules ]; then \
		printf "${INFO}npm install${NL}"; \
		npm install; \
	fi

## Serve with hot reload at localhost
serve:
	@printf "${INFO}xdg-open http://localhost:${port}${NL}"
	@xdg-open http://localhost:${port}
	@if [ -f yarn.lock ]; then \
		printf "${INFO}yarn serve${NL}"; \
		yarn serve; \
	else \
		printf "${INFO}npm run serve${NL}"; \
		npm run serve; \
	fi

## Build for production with minification
build:
	@printf "${INFO}rm -rf ./dist${NL}"
	@rm -rf ./dist
	@if [ -f yarn.lock ]; then \
		printf "${INFO}yarn build${NL}"; \
		yarn build; \
	else \
		printf "${INFO}npm run build${NL}"; \
		npm run build; \
	fi

## Run unit tests
tests:
	@if [ -f yarn.lock ]; then \
		printf "${INFO}yarn run test:unit${NL}"; \
		yarn run test:unit; \
	else \
		printf "${INFO}npm run test:unit${NL}"; \
		npm run test:unit; \
	fi

## Lint and fix files
lint:
	@if [ -f yarn.lock ]; then \
		printf "${INFO}yarn run lint${NL}"; \
		yarn run lint; \
	else \
		printf "${INFO}npm run lint${NL}"; \
		npm run lint; \
	fi

## Deploy to gh-pages
deploy: build
	@( \
		printf "${INFO}cd dist${NL}"; \
		cd dist; \
		printf "${INFO}git init${NL}"; \
		git init; \
		printf "${INFO}git add -A${NL}"; \
		git add -A; \
		printf "${INFO}git commit -m "$(shell date '+%Y-%m-%d %H:%M:%S')"${NL}"; \
		git commit -m "$(shell date '+%Y-%m-%d %H:%M:%S')"; \
		printf "${INFO}git push -f git@github.com:TangoMan75/calculatrice-salaire-net.git master:gh-pages${NL}"; \
		git push -f git@github.com:TangoMan75/calculatrice-salaire-net.git master:gh-pages; \
	)

## Uninstall app
uninstall:
	@printf "${INFO}rm -rf node_modules${NL}"
	@rm -rf node_modules
	@printf "${INFO}rm -rf dist${NL}"
	@rm -rf dist

##################################################
### Yarn Install Local Env
##################################################

## Install yarn
yarn-install:
ifeq (${SYSTEM}, Linux)
	@if [ -z "$(shell yarn --version 2>/dev/null)" ]; then \
		printf "${INFO}curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -${NL}"; \
		curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -; \
		printf "${INFO}echo 'deb https://dl.yarnpkg.com/debian/ stable main' | sudo tee /etc/apt/sources.list.d/yarn.list${NL}"; \
		echo 'deb https://dl.yarnpkg.com/debian/ stable main' | sudo tee /etc/apt/sources.list.d/yarn.list; \
		printf "${INFO}sudo apt-get update${NL}"; \
		sudo apt-get update; \
		printf "${INFO}sudo apt-get install -y yarn${NL}"; \
		sudo apt-get install -y yarn; \
	else \
		printf "${WARNING}yarn already installed, skipping...${NL}"; \
	fi
endif

## Install vue-cli
vue-cli-install:
ifeq (${SYSTEM}, Linux)
	@if [ -z "$(shell vue --version 2>/dev/null)" ]; then \
		printf "${INFO}sudo yarn global add @vue/cli${NL}"; \
		sudo yarn global add @vue/cli; \
	else \
		printf "${WARNING}vue-cli already installed, skipping...${NL}"; \
	fi
endif

