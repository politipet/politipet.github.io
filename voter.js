function init_voter() {
	var voter = document.querySelector("#footer a:first-child")
	var id = location.pathname.replace("/", "")
	var vote = "https://petitions.assemblee-nationale.fr/initiatives/i-"

	voter.setAttribute("target", "blank_")
	voter.onclick = function(ev) {
		if (this.innerHTML == "voter")
		this.href = (needs_auth() ? "/auth?" : vote) + id
	}
}

function needs_auth() {
	var last_auth = new Date(localStorage.getItem("last_auth"))
	var now = new Date()
	if (now - last_auth > 1000*60*30) {
		localStorage.setItem("last_auth", now)
		return true
	}
}
