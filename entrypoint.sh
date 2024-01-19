#!/bin/sh
set -e

#/*
# * This script is based on TangoMan Shoe Shell Microframework version 0.8.0-xs
# *
# * This file is distributed under to the MIT license.
# *
# * Copyright (c) 2023 "Matthias Morin" <mat@tangoman.io>
# *
# * Permission is hereby granted, free of charge, to any person obtaining a copy
# * of this software and associated documentation files (the "Software"), to deal
# * in the Software without restriction, including without limitation the rights
# * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# * copies of the Software, and to permit persons to whom the Software is
# * furnished to do so, subject to the following conditions:
# *
# * The above copyright notice and this permission notice shall be included in all
# * copies or substantial portions of the Software.
# *
# * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# * SOFTWARE.
# *
# * Source code is available here: https://github.com/TangoMan75/shoe
# */

#/**
# * Calculatrice Salaire Net
# *
# * La **Calculatrice Salaire Net TangoMan** permet de convertir votre salaire brut en net horaire,
# * journalier, mensuel, annuel sur une base de 35 heures ou 39 heures par semaine en fonction des
# * charges auxquelles vous êtes soumis et de votre nombre de congés par an.
# *
# * @author  "Matthias Morin" <mat@tangoman.io>
# * @version 0.8.0-xs
# * @link    https://github.com/TangoMan75/calculatrice-salaire-net
# */

#--------------------------------------------------
# Place your constants after this line
#--------------------------------------------------

## Container name
CONTAINER=calculatrice

## App port
PORT=8080

## Package manager
PACKAGE_MANAGER=npm

#--------------------------------------------------
# Place your functions after this line
#--------------------------------------------------

## Install and serve locally
up() {
    install
    serve
}

## Install dependencies
install() {
    if [ ! -d node_modules ]; then
        echo_info "${PACKAGE_MANAGER} install\n"
        eval "${PACKAGE_MANAGER}" install
    fi
}

## Serve with hot reload at localhost
serve() {
    install

    if [ "${PACKAGE_MANAGER}" = yarn ]; then
        echo_info "yarn serve\n"
        yarn serve
    elif [ "${PACKAGE_MANAGER}" = npm ]; then
        echo_info "npm run serve\n"
        npm run serve
    fi
}

## Build for production with minification
build() {
    echo_info 'rm -rf ./dist\n'
    rm -rf ./dist

    if [ "${PACKAGE_MANAGER}" = yarn ]; then
        echo_info "yarn build\n"
        yarn build
    elif [ "${PACKAGE_MANAGER}" = npm ]; then
        echo_info "npm run build\n"
        npm run build
    fi
}

## Run unit tests
tests() {
    echo_info "${PACKAGE_MANAGER} run test:unit\n"
    eval "${PACKAGE_MANAGER}" run test:unit
}

## Lint and fix files
lint() {
    echo_info "${PACKAGE_MANAGER} run lint\n"
    eval "${PACKAGE_MANAGER}" run lint
}

## Deploy to gh-pages
deploy() {
    if [ ! -d ./dist ]; then
        echo_error "\"$(basename "${0}")\" ./dist folder not found, please build first\n"
        return 1
    fi

    if [ -z "$(command -v git)" ]; then
        echo_error "\"$(basename "${0}")\" requires git, try: 'sudo apt-get install -y git'\n"
        return 1
    fi

    (
        echo_info 'cd dist\n'
        cd dist

        echo_info 'git init\n'
        git init

        echo_info 'git add -A\n'
        git add -A

        echo_info "git commit -m \"$(date '+%Y-%m-%d %H:%M:%S')\"\n"
        git commit -m "$(date '+%Y-%m-%d %H:%M:%S')"

        echo_info 'git push -f git@github.com:TangoMan75/calculatrice-salaire-net.git main:gh-pages\n'
        git push -f git@github.com:TangoMan75/calculatrice-salaire-net.git main:gh-pages
    )
}

## Uninstall app
uninstall() {
    echo_info 'rm -rf node_modules\n'
    rm -rf node_modules

    echo_info 'rm -rf dist\n'
    rm -rf dist
}

## Start container
start() {
    echo_info 'docker compose up -d\n'
    docker compose up -d
}

#--------------------------------------------------
# Place your private functions after this line
#--------------------------------------------------

# ## Place here commands you need executed first every time (optional)
# _before() {
#     if [ -z "$(command -v yarn)" ]; then
#         echo_error "\"$(basename "${0}")\" requires yarn, try: 'sudo apt-get install -y yarn'\n"
#         return 1
#     fi
# }

#--------------------------------------------------
# Semantic colors set
#--------------------------------------------------

# shellcheck disable=SC2034
{
    PRIMARY='\033[97m'; SECONDARY='\033[94m'; SUCCESS='\033[32m'; DANGER='\033[31m'; WARNING='\033[33m'; INFO='\033[95m'; LIGHT='\033[47;90m'; DARK='\033[40;37m'; DEFAULT='\033[0m'; EOL='\033[0m\n';
    ALERT_PRIMARY='\033[1;104;97m'; ALERT_SECONDARY='\033[1;45;97m'; ALERT_SUCCESS='\033[1;42;97m'; ALERT_DANGER='\033[1;41;97m'; ALERT_WARNING='\033[1;43;97m'; ALERT_INFO='\033[1;44;97m'; ALERT_LIGHT='\033[1;47;90m'; ALERT_DARK='\033[1;40;37m';
}

echo_primary()   { printf "%b%b${DEFAULT}" "${PRIMARY}"   "${*}"; }
echo_secondary() { printf "%b%b${DEFAULT}" "${SECONDARY}" "${*}"; }
echo_success()   { printf "%b%b${DEFAULT}" "${SUCCESS}"   "${*}"; }
echo_danger()    { printf "%b%b${DEFAULT}" "${DANGER}"    "${*}"; }
echo_warning()   { printf "%b%b${DEFAULT}" "${WARNING}"   "${*}"; }
echo_info()      { printf "%b%b${DEFAULT}" "${INFO}"      "${*}"; }
echo_light()     { printf "%b%b${DEFAULT}" "${LIGHT}"     "${*}"; }
echo_dark()      { printf "%b%b${DEFAULT}" "${DARK}"      "${*}"; }

echo_label()     { if [ $# -eq 2 ]; then printf "%b%-${1}s ${DEFAULT}" "${SUCCESS}" "$2"; else printf "%b%b ${DEFAULT}" "${SUCCESS}" "${*}"; fi }
echo_error()     { printf "%berror: %b${DEFAULT}" "${DANGER}"  "${*}"; }

alert_primary()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_PRIMARY}"   '' "${ALERT_PRIMARY}"   "${*}" "${ALERT_PRIMARY}"   ''; }
alert_secondary() { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_SECONDARY}" '' "${ALERT_SECONDARY}" "${*}" "${ALERT_SECONDARY}" ''; }
alert_success()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_SUCCESS}"   '' "${ALERT_SUCCESS}"   "${*}" "${ALERT_SUCCESS}"   ''; }
alert_danger()    { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_DANGER}"    '' "${ALERT_DANGER}"    "${*}" "${ALERT_DANGER}"    ''; }
alert_warning()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_WARNING}"   '' "${ALERT_WARNING}"   "${*}" "${ALERT_WARNING}"   ''; }
alert_info()      { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_INFO}"      '' "${ALERT_INFO}"      "${*}" "${ALERT_INFO}"      ''; }
alert_light()     { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_LIGHT}"     '' "${ALERT_LIGHT}"     "${*}" "${ALERT_LIGHT}"     ''; }
alert_dark()      { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_DARK}"      '' "${ALERT_DARK}"      "${*}" "${ALERT_DARK}"      ''; }

#--------------------------------------------------
# Self documentation
#--------------------------------------------------

### Help

## Print this help (default)
help() {
    _padding=$(_get_padding)

    _print_title       "$(_get_docbloc_title)"
    _print_infos       "${_padding}"
    _print_description "$(_get_docbloc_description)"
    _print_usage
    _print_commands    "${_padding}"
}

#--------------------------------------------------

_print_title() {
    printf "${EOL}${ALERT_PRIMARY}%64s${EOL}${ALERT_PRIMARY} %-63s${EOL}${ALERT_PRIMARY}%64s${EOL}\n" '' "$1" '';
}

_print_infos() {
    # $1 = padding
    if [ -z "$1" ]; then set -- 12; fi
    printf "%bInfos:%b\n" "${WARNING}" "${DEFAULT}"
    printf "${SUCCESS}  %-$1s ${DEFAULT}%s\n" 'author'  "$(_get_docbloc 'author')"
    printf "${SUCCESS}  %-$1s ${DEFAULT}%s\n" 'version' "$(_get_docbloc 'version')"
    printf "${SUCCESS}  %-$1s ${DEFAULT}%s\n" 'link'    "$(_get_docbloc 'link')"
    printf '\n'
}

_print_description() {
    printf "%bDescription:%b\n" "${WARNING}" "${DEFAULT}"
    printf "\033[97m  %s${EOL}\n" "$(printf '%s' "$1" | fold -w 64 -s)"
}

_print_usage() {
    printf "%bUsage:%b\n" "${WARNING}" "${DEFAULT}"
    printf "${INFO}  sh %s${INFO} [${SUCCESS}command${INFO}]${DEFAULT}\n\n" "$(basename "${0}")"
}

_print_commands() {
    # $1 = padding
    if [ -z "$1" ]; then set -- 12; fi
    printf "%bCommands:%b\n" "${WARNING}" "${DEFAULT}"
    awk "/^### /{printf\"\n${WARNING}%s:${EOL}\",substr(\$0,5)}
        /^(function )? *[a-zA-Z0-9_]+ *\(\) *\{/ {
        sub(\"^function \",\"\"); gsub(\"[ ()]\",\"\");
        FUNCTION = substr(\$0, 1, index(\$0, \"{\"));
        sub(\"{\$\", \"\", FUNCTION);
        if (substr(PREV, 1, 3) == \"## \" && substr(\$0, 1, 1) != \"_\")
        printf \"${SUCCESS}  %-$1s ${DEFAULT}%s\n\", FUNCTION, substr(PREV, 4)
    } { PREV = \$0 }" "$0"
    printf '\n'
}

#--------------------------------------------------
# Docbloc parsing
#--------------------------------------------------

_get_docbloc_title() {
    awk '/^#\/\*\*$/,/^# \*\/$/{i+=1; if (i==2) print substr($0, 5)}' "$0"
}

_get_docbloc_description() {
    awk '/^# \* @/ {i=2} /^#\/\*\*$/,/^# \*\/$/{i+=1; if (i>3) printf "%s ", substr($0, 5)}' "$0"
}

_get_docbloc() {
    awk -v TAG="$1" '/^#\/\*\*$/,/^# \*\/$/{if($3=="@"TAG){for(i=4;i<=NF;++i){printf "%s ",$i}}}' "$0"
}

_get_padding() {
    awk -F '=' '/^[a-zA-Z0-9_]+=.+$/ { MATCH = $1 }
    /^(function )? *[a-zA-Z0-9_]+ *\(\) *\{/ {
        sub("^function ",""); gsub("[ ()]","");
        MATCH = substr($0, 1, index($0, "{"));
        sub("{$", "", MATCH);
    } { if (substr(PREV, 1, 3) == "## " && substr(MATCH, 1, 1) != "_" && length(MATCH) > LENGTH) LENGTH = length(MATCH) }
    { PREV = $0 } END { print LENGTH+1 }' "$0"
}

#--------------------------------------------------
# Core
#--------------------------------------------------

_get_functions() {
    # this regular expression matches functions with either bash or sh syntax
    awk '/^(function )? *[a-zA-Z0-9_]+ *\(\) *\{/ {
        sub("^function ",""); gsub("[ ()]","");   # remove leading "function ", round brackets and extra spaces
        FUNCTION = substr($0, 1, index($0, "{")); # truncate string after opening curly brace
        sub("{$", "", FUNCTION);                  # remove trailing curly brace
        if (substr(PREV, 1, 3) == "## " && substr($0, 1, 1) != "_") print FUNCTION
    } { PREV = $0 }' "$0"
}

#--------------------------------------------------
# Main loop
#--------------------------------------------------

_main() {
    if [ $# -lt 1 ]; then
        help
        exit 0
    fi

    # if [ -n "$(command -v _before)" ]; then _before; fi

    _execute=''
    for _argument in "$@"; do
        _is_valid=false
        for _function in $(_get_functions); do
            # get shorthand character
            _shorthand="$(printf '%s' "${_function}" | awk '{$0=substr($0, 1, 1); print}')"
            if [ "${_argument}" = "${_function}" ] || [ "${_argument}" = "${_shorthand}" ]; then
                # append argument to the execute stack
                _execute="${_execute} ${_function}"
                _is_valid=true
                break
            fi
        done
        # unknown parameters will raise errors
        if [ "${_is_valid}" = false ]; then
            printf "${DANGER}error: \"%s\" is not a valid command${EOL}" "${_argument}"
            exit 1
        fi
    done

    for _function in ${_execute}; do
        eval "${_function}"
    done
}

_main "$@"
