QUARTO ?= quarto

.PHONY: check preview render render-book render-print

check:
	$(QUARTO) check

preview:
	$(QUARTO) preview

render: render-book render-print

render-book:
	$(QUARTO) render

render-print:
	$(QUARTO) render --profile print
