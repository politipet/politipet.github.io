☆ POLITIPET ☆
=============

----

<link rel="stylesheet" href="sel.css"/>
<style>
.content img {
	border: 2px solid grey;
	border-radius: 1em;
	cursor: pointer;
}
.content a:has(> img) {
	padding: 0;
	background-color: transparent;
}
.content i {
	top: 2px;
	position: relative;
}
</style>

<div class="content" markdown="1">

{% for item in site.data.tdg %}
{% assign gfx = site.data.graph[item.id] %}
{% assign page = item.id | remove: "i-" %}

<i id="{{ page }}"></i>
{% if gfx %}
[![{{ item.text }}]({{ gfx }})](/{{ page }})
{% else %}
[{{ item.text }}](/{{ page }})
{% endif %}

{% endfor %}

</div>

----

[home](/)
