target = $(shell cut -f 1 graphs.txt)
.graph = $(shell cut -f 2 graphs.txt)
.seen  = $(shell cut -f 3 graphs.txt)

all_id = $(shell seq $(words $(target)))

src = $(word $*, $($(suffix $@)))
dst = $(word $*, $(target))$(suffix $@)
ref = $(word $*, $(target))

graphs: $(addsuffix .graph, $(all_id))
seens:  $(addsuffix .seen,  $(all_id))

seens graphs:
	: generated $(words $^) $@

%.graph:
	@curl -s $(BASE)"?oid=$(src)&format=image" > _site/$(dst).png

%.seen:
	@curl -s $(SEEN)/$(src) \
	| grep '<div  id="texte$(src)">' \
	| sed 's:</blockquote>.*:</blockquote></div></div></div>:' \
	> $(ref).md
	@cat i-page.footer.md | sed "$(footer.repl)" >> $(ref).md
	@cp $(ref).md $(ref:i-%=%).md 2>/dev/null || true

%.closed:
	@src=`egrep ^$* closed.txt | cut -f 2`; \
	curl -s $(SEEN)/$$src \
	| grep '<div  id="texte'$$src'">' \
	| sed 's:</blockquote>.*:</blockquote></div></div></div>:' \
	> $*.md ;\
	cat i-page.footer.md | sed "$(footer.repl)" \
	| grep -v graph | sed 's/voter/voir/' \
	>> $*.md
	@cp $*.md $(*:i-%=%).md 2>/dev/null || true

%.closed: url = $*
%.closed: src = $$src
%.closed: ref = $*

closed = $(shell cut -f 1 closed.txt)
seens: $(closed:%=%.closed)


footer.repl = \
	s,:VOTE:,$(VOTE)/$(url),;\
	s,:SEEN:,$(SEEN)/$(src),;\
	s,:REF:,$(ref:i-%=%),;\

url = $(if $(ref.url),$(ref.url),$(ref))
ref.url = $($(ref).url)
bassine.url = "?filter[search_text]=bassine"
destitution.url = "?filter[search_text]=destitution"


pie-chart.graph: src = 365702971
pie-chart.graph: dst = pie-chart-PAN

graphs: pie-chart.graph

votes.graph: src = 1008534023
votes.graph: dst = votes-per-day

graphs: votes.graph

data_files = all.yml tdg.tsv version
data_files: $(data_files)


tdg.tsv:
	@curl -s $(SEEN)/1007431 \
	| grep 'class="texte"' \
	| sed 's:<br>:\n:g' \
	| grep lien_lien \
	| sed "s:<span class='lien_lien'.*</a></span><a rel='nofollow' ::g;\
		s:.*class='lien_fin'>::g;\
		s:\t: :g;\
		s:</span></span></a></span>:\t:g;\
		s:</p></div></div></div>::g;\
		s:&num;:#:g;\
		/^[0-9]/ s:^:i-:;\
	" > $(list.tsv)
	@[ `wc -l < $(list.tsv)` -gt 1 ] || { echo === FALLBACK ===; \
		curl -s https://politipet.fr/$(list.tsv) > $(list.tsv); }
	@cat $(list.tsv) \
	| awk '{print $$1 ":"; $$1=""; print " title: " $$0}' \
	> _data/title.yml
	@{ echo "id\ttext"; cat $(list.tsv); } > _data/$@

list.tsv = tdg/list.tsv

all.yml:
	curl -sL $(data_all.txt) \
	| sort -nr -k3 \
	| tee _data/alive.txt \
	| awk '{print($$1 ":\n commission: " $$2 "\n score: " $$3)}' \
	> _data/$@
	{ echo "id,commission,score"; tr ' ' , < _data/alive.txt; } \
	> _data/alive.csv

data_all.txt = https://github.com/politipet/data/raw/master/all-data.txt


%.extra:
	echo "$*:\n score: $(get.score)" >> _data/all.yml

get.score = $(shell cat _data/alive.txt				\
		| egrep "i-(`echo $($(*).score) | tr ' ' '|'`)" \
		| cut -d ' ' -f 3 | xargs | tr ' ' '+' | bc)

-include .extra_data
.extra_data:
	curl -sL https://github.com/politipet/data/raw/master/compose.txt > .1
	sed 's/\s*=/.score =/'				.1 > $@
	sed 's/\s*=.*/.extra/; s/^/extra_data: /'	.1 >> $@

data_files: extra_data


githash = $(shell git rev-parse --short=6 HEAD)
timestamp = $(shell TZ='Europe/Paris' date +'%F %H:%M')
version:
	echo 'githash: $(githash)\ntimestamp: "$(timestamp)"' \
	> _data/$@.yml


$(data_files): _data
_data:
	mkdir $@

VOTE = "https://petitions.assemblee-nationale.fr/initiatives"
SEEN = "https://seenthis.net/messages"
BASE = "https://docs.google.com/spreadsheets/d/e/2PACX-1vTaQG5GcdXrinSC3tlJNf5I16eWZVfEnKwZxKM2b-tgS0VbOWbLGsVFNIeB6RvGWRr-E2s-GezWijig/pubchart"
