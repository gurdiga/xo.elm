compile:
	elm-make --warn src/Main.elm --output=index.html

start:
	elm-reactor & sleep 0.1

stop:
	pkill elm-reactor
