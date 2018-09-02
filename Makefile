SERVER_IP=127.1
SERVER_PORT=8005

default: rich-text-editor compile test

test: elm-test
	@echo "Skipping elm-test because it’s not 0.19-compatible yet"

elm-test: /usr/local/bin/elm-test

/usr/local/bin/elm-test:
	npm install -g elm-test

c: compile
compile:
	elm make --debug src/Main.elm --output dist/Main.js

clean:
	rm -rf {,tests/}elm-stuff/build-artifacts/0.18.0/user/project

clean-hard:
	rm -rf {,tests/}elm-stuff

open:
	open http://$(SERVER_IP):$(SERVER_PORT)/src/Main.elm

.PHONY: tags
tags:
	rm tags; ctags -R

pc: pre-commit
pre-commit: compile test rich-text-editor


check-untracked:
	test `git ls-files --other --directory --exclude-standard | wc -c` == '0'

.PHONY: rich-text-editor
rich-text-editor:
	@make -C $@

.EXPORT_ALL_VARIABLES:

git-hook:
	cat <<< "$$SETUP_GIT_HOOK" > .git/hooks/pre-commit
	chmod u+x .git/hooks/pre-commit
	ls -la .git/hooks/pre-commit

define SETUP_GIT_HOOK
#!/bin/sh

make pre-commit
endef

start:
	elm reactor --port=$(SERVER_PORT) & sleep 0.1

stop:
	pkill -f 'elm reactor'

restart: stop start

edit:
	atom .
