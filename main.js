petitions = [
"i-1559",
"i-1590",
"i-1036",
"bassine",
"i-1549",
"i-1465",

"i-1123",
"i-1446",
"i-1484",
//"i-1395",

"i-1319", // closed
]

url = {
"bassine": "?filter[search_text]=bassine",
}

function main() {
	var c = document.getElementById("contents")
	for (i in petitions)
		c.appendChild(petition(petitions[i]))
}

function petition_url(id) {
	return "https://petitions.assemblee-nationale.fr/initiatives/" + id
}

function petition(id) {
	var _ = document.createElement("div")
	var g = document.createElement("img")
	var s = document.createElement("img")
	var l = document.createElement("a")
	_.id = id.replace(/i-/, "")
	g.src = id + ".graph.png"
	s.src = id + ".score.png"
	l.href = petition_url(url[id] || id)
	l.appendChild(s)

	_.appendChild(g)
	_.appendChild(l)

	return _
}

main()
