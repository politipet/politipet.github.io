<div id='footer' class='info-page' markdown='1'>
☆

[voter][vote]

[partager][share] [discuter][chat]

[participation][graph]

☆
</div>

-----

<div class='info-page footer' markdown='1'>

[social][social] ☆ [home](/) ☆ [contact][contact]

</div>

<script src="voter.js"></script>
<script>
// init_voter() // disabled for @cinq

function share() {
	if (navigator.share) {
		doShare()
	} else
	if (navigator.clipboard.write) {
		setClipboard()
		notifyCopied()
	}
}

function doShare() {
	navigator.share({
		title: document.title,
		text: "",
		url: window.location.href
	})
}

async function setClipboard() {
	const type = "text/plain";
	const clipboardItemData = {
		[type]: window.location.href
	};
	const clipboardItem = new ClipboardItem(clipboardItemData);
	await navigator.clipboard.write([clipboardItem]);
}

function notifyCopied() {
	msg = document.createElement("div")
	msg.innerHTML = "copié dans le presse-papier !"
	msg.style.position = "relative"
	msg.style.textAlign = "right"
	msg.style.marginTop = "-1.2em"

	document.getElementById("footer").appendChild(msg)
	setTimeout(
		function() { msg.parentNode.removeChild(msg) },
		1000
	)
}
</script>

[vote]: :VOTE:
[chat]: :SEEN:
[graph]: /gfx#:REF:
[share]: javascript:share()

[social]: https://piaille.fr/tags/initiatives_citoyennes
[contact]: mailto:politipet@laposte.net
