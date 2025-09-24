#!/usr/bin/env bash
#
#  blsd: Build Latest SigDigger, easily
#
#  Copyright (C) 2021 Gonzalo José Carracedo Carballal
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Lesser General Public License as
#  published by the Free Software Foundation, either version 3 of the
#  License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful, but
#  WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public
#  License along with this program.  If not, see
#  <http://www.gnu.org/licenses/>
#
#

DISTROOT="$PWD"
BLSDROOT="$DISTROOT/blsd-dir"

function try()
{
    echo -en "[  ....  ] $1 "
    shift
    
    STDOUT="$DISTROOT/$1-$$-stdout.log"
    STDERR="$DISTROOT/$1-$$-stderr.log"
    "$@" > "$STDOUT" 2> "$STDERR"
    
    if [ $? != 0 ]; then
	echo -e "\r[ \033[1;31mFAILED\033[0m ]"
	echo
	echo "Standard output and error were saved respectively in:"
	echo " - $STDOUT"
	echo " - $STDERR"
	echo
	echo "Fix errors and try again"
	echo
	exit 1
    fi

    echo -e "\r[   \033[1;32mOK\033[0m   ]"
    rm "$STDOUT"
    rm "$STDERR"
}

function locate_curl()
{
    if which curl; then
	export HAVE_CURL=1
	export CURL_PATH=`which curl`
	return 0
    fi

    exit 1
}

function locate_wget()
{
    if which wget; then
	export HAVE_WGET=1
	export WGET_PATH=`which wget`
	return 0
    fi

    return 1
}

function locate_downloader()
{
    if locate_wget; then
	return 0
    fi

    if locate_curl; then
	return 0
    fi

    echo >&2 'Cannot locate neither wget nor curl. Cannot download files.'

    return 0
}

function download_script()
{
    scrname=`basename "$1"`
    if [[ "x$scrname" == "x" ]]; then
	scrname="discard"
    fi
    
    DEST="$BLSDROOT/$scrname"
    if [[ "x$HAVE_WGET" != "x" ]]; then
	"$WGET_PATH" "$1" -O "$DEST"
    elif [[ "x$HAVE_CURL" != "x" ]]; then
	"$CURL_PATH" "$1" > "$DEST"
    else
	echo >&2 'No download script found.' 
    fi
    
    return $?
}

echo -e 'Welcome to \033[1;32mBLSD\033[0m, a script to \033[1;32mb\033[0muild the \033[1;32ml\033[0matest \033[1;32mS\033[0mig\033[1;32mD\033[0migger directly from the \033[1md\033[0mevelopment branch (now master).'
echo
echo -e '\033[1mPlease note:\033[0m You are about to build SigDigger with the latest changes in'
echo    'the master branch. This means lots of fresh and half-implemented features whose stability'
echo -n 'has not been thoroughly tested. Are you sure you want to proceed? [Y/n] '


try 'Detecting downloader tool' locate_downloader
try 'Cleaning previous builds (if any)' rm -Rfv "$BLSDROOT"
try "Creating download dir ($BLSDROOT)" mkdir -p "$BLSDROOT"
try 'Testing Internet connection' download_script 'http://example.com'
try 'Downloading dist-common.sh (master)' download_script 'https://raw.githubusercontent.com/BatchDrake/SigDigger/master/Scripts/dist-common.sh'
try 'Downloading build.sh (master)' download_script 'https://raw.githubusercontent.com/BatchDrake/SigDigger/master/Scripts/build.sh'
try 'Setting permissions' chmod a+x "$BLSDROOT"/*.sh

echo
echo ' * * * All scripts downloaded, starting build! * * *'
echo 
cd "$BLSDROOT"
if ./build.sh "$@"; then
    echo ' * * * Build successful! * * *'
    echo
    
    try 'Moving deploy directory to its final location' mv deploy-root "SigDigger"
    try 'Cleaning up download directory' rm -Rfv *.com build.sh dist-common.sh build-root
    echo
    echo 'SigDigger (along with all its dependencies) has been built to:'
    echo
    echo -e "  \033[1m$BLSDROOT/SigDigger/\033[0m"
    echo 
    echo -e 'Just place this directory to wherever you want, cd to it and run ./\033[1;32mSigDigger\033[0m'
fi
