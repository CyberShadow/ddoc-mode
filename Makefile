emacs ?= emacs
all: test

test:
	$(emacs) -Q -batch -l ddoc-mode-test.el -l ddoc-mode.el -f ert-run-tests-batch-and-exit

compile:
	$(emacs) -Q -batch -f batch-byte-compile ddoc-mode.el

clean:
	rm -f ddoc-mode.elc

.PHONY:	all test compile clean
