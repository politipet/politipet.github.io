target = $(shell cut -f 1 graphs.txt)
.graph = $(shell cut -f 2 graphs.txt)
.score = $(shell cut -f 3 graphs.txt)

all_id = $(shell seq $(words $(target)))

src = $(word $*, $($(suffix $@)))
dst = $(word $*, $(target))$(suffix $@)
ref = $(word $*, $(target))

%.graph %.score:
	curl -s $(BASE)"?oid=$(src)&format=image" > _site/$(dst).png

graphs: $(addsuffix .graph, $(all_id))
scores: $(addsuffix .score, $(all_id))

version:
	git rev-parse --short=6 HEAD > _site/version.txt

BASE = "https://docs.google.com/spreadsheets/d/e/2PACX-1vTaQG5GcdXrinSC3tlJNf5I16eWZVfEnKwZxKM2b-tgS0VbOWbLGsVFNIeB6RvGWRr-E2s-GezWijig/pubchart"
