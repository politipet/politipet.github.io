☰ · PoLiTiPeT · ☰
=============

----

<link rel="stylesheet" href="sel.css"/>

<div class="content" markdown="1">

{% for item in site.data.tdg %}

[{{ item.text }}](/{{ item.id | remove: "i-" }})

{% endfor %}

</div>

----

<div id="footer" markdown="1">

[📈](/gfx)
·
[☰](/menu)
·
[⁂](https://piaille.fr/tags/initiatives_citoyennes)

</div>


<script>header_link("menu")</script>
