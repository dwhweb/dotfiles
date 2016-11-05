#!/bin/bash
############################
# .makesymlinks.sh
# Backs up existing dotfiles (if required) then creates symlinks to all the dotfiles contained within the
# directory this script was invoked from (usually ~/.dotfiles)
############################

########## Variables

dir=~/dotfiles                    		# dotfiles directory
olddir=~/dotfiles_old             		# old dotfiles backup directory
files=$(ls -A | egrep -e '^\.' | egrep -v git)  # dotfiles in the directory the script was invoked from (usually ~/.dotfiles)

##########

# Check if user wants to create backups
while true; do
	read -p "Do you want to backup any existing dotfiles to $olddir? (Yes/No)" yn
    
	mkdir $olddir 2> /dev/null

	case $yn in
		[Yy]* ) for file in $files; do
				if [ -e ~/$file ]; then
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
    echo -e "Creating symlink to $file in home directory."
    ln -s -f $dir/$file ~/$file
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
