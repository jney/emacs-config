TARGET = "${HOME}/.emacs.d"

all:
	ln -s "$(CURDIR)/config" "${TARGET}/"
	ln -s "$(CURDIR)/config.el" "${TARGET}/${USER}.el"

update:
	git pull
	git submodule foreach git pull origin master

