.dot
====

Dotfiles. There are many like them, but these ones are mine.

YADM migration in progress.

Installation
------------

To install in a clean home directory:

	git clone git@github.com:Fodaro/.dot.git
	git submodule update --init
	cd .dot/
	chmod +x deploy.py
	./deploy.py
	vim +PluginInstall +qall

Using for your own dotfiles
---------------------------

To use with your own dotfiles, clone the infrastructure branch, create a branch for your own dotfiles and merge the infrastructure branch into it. When the infrastructure is updated, you can simply merge it into your branch again.
