compile:
	elm-make src/Main.elm --output=index.html

start:
	elm-reactor & sleep 0.1

stop:
	pkill elm-reactor
