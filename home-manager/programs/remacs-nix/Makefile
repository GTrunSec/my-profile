.PHONY: debug remacs

all:
	nix-build --show-trace --arg local true build.nix

remacs:
        git clone https://github.com/remacs/remacs

debug:
	./result/bin/remacs -Q --eval '(progn (setq user-emacs-directory "$(dir ${INITFILE})" user-init-file "${INITFILE}") (load user-init-file))'
