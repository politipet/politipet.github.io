data = [
"i-1123	1120464573	342244041",
"i-1446	1421214239	738909962",
"i-1484	1545084010	1772260604",
"i-1559	1010483208	808968259",
"i-1395	916793369	1552015065",
"?filter[search_text]=bassine	990190109	1953374430",
"i-1549	326156748	1263406030",
"i-1590	1481400461	208675595",

"i-1319	544747026	1691291351	closed",
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
	return gdoc + "oid=" + oid + "&format=image"
}

function petition_url(id) {
	return "https://petitions.assemblee-nationale.fr/initiatives/" + id
}

function petition(id) {
	var _ = document.createElement("div")
	var g = document.createElement("img")
	var s = document.createElement("img")
	var l = document.createElement("a")
	_.id = id.replace(/i-|\?.*=/, "")
	g.src = image_url(graph[id])
	s.src = image_url(score[id])
	l.href = petition_url(id)
	l.innerHTML = "signer"
	l.insertBefore(s, l.firstChild)

	_.appendChild(g)
	_.appendChild(l)

	return _
}

main()
