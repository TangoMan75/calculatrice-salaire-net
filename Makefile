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

#--------------------------------------------------
# Colors
#--------------------------------------------------

PRIMARY   = \033[97m
SECONDARY = \033[94m
SUCCESS   = \033[32m
DANGER    = \033[31m
WARNING   = \033[33m
INFO      = \033[95m
LIGHT     = \033[47;90m
DARK      = \033[40;37m
DEFAULT   = \033[0m
EOL       = \033[0m\n

ALERT_PRIMARY   = \033[1;104;97m
ALERT_SECONDARY = \033[1;45;97m
ALERT_SUCCESS   = \033[1;42;97m
ALERT_DANGER    = \033[1;41;97m
ALERT_WARNING   = \033[1;43;97m
ALERT_INFO      = \033[1;44;97m
ALERT_LIGHT     = \033[1;47;90m
ALERT_DARK      = \033[1;40;37m

#--------------------------------------------------
# Color Functions
#--------------------------------------------------

define echo_primary
	@printf "${PRIMARY}%b${EOL}" $(1)
endef
define echo_secondary
	@printf "${SECONDARY}%b${EOL}" $(1)
endef
define echo_success
	@printf "${SUCCESS}%b${EOL}" $(1)
endef
define echo_danger
	@printf "${DANGER}%b${EOL}" $(1)
endef
define echo_warning
	@printf "${WARNING}%b${EOL}" $(1)
endef
define echo_info
	@printf "${INFO}%b${EOL}" $(1)
endef
define echo_light
	@printf "${LIGHT}%b${EOL}" $(1)
endef
define echo_dark
	@printf "${DARK}%b${EOL}" $(1)
endef

define echo_label
	@printf "${SUCCESS}%b ${DEFAULT}" $(1)
endef
define echo_error
	@printf "${DANGER}error: %b${EOL}" $(1)
endef

define alert_primary
	@printf "${EOL}${ALERT_PRIMARY}%64s${EOL}${ALERT_PRIMARY} %-63s${EOL}${ALERT_PRIMARY}%64s${EOL}\n" "" $(1) ""
endef
define alert_secondary
	@printf "${EOL}${ALERT_SECONDARY}%64s${EOL}${ALERT_SECONDARY} %-63s${EOL}${ALERT_SECONDARY}%64s${EOL}\n" "" $(1) ""
endef
define alert_success
	@printf "${EOL}${ALERT_SUCCESS}%64s${EOL}${ALERT_SUCCESS} %-63s${EOL}${ALERT_SUCCESS}%64s${EOL}\n" "" $(1) ""
endef
define alert_danger
	@printf "${EOL}${ALERT_DANGER}%64s${EOL}${ALERT_DANGER} %-63s${EOL}${ALERT_DANGER}%64s${EOL}\n" "" $(1) ""
endef
define alert_warning
	@printf "${EOL}${ALERT_WARNING}%64s${EOL}${ALERT_WARNING} %-63s${EOL}${ALERT_WARNING}%64s${EOL}\n" "" $(1) ""
endef
define alert_info
	@printf "${EOL}${ALERT_INFO}%64s${EOL}${ALERT_INFO} %-63s${EOL}${ALERT_INFO}%64s${EOL}\n" "" $(1) ""
endef
define alert_light
	@printf "${EOL}${ALERT_LIGHT}%64s${EOL}${ALERT_LIGHT} %-63s${EOL}${ALERT_LIGHT}%64s${EOL}\n" "" $(1) ""
endef
define alert_dark
	@printf "${EOL}${ALERT_DARK}%64s${EOL}${ALERT_DARK} %-63s${EOL}${ALERT_DARK}%64s${EOL}\n" "" $(1) ""
endef

#--------------------------------------------------
# System
#--------------------------------------------------

# Local operating system (Windows_NT, Darwin, Linux)
ifeq ($(OS),Windows_NT)
	SYSTEM=$(OS)
else
	SYSTEM=$(shell uname -s)
endif

#--------------------------------------------------

# app port
port?=8080

#--------------------------------------------------

## Print this help
help:
	$(call alert_primary, 'Calculatrice Salaire Net')

	@printf "${CAPTION} Infos:${EOL}"
	@printf "${SUCCESS}  %-12s${PRIMARY} %s${EOL}" "system" "$(shell uname -s)"
	@printf "${SUCCESS}  %-12s${PRIMARY} %s${EOL}" "node"   "$(shell node --version)"
	@printf "${SUCCESS}  %-12s${PRIMARY} %s${EOL}" "npm"    "$(shell npm --version)"
	@printf "${SUCCESS}  %-12s${PRIMARY} %s${EOL}" "yarn"   "$(shell yarn --version)"
	@printf "${SUCCESS}  %-12s${PRIMARY} %s${EOL}" "port"   "${port}"
	@printf "${EOL}"

	@printf "${WARNING}Description${EOL}"
	@printf "${PRIMARY}  manage Vue.js project ${EOL}\n"

	@printf "${WARNING}Usage${EOL}"
	@printf "${PRIMARY}  make [command] `awk -F '?' '/^[ \t]+?[a-zA-Z0-9_-]+[ \t]+?\?=/{gsub(/[ \t]+/,"");printf"%s=[%s]\n",$$1,$$1}' ${MAKEFILE_LIST}|sort|uniq|tr '\n' ' '`${EOL}\n"

	@printf "${WARNING}Options${EOL}"
	$(eval CONFIG:=$(shell awk -F '?' '/^[ \t]+?[a-zA-Z0-9_-]+[ \t]+?\?=/{gsub(/[ \t]+/,"");printf"$${SUCCESS} %-16s$${DEFAULT}$${PRIMARY} $${%s}$${EOL}\n",$$1,$$1}' ${MAKEFILE_LIST}|sort|uniq))
	@printf " ${CONFIG}\n"

	@printf "${WARNING}Commands${EOL}"
	@awk '/^### /{printf"\n${WARNING}%s${EOL}",substr($$0,5)} \
	/^[a-zA-Z0-9_-]+:/{HELP="";if(match(PREV,/^## /))HELP=substr(PREV, 4); \
		printf "  ${SUCCESS}%-16s${DEFAULT} ${PRIMARY}%s${EOL}",substr($$1,0,index($$1,":")-1),HELP \
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

## Install dependencies with yarn
install-yarn:
	printf "${INFO}yarn install${NL}"; \
	yarn install; \

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
		printf "${INFO}git push -f git@github.com:TangoMan75/calculatrice-salaire-net.git main:gh-pages${NL}"; \
		git push -f git@github.com:TangoMan75/calculatrice-salaire-net.git main:gh-pages; \
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

