watch:
	#!/usr/bin/env bash
	mkdir -p build
	watchexec --exts md \
		--restart \
		--debounce 100 \
		--no-shell \
		-- \
		pandoc --from markdown \
			--to html \
			--standalone \
			./report.md \
			--output build/tex-report.html &
	devd --watch build/tex-report.html \
		--address localhost \
		--livereload \
		--open \
		build/
