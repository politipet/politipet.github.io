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
init_voter()

function share() {
	if (! navigator.share) return;

	navigator.share({
		title: document.title,
		text: "Partager",
		url: window.location.href
	})
}
</script>

[vote]: :VOTE:
[chat]: :SEEN:
[graph]: /gfx#:REF:
[share]: javascript:share()

[social]: https://piaille.fr/tags/initiatives_citoyennes
[contact]: mailto:politipet@laposte.net
