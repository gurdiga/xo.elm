QUILL_VERSION="1.3.0"
quill: \
	vendor/quill \
	vendor/quill/quill.min.js \
	vendor/quill/quill.snow.css \
	vendor/quill/quill.bubble.css

vendor/quill: vendor
	mkdir vendor/quill

vendor/quill/quill.min.js:
	wget --output-document="$@" --no-verbose https://cdn.quilljs.com/$(QUILL_VERSION)/quill.min.js

vendor/quill/quill.snow.css:
	wget --output-document="$@" --no-verbose https://cdn.quilljs.com/$(QUILL_VERSION)/quill.snow.css

vendor/quill/quill.bubble.css:
	wget --output-document="$@" --no-verbose https://cdn.quilljs.com/$(QUILL_VERSION)/quill.bubble.css

