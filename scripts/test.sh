#!/bin/sh

for file in $( ls -A | grep -vE '\.exclude*|\.git$|\.gitignore|.*.md' ) ; do
    echo ~/$(file) ~/$(file).orig

    
done