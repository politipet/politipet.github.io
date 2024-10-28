function set_next(page) {
	document
	.querySelector("h1")
	.onclick = function() { location = page }
}

function default_header_onclick() {
	var h1 = document.querySelector("h1")
	if (h1 && ! h1.onclick)
		h1.onclick = function () { history.back() }
}
