#!/bin/sh

# TODO - Change this to work for my repo
# TODO - decide between symlink or rsync 

echo "$1"

backup=1
if [ "$1" = "--no_backup" ] ; then
    backup=0
fi

# Initialize a few things
init () {
	echo "Making a Projects folder in $PATH_TO_PROJECTS if it doesn't already exist"
	mkdir -p "$PATH_TO_PROJECTS"
	echo "Making a Playground folder in $PATH_TO_PLAYGROUND if it doesn't already exist"
	mkdir -p "$PATH_TO_PLAYGROUND"
}

# TODO : Delete symlinks to deleted files
# Is this where rsync shines?
# TODO - add support for -f and --force
link () {
	echo "This utility will symlink the files in this repo to the home directory"
	echo "Proceed? (y/n)"
	read resp

    echo "$backup"

	# TODO - regex here?
	if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
        # If the backup option is set create a backup of each of the dotfiles to nbe replaced
        if [ backup ]; then
            echo "Backing up original dotfiles"
            for file in $( ls -A | grep -vE '\.exclude*|\.git$|\.gitignore|.*.md|scripts' ) ; do
                mv ~/$(file) ~/$(file).orig
                # mv ../testing_dotfiles/"$file" ../testing_dotfiles/"$file".orig
            done
        fi
        # Create symlinks
		for file in $( ls -A | grep -vE '\.exclude*|\.git$|\.gitignore|.*.md|scripts' ) ; do
			ln -sv "$PWD/$file" "$HOME"
			# ln -sv "$PWD/$file" "$PWD/../testing_dotfiles"

		done
		# TODO: source files here?
		echo "Symlinking complete"
	else
		echo "Symlinking cancelled by user"
		return 1
	fi
}

install_tools () {
    echo "Do you want to install tools? (y/n)"
    read resp

    if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
        echo "Installing tools"
        # z
        echo "Do you want to install Z? (y/n)"
        read resp
        if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
            echo "dowloading z from https://raw.githubusercontent.com/rupa/z/master/z.sh"
            cd ~ && wget https://raw.githubusercontent.com/rupa/z/master/z.sh
        fi

        # fzf
        echo "Do you want to install fzf? (y/n)"
        read resp
        if [ "$resp" = "y" -o "$resp" = "Y" ] ; then
            echo "Installing fzf with homebrew"
            brew install fzf

            # To install useful key bindings and fuzzy completion:
            $(brew --prefix)/opt/fzf/install
        fi

        # Shellcheck
        echo "Do you want to install Shellcheck? (y/n)"
        read resp
        if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
            echo "Installing Shellcheck with homebrew"
            brew install shellcheck
        fi
    else
        echo "Skipping tool installation"
    fi
}

# init
link
install_tools