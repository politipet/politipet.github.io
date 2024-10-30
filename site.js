function header_link(page) {
	document
	.querySelector("h1")
	.onclick = function() { location = page }
}

function default_header_onclick() {
	var h1 = document.querySelector("h1")
	if (h1 && ! h1.onclick)
		h1.onclick = function () { location = "/" }
}
