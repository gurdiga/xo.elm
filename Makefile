default: compile

test: elm-test
	elm-test

elm-test: /usr/local/bin/elm-test

/usr/local/bin/elm-test:
	npm install -g elm-test

c: compile
compile:
	elm make --warn src/Main.elm --output dist/Main.js

clean:
	rm -rf elm-stuff/build-artifacts/0.18.0/user/project

open:
	open http://localhost:8000

start:
	elm reactor & sleep 0.1

stop:
	pkill elm-reactor

pc: pre-commit
pre-commit: clean compile test

.EXPORT_ALL_VARIABLES:

git-hook:
	cat <<< "$$SETUP_GIT_HOOK" > .git/hooks/pre-commit
	chmod u+x .git/hooks/pre-commit
	ls -la .git/hooks/pre-commit

define SETUP_GIT_HOOK
#!/bin/sh

make pre-commit
endef
