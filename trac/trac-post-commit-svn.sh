#!/bin/sh
#Svn to add on trac ticket comment
export PYTHON_EGG_CACHE="/projects/trac/developers/.egg-cache"
trac-admin /projects/trac/developers changeset added "$1" "$2"
