☆ POLITIPET ☆
=============

----

<link rel="stylesheet" href="sel.css"/>
<style>
img {
	width: 105%;
	margin: -.5em -2em -.7em;
	border: 2px solid grey;
	border-radius: 1em;
	cursor: pointer;
}
</style>

<div class="content" markdown="1">

{% for item in site.data.tdg %}
{% assign gfx = site.data.graph[item.id] %}
{% assign page = item.id | remove: "i-" %}

{% if gfx %}
[![{{ item.text }}]({{ gfx }})](/{{ page }})
{% else %}
[{{ item.text }}](/{{ page }})
{% endif %}

{% endfor %}


<hr style="width: 2em; margin: 1em;">

[sélection](/sel)

</div>

----

[home](/)
