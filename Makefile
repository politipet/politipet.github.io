seens graphs:
	: generated $(words $^) $@

%.graph:
	@curl -s $(BASE)"?oid=$(src)&format=image" > _site/$(dst).png

%.seen:
	@curl $(_seen)/$(src) \
	| grep '<div  id="texte$(src)">' \
	| sed 's:</blockquote>.*:</blockquote></div></div></div>:' \
	| sed 's:<strong>\([^<]*\)</strong>:<h1>\1</h1>:' \
	> $(dst).md
	@if [ `wc -l < $(dst).md` = 0 ]; then \
		echo === FALLBACK $(dst) ===; \
		curl -s https://politipet.fr/$(dst).md > $(dst).md; \
	else \
		cat page.footer.md | sed "$(footer.repl)" \
		>> $(dst).md	; fi

%.seen: dst = $(*:i-%=%)
%.graph: dst = $@

_seen = -s -H "user-agent: politipet.fr" $(SEEN)

-include .targets
.targets: targets closed
	@cat $^ | awk '{ \
		print $$1 ".seen: src = " $$2; print "seens: " $$1 ".seen"; \
	} \
	int($$3) { \
		print $$1 ".graph: src = " $$3; print "graphs: " $$1 ".graph"; \
	}' > $@


targets: stem = id \/ seen \/ graph
closed: stem = id closed \/ seen

targets closed:
	@curl $(_seen)/$(TDG) | sed "		\
		1,/$(stem)/ d;			\
		/-<\/code>/, $$ d;		\
		s/&nbsp;/ /g;			\
		s:<br />::;			\
		s/ \+/\t/g"			\
	> $@
	@[ `wc -l < $@` -gt 0 ] || \
		curl -s https://politipet.fr/$@ > $@

%.closed:
	@sed -i 's/voter]/voir]/; /graph]/ d;' $(*:i-%=%).md

closed = $(shell cut -f 1 closed 2>/dev/null)
fixup-closed: $(closed:%=%.closed)
seens: fixup-closed


footer.repl = \
	s,:VOTE:,$(VOTE)/$(url),;\
	s,:SEEN:,$(SEEN)/$(src),;\
	s,:REF:,$(dst:i-%=%),;\

url = $(if $(filter i-%, $(dst)),$(dst),$(search))
search = "?filter[search_text]=$($(dst).search)"


pie-chart.graph: src = 365702971
pie-chart.graph: dst = pie-chart-PAN

votes.graph: src = 1008534023
votes.graph: dst = votes-per-day

dyn-top.graph: src = 962972440
dyn-top.graph: dst = dyn-top-5

graphs: $(addsuffix .graph, pie-chart votes dyn-top)


graph.yml: targets
	@( \
	echo "stats: votes-per-day.png" ;\
	echo "commission/: pie-chart-PAN.png" ;\
	awk '\
		$$4		 {print $$1 ": " $$4; next}\
		int($$3)	 {print $$1 ": " $$1 ".graph.png"}\
		$$3 && !int($$3) {print $$1 ": " $$3}\
	' $^ ;\
	) > _data/$@


data_files = all.yml tdg.tsv version.yml top_20.tsv dyn.tsv
data_files: $(data_files)
data_files: graph.yml


TDG = 1068218
tdg.tsv:
	@curl $(_seen)/$(TDG) \
	| sed "/<\/article>/,$$ d" \
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

list.tsv = sel.tsv

all.yml:
	curl -sL $(data_all.txt) \
	| sort -nr -k3 \
	| tee _data/alive.txt \
	| awk '{print($$1 ":\n commission: " $$2 "\n score: " $$3)}' \
	> _data/$@
	{ echo "id,commission,score"; tr ' ' , < _data/alive.txt; } \
	> _data/alive.csv

data-master = https://github.com/politipet/data/raw/master
data_all.txt = $(data-master)/all-data.txt


%.extra:
	echo "$*:\n score: $(get.score)" >> _data/all.yml

get.score = $(shell cat _data/alive.txt				\
		| egrep "i-(`echo $($(*).score) | tr ' ' '|'`)" \
		| cut -d ' ' -f 3 | xargs | tr ' ' '+' | bc)

-include .extra_data
.extra_data:
	curl -sL $(data-master)/compose.txt		> .1
	sed 's/\s*=/.score =/'				.1 > $@
	sed 's/\s*=.*/.extra/; s/^/extra_data: /'	.1 >> $@

extra_data:

data_files: extra_data

top_20.tsv:
	curl -s -H "Accept: text/html" $(VOTE)?order=most_voted \
	| awk '\
		/card__link/	{ gsub(".*i-", ""); printf $$0 } \
		title		{ print; title = 0 } \
		/card__title/	{ title = 1 } \
		BEGIN		{ print "id" "\t" "title" } \
	' | sed 's:">:\t: ; s: \+::' \
	> _data/$@

dyn.tsv:
	curl -sL $(data-master)/all-dyn.txt > _data/$@


githash = $(shell git rev-parse --short=6 HEAD)
timestamp = $(shell TZ='Europe/Paris' date +'%F %H:%M')
version.yml:
	echo 'githash: $(githash)\ntimestamp: "$(timestamp)"' \
	> _data/$@


$(data_files): _data
_data:
	mkdir $@


extra_data: macron-destitution
macron-destitution:
	(curl -sL $(data-master)/i-md.txt	\
		| sed 's: :\t:'			;\
	printf "%s\t%s\t" $(timestamp)		;\
	./md.sh --score				;\
	) > md.txt


build.site:
	git tag -f build ; git push -f site build


VOTE = "https://petitions.assemblee-nationale.fr/initiatives"
SEEN = "https://seenthis.net/messages"
BASE = "https://docs.google.com/spreadsheets/d/e/2PACX-1vTaQG5GcdXrinSC3tlJNf5I16eWZVfEnKwZxKM2b-tgS0VbOWbLGsVFNIeB6RvGWRr-E2s-GezWijig/pubchart"
