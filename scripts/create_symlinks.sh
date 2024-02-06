#!/bin/sh
set -e

BACKUP_FOLDER="$HOME/.dotfiles_backup"

datetime_string=$(date +%Y%m%d_%H%M%S)


echo "$1"

# backup is on by default
backup=1

# check if --no-backup flag was passed
if [ "$1" = "--no-backup" ] ; then
    backup=0
    echo "Running with --no-backup."
    echo "I hope you know what you're doing. Do you want to proceed? (y/n)"
    read -r resp

    # If response is NOT y or Y cancel
    if ! [ "$resp" = 'y' ] || [ "$resp" = 'Y' ]; then
        echo "User decided to abort!"
        exit 0
    fi
fi

make_backup_folder () {
    if [ ! -d "$BACKUP_FOLDER" ]; then
        echo "Creating backup folder '$BACKUP_FOLDER'"
        mkdir "$BACKUP_FOLDER"
    fi

    echo "Creating backup folder '$BACKUP_FOLDER/$datetime_string'"
    mkdir "$BACKUP_FOLDER"/"$datetime_string"
}

link () {
    file_to_link="$1"

    if [ -f "$HOME/$file_to_link" ]; then
        echo "File $HOME/$file_to_link already exist."
        if [ "$backup" ]; then
            cp "$HOME/$file_to_link" "$BACKUP_FOLDER/$datetime_string/$file_to_link"
            echo "backed up $HOME/$file_to_link to $BACKUP_FOLDER/$datetime_string/$file_to_link"
        fi

        # remove current file
        echo "Removing existing $HOME/$file_to_link"
        rm "$HOME/$file_to_link"
    fi

    # link file from repo to home directory
    ln -sv "$PWD/$file_to_link" "$HOME/$file_to_link"
    echo "Linked $PWD/$file_to_link to $HOME/$file_to_link"
}


# init
if [ "$backup" ]; then
    make_backup_folder
fi

# Loop over dotfiles specified in this repo and link each of them.
# TODO - Update this list if extra files are added
for f in $PWD/{Brewfile,.gitconfig,.p10k.zsh,.zprofile,.zshrc}
do
    file_name="${f##*/}"
    echo "Processing File - $file_name"
    link "$file_name"
done