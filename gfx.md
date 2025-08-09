☆ POLITIPET ☆
=============

#### initiatives citoyennes

### votez · faites voter

----

<div id="contents">

{% assign vote = "https://petitions.assemblee-nationale.fr/initiatives" %}
{% assign search = "?filter[search_text]=TEXT&order=most_voted" %}

{% for item in site.data.tdg %}

{% if item.id contains "i-" %}	{% assign url = item.id %}
{% else %}
{% assign url = search | replace: "TEXT", item.id %}
{% endif %}

{% assign score = site.data.all[item.id].score | to_integer %}

{% if score >= 1000000 %}
{% assign score = score | divided_by: 1000000.0 | round: 2 %}
{% assign score = score | string | append: "M" %}
{% else %}
{% if score >= 1000 %}
{% assign score = score | divided_by: 1000.0 | round: 1 %}
{% assign score = score | string | append: "k" %}
{% endif %}
{% endif %}

{% if score == 0 %}
{% assign score = "" %}
{% endif %}

<div id="{{item.id | remove: "i-" }}">

<a href="{{item.id | remove: "i-" }}">
  <img alt="{{item.text}}" src="{{item.id}}.graph.png">
</a>

<div class="buttons">
<span class="button shifter bak">&lt;&lt;</span>
<span class="button score"><a href="{{vote}}/{{url}}">
{{ score }}
</a></span>
<span class="button shifter fwd">&gt;&gt;</span>
</div>

</div>

{% endfor %}

</div>

----

[home](/)

<script>
(function init_shifter() {

const c = document.getElementById("contents")

c.querySelectorAll(".shifter.fwd")
.forEach((butt) => {
	butt.onclick = function(ev) {
		c.appendChild(c.children[0])
	}
})

c.querySelectorAll(".shifter.bak")
.forEach((butt) => {
	butt.onclick = function(ev) {
		c.insertBefore(c.children[c.children.length-1], c.children[0])
	}
})

})()
</script>
