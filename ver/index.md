données
=======

{{ site.data.version.timestamp }}

{{ site.data.alive.size }} pets


politipet
=========

{{ site.data.version.githash }}



<script>
document.getElementById("politipet")
.onclick = function() { location = 'https://github.com/politipet' }
document.body
.onclick = function() {
	var text = document.querySelector("center")
	text.style.display = (text.style.display ? "" : "none")
}
</script>
