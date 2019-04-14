.PHONY: all

all: docs/index.html | .git/hooks.old

docs/index.html: docs document.txt
	markdown $< > $@

docs:
	@mkdir -p $@

.git/hooks.old: | .stamps/git-hooks.installed
	git hooks --install

.stamps/git-hooks.installed: | .stamps
	@if ! command -v git-hooks >/dev/null 2>&1; then \
	  if command -v brew >/dev/null 2>&1; then \
	    brew install git-hooks; \
	  else \
	    echo "You have to install https://github.com/icefox/git-hooks"; \
	    exit 1; \
	  fi; \
	fi
	@touch $@

.stamps:
	@mkdir -p $@
