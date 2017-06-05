test:
	elm-test

compile:
	elm-make --warn src/Main.elm

open:
	open http://localhost:8000

start:
	elm-reactor & sleep 0.1

stop:
	pkill elm-reactor
