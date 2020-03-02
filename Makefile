.PHONY: build

build:
	janet hn/import.janet && \
	janet reddit/import.janet && \
	ruby clojureverse/import.rb && \
	janet stackoverflow/import.janet && \
	janet version/import.janet && \
	ruby render.rb && \
	jam build && \
	rm index.html