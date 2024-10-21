☆ POLITIPET ☆
=============

----

<link rel="stylesheet" href="sel.css"/>

<div class="content" markdown="1">

{% for item in site.data.tdg %}

[{{ item.text }}](/{{ item.id | remove: "i-" }})

{% endfor %}

</div>

----

[home](/)
