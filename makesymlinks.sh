#!/bin/bash
############################
# .makesymlinks.sh
# Backs up existing dotfiles (if required) then creates symlinks to all the dotfiles contained within the
# directory this script was invoked from and the neovim config init.vim (usually ~/.dotfiles)
############################
# Updated 28/10/19 to handle neovim config

########## Variables

dir=~/dotfiles                    		# dotfiles directory
olddir=~/dotfiles_old             		# old dotfiles backup directory
# egrep -e gives multiline output despite the console output
files=$(ls -A | egrep -e '^(\..+|init.vim)' | egrep -v git)  # dotfiles in the directory the script was invoked from (usually ~/.dotfiles)

##########

# Check if user wants to create backups
while true; do
	read -p "Do you want to backup any existing dotfiles to $olddir? (Yes/No)" yn
    
	mkdir $olddir 2> /dev/null

	case $yn in
		[Yy]* ) for file in $files; do
				if [ $file == init.vim ] && [ -e ~/.config/nvim/init.vim ]; then
					echo -e "Copying  ~/.config/nvim/init.vim to $olddir"
					cp -L -R ~/.config/nvim/init.vim $olddir/
				elif [ -e ~/$file ]; then
					echo -e "Copying  ~/$file to $olddir"
					cp -L -R ~/$file $olddir/
				fi
			done;
			break;;
		[Nn]* ) break;;
		* ) echo -e "Please answer yes or no.";;
    	esac
done

# Create symlinks
for file in $files; do
    if [ $file == init.vim ]; then
	    echo -e "Creating symlink to $file in ~/.config/nvim/"
	    ln -s -f $dir/init.vim ~/.config/nvim/init.vim
    else
	    echo -e "Creating symlink to $file in home directory."
	    ln -s -f $dir/$file ~/$file
    fi
done

# Prompt to install Vundle and plugins, if ,vimrc exists
if [ -e ~/.vimrc ]; then
	while true; do
		read -p "Do you want to install Vundle and plugins? (Yes/No)" yn
	    case $yn in
		[Yy]* ) 
			if [ -d ~/.vim/bundle/Vundle.vim ]; then
				while true; do
					read -p "Do you want to backup your existing Vundle dir? (Yes/No)" yn
				    case $yn in
					[Yy]* ) cp -fR ~/.vim/bundle/Vundle.vim $olddir; break;;
					[Nn]* ) break;;
					* ) echo -e "Please answer yes or no.";;
				    esac
				done
			fi

			rm -fR ~/.vim/bundle/Vundle.vim	
			git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim; vim +PluginInstall +qall; break;;
		[Nn]* ) break;;
		* ) echo -e "Please answer yes or no.";;
	    esac
	done
fi

# Prompt to restart bash, if config exists
if [ -e ~/.bashrc ]; then
	while true; do
		read -p "Do you want to restart bash? (Yes/No)" yn
	    case $yn in
		[Yy]* ) exec bash; break;;
		[Nn]* ) exit;;
		* ) echo -e "Please answer yes or no.";;
	    esac
	done
fi
