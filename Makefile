compile:
	elm-make --warn src/Main.elm --output=index.html

open:
	open http://localhost:8000

start:
	elm-reactor & sleep 0.1

stop:
	pkill elm-reactor
