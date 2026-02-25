## Calculatrice Salaire Net
##
## La **Calculatrice Salaire Net TangoMan** permet de convertir votre salaire brut en net horaire, journalier, mensuel, annuel sur une base de 35 heures ou 39 heures par semaine en fonction des charges auxquelles vous êtes soumis et de votre nombre de congés par an.
##
## @version 1.1.0
## @author  "Matthias Morin" <mat@tangoman.io>
## @license
## @link    https://github.com/TangoMan75/calculatrice-salaire-net

.PHONY: help up serve build deploy install uninstall permissions requirements start stop self_install self_uninstall

##################################################
## Colors
##################################################

_PRIMARY   = \033[97m
_SECONDARY = \033[94m
_SUCCESS   = \033[32m
_DANGER    = \033[31m
_WARNING   = \033[33m
_INFO      = \033[95m
_DEFAULT   = \033[0m
_EOL       = \033[0m\n

_ALERT_PRIMARY   = \033[1;104;97m
_ALERT_SECONDARY = \033[1;45;97m
_ALERT_SUCCESS   = \033[1;42;97m
_ALERT_DANGER    = \033[1;41;97m
_ALERT_WARNING   = \033[1;43;97m
_ALERT_INFO      = \033[1;44;97m

##################################################
## Color Functions
##################################################

define _echo_primary
	@printf "${_PRIMARY}%b${_EOL}" $(1)
endef
define _echo_secondary
	@printf "${_SECONDARY}%b${_EOL}" $(1)
endef
define _echo_success
	@printf "${_SUCCESS}%b${_EOL}" $(1)
endef
define _echo_danger
	@printf "${_DANGER}%b${_EOL}" $(1)
endef
define _echo_warning
	@printf "${_WARNING}%b${_EOL}" $(1)
endef
define _echo_info
	@printf "${_INFO}%b${_EOL}" $(1)
endef

define _alert_primary
	@printf "${_EOL}${_ALERT_PRIMARY}%64s${_EOL}${_ALERT_PRIMARY} %-63s${_EOL}${_ALERT_PRIMARY}%64s${_EOL}\n" "" $(1) ""
endef
define _alert_secondary
	@printf "${_EOL}${_ALERT_SECONDARY}%64s${_EOL}${_ALERT_SECONDARY} %-63s${_EOL}${_ALERT_SECONDARY}%64s${_EOL}\n" "" $(1) ""
endef
define _alert_success
	@printf "${_EOL}${_ALERT_SUCCESS}%64s${_EOL}${_ALERT_SUCCESS} %-63s${_EOL}${_ALERT_SUCCESS}%64s${_EOL}\n" "" $(1) ""
endef
define _alert_danger
	@printf "${_EOL}${_ALERT_DANGER}%64s${_EOL}${_ALERT_DANGER} %-63s${_EOL}${_ALERT_DANGER}%64s${_EOL}\n" "" $(1) ""
endef
define _alert_warning
	@printf "${_EOL}${_ALERT_WARNING}%64s${_EOL}${_ALERT_WARNING} %-63s${_EOL}${_ALERT_WARNING}%64s${_EOL}\n" "" $(1) ""
endef
define _alert_info
	@printf "${_EOL}${_ALERT_INFO}%64s${_EOL}${_ALERT_INFO} %-63s${_EOL}${_ALERT_INFO}%64s${_EOL}\n" "" $(1) ""
endef

##################################################
## Help
##################################################

## Print this help
help:
	$(call _alert_primary, "Calculatrice Salaire Net")

	@printf "${_WARNING}Description:${_EOL}"
	@printf "${_PRIMARY}  La **Calculatrice Salaire Net TangoMan** permet de convertir votre salaire brut en net horaire, journalier, mensuel, annuel sur une base de 35 heures ou 39 heures par semaine en fonction des charges auxquelles vous êtes soumis et de votre nombre de congés par an. ${_EOL}\n"

	@printf "${_WARNING}Usage:${_EOL}"
	@printf "${_PRIMARY}  make [command]${_EOL}\n"

	@printf "${_WARNING}Commands:${_EOL}"
	@awk '/^### /{printf"\n${_WARNING}%s${_EOL}",substr($$0,5)} \
	/^[a-zA-Z0-9_-]+:/{HELP="";if( match(PREV,/^## /))HELP=substr(PREV,4); \
		printf "${_SUCCESS}  %-12s  ${_PRIMARY}%s${_EOL}",substr($$1,0,index($$1,":")-1),HELP \
	}{PREV=$$0}' ${MAKEFILE_LIST}

##################################################
### App
##################################################

## Install and serve locally
up:
	@printf "${_INFO}sh entrypoint.sh start install serve${_EOL}"
	@sh entrypoint.sh start install serve

## Serve with hot reload at localhost
serve:
	@printf "${_INFO}docker exec calculatrice sh entrypoint.sh serve${_EOL}"
	@docker exec calculatrice sh entrypoint.sh serve

## Build app to "dist" folder
build:
	@printf "${_INFO}docker exec calculatrice sh entrypoint.sh build${_EOL}"
	@docker exec calculatrice sh entrypoint.sh build

## Deploy "build" folder to "gh-pages"
deploy:
	@printf "${_INFO}sh entrypoint.sh permissions deploy${_EOL}"
	@sh entrypoint.sh permissions deploy

##################################################
### Install
##################################################

## Install app
install:
	@printf "${_INFO}docker exec calculatrice sh entrypoint.sh install${_EOL}"
	@docker exec calculatrice sh entrypoint.sh install

## Uninstall app
uninstall:
	@printf "${_INFO}docker exec calculatrice sh entrypoint.sh uninstall${_EOL}"
	@docker exec calculatrice sh entrypoint.sh uninstall

## Install app
permissions:
	@printf "${_INFO}sh entrypoint.sh permissions${_EOL}"
	@sh entrypoint.sh permissions

## Check requirements
requirements:
	@printf "${_INFO}docker exec calculatrice sh entrypoint.sh requirements${_EOL}"
	@docker exec calculatrice sh entrypoint.sh requirements

##################################################
### Docker
##################################################

## Start docker stack
start:
	@printf "${_INFO}sh entrypoint.sh start${_EOL}"
	@sh entrypoint.sh start

## Stop docker stack
stop:
	@printf "${_INFO}sh entrypoint.sh stop${_EOL}"
	@sh entrypoint.sh stop

##################################################
### Self Install
##################################################

## Install script and enable autocompletion
self_install:
	@printf "${_INFO}sh entrypoint.sh self_install${_EOL}"
	@sh entrypoint.sh self_install

## Uninstall script from system
self_uninstall:
	@printf "${_INFO}sh entrypoint.sh self_uninstall${_EOL}"
	@sh entrypoint.sh self_uninstall


