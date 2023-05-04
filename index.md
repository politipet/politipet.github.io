☆ POLITIPET ☆
=============

suivi de pétitions
------------------

-----

[les plus signées](https://petitions.assemblee-nationale.fr/initiatives?order=most_voted)


<div id="contents"></div>

<script>
data = [
"1123	1120464573	342244041",
"1484	1545084010	1772260604",
"1395	916793369	1552015065",
"1549	326156748	1263406030",
"1446	1421214239	738909962",
"1319	544747026	1691291351",
]

petitions = []
graph = {}
score = {}

function main() {
	init_globals()
	var c = document.getElementById("contents")
	for (i in petitions)
		c.appendChild(petition(petitions[i]))
}

function init_globals() {
	for (i in data) {
		x = data[i].split(/\s+/)
		id = x[0]
		graph[id] = x[1]
		score[id] = x[2]
		petitions[i] = id
	}
}

gdoc = (
"https://docs.google.com/spreadsheets/" +
"d/e/2PACX-1vTaQG5GcdXrinSC3tlJNf5I16eWZVfEnKwZxKM2b-tgS0VbOWbLGsVFNIeB6RvGWRr-E2s-GezWijig" +
"/pubchart?"
)

function image_url(oid) {
	return oid ? gdoc + "oid=" + oid + "&format=image" : ""
}

function petition(id) {
	var _ = document.createElement("div")
	var g = document.createElement("img")
	var s = document.createElement("img")
	var l = document.createElement("a")
	_.id = id
	g.src = image_url(graph[id])
	s.src = image_url(score[id])
	l.href = "https://petitions.assemblee-nationale.fr/initiatives/i-" + id
	l.innerHTML = "signer"
	_.appendChild(g)
	if (s.src) _.appendChild(s)
	_.appendChild(l)

	return _
}

main()
</script>

<style>

body	{ font-family: 'Comfortaa'; }
img	{ max-width: 100%; }
img	{ display: block; }

</style>
