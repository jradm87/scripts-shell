#!/bin/sh
#Script git para interagir chamados trac, By Junior
tracenv=/projects/trac/developers     # change with your Trac environment's path
repos=suporte-git                   # change with your repository's name
while read oldrev newrev refname; do
    if [ "$oldrev" = 0000000000000000000000000000000000000000 ]; then
        git rev-list --reverse "$newrev" --
    else
        git rev-list --reverse "$newrev" "^$oldrev" --
    fi | xargs trac-admin "$tracenv" changeset added "$repos"
done

