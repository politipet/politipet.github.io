
url = {
"bassine": "?filter[search_text]=bassine",
"planlfi": "?filter[search_text]=plan+d'urgence",
}

function main() {
	var c = document.getElementById("contents")
	var i, p
	for (i in petitions) {
		p = petition(petitions[i])
		c.appendChild(p)
	}
}

function petition_url(id) {
	return "https://petitions.assemblee-nationale.fr/initiatives/" + id
}

function petition(id) {
	var _ = document.createElement("div")
	var g = document.createElement("img")
	var s = document.createElement("img")
	var l = document.createElement("a")
	var p = document.createElement("a")
	_.id = id.replace(/i-/, "")
	g.src = id + ".graph.png"
	s.src = id + ".score.png"
	l.href = petition_url(url[id] || id)
	l.appendChild(s)
	p.href = g.src.replace(".graph.png", "")
	p.appendChild(g)

	_.appendChild(p)
	_.appendChild(backward_button())
	_.appendChild(l)
	_.appendChild(forward_button())

	return _
}

function forward_button() {
	return button("button fwd-button", ">>", function(ev) {
		c = document.getElementById("contents")
		c.appendChild(c.firstChild)
	})
}

function backward_button() {
	return button("button bak-button", "<<", function(ev) {
		c = document.getElementById("contents")
		c.insertBefore(c.lastChild, c.firstChild)
	})
}

function button(clazz, txt, onclick) {
	var _ = document.createElement("span")
	_.setAttribute("class", clazz)
	_.addEventListener('click', onclick)
	_.innerHTML = txt

	return _
}


main()
