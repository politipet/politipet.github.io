target = $(shell cut -f 1 graphs.txt)
.graph = $(shell cut -f 2 graphs.txt)
.score = $(shell cut -f 3 graphs.txt)
.seen  = $(shell cut -f 4 graphs.txt)

all_id = $(shell seq $(words $(target)))

src = $(word $*, $($(suffix $@)))
dst = $(word $*, $(target))$(suffix $@)
ref = $(word $*, $(target))

%.graph %.score:
	curl -s $(BASE)"?oid=$(src)&format=image" > _site/$(dst).png

graphs: $(addsuffix .graph, $(all_id))
scores: $(addsuffix .score, $(all_id))
seens:  $(addsuffix .seen,  $(all_id))

%.seen:
	curl -s $(SEEN)/$(src) \
	| grep '<div  id="texte$(src)">' \
	| sed 's:</blockquote>.*:</blockquote></div></div></div>:' \
	> $(ref).md
	@echo $(footer) >> $(ref).md

footer = "\n\
[voter][vote]\n\
\n\
[discuter][chat]\n\
\n\
[vote]: $(VOTE)/$(url)\n\
[chat]: $(SEEN)/$(src)\n\
"

url = $(if $(ref.url),$(ref.url),$(ref))
ref.url = $($(ref).url)
bassine.url = "?filter[search_text]=bassine"

version:
	git rev-parse --short=6 HEAD > _site/version.txt

VOTE = "https://petitions.assemblee-nationale.fr/initiatives"
SEEN = "https://seenthis.net/messages"
BASE = "https://docs.google.com/spreadsheets/d/e/2PACX-1vTaQG5GcdXrinSC3tlJNf5I16eWZVfEnKwZxKM2b-tgS0VbOWbLGsVFNIeB6RvGWRr-E2s-GezWijig/pubchart"
