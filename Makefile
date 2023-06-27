target = $(shell cut -f 1 graphs.txt)
.graph = $(shell cut -f 2 graphs.txt)
.score = $(shell cut -f 3 graphs.txt)
.seen  = $(shell cut -f 4 graphs.txt)

all_id = $(shell seq $(words $(target)))

src = $(word $*, $($(suffix $@)))
dst = $(word $*, $(target))$(suffix $@)
ref = $(word $*, $(target))

graphs: $(addsuffix .graph, $(all_id))
scores: $(addsuffix .score, $(all_id))
seens:  $(addsuffix .seen,  $(all_id))

%.graph:; $(GET_PNG)
%.score:; $(GET_PNG)

GET_PNG = curl -s $(BASE)"?oid=$(src)&format=image" > _site/$(dst).png

%.seen:
	curl -s $(SEEN)/$(src) \
	| grep '<div  id="texte$(src)">' \
	| sed 's:</blockquote>.*:</blockquote></div></div></div>:' \
	> $(ref).md
	cat i-page.footer.md | sed "$(footer.repl)" >> $(ref).md

footer.repl = \
	s,:VOTE:,$(VOTE)/$(url),;\
	s,:SEEN:,$(SEEN)/$(src),;\
	s,:REF:,$(ref:i-%=%),;\

url = $(if $(ref.url),$(ref.url),$(ref))
ref.url = $($(ref).url)
bassine.url = "?filter[search_text]=bassine"

tdg_list:
	curl -s $(SEEN)/1007431 \
	| grep 'class="texte"' \
	| sed 's:<br>:\n:g' \
	| grep lien_lien \
	| sed "s:<span class='lien_lien'.*</a></span><a rel='nofollow' ::g;\
		s:.*class='lien_fin'>::g;\
		s:\t: :g;\
		s:</span></span></a></span>:\t:g;\
		s:</p></div></div></div>::g;\
		s:&num;:#:g;\
	" > tdg/list.tsv

version:
	git rev-parse --short=6 HEAD > _site/version.txt

VOTE = "https://petitions.assemblee-nationale.fr/initiatives"
SEEN = "https://seenthis.net/messages"
BASE = "https://docs.google.com/spreadsheets/d/e/2PACX-1vTaQG5GcdXrinSC3tlJNf5I16eWZVfEnKwZxKM2b-tgS0VbOWbLGsVFNIeB6RvGWRr-E2s-GezWijig/pubchart"
