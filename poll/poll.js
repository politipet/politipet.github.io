function init() {
	var _ = document.querySelector("data")

	var questions = _.innerHTML.trim().split(/\n/)

	var form = document.createElement("form")
	var button = document.createElement("input")
	button.type = "submit"
	button.value = "Ayé Fini !"

	_.replaceWith(form)
	_ = form

	for (i in questions)
		_.appendChild(item(questions[i]))

	_.appendChild(button)
	_.method = "post"
	_.action = "http://coviiid.free.fr/politipet/poll.php5"
}

function item(txt) {
	if (! txt) return document.createElement("p")

	var div = document.createElement("div")
	var box = document.createElement("input")
	var lbl = document.createTextNode(" " + txt)
	box.type = "checkbox"
	box.name = "q" + (item.id++)
	box.value = 1
	div.appendChild(box)
	div.appendChild(lbl)

	return div
}
item.id = 1

document.body.onload = init
