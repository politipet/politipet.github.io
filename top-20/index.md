☆ POLITIPET ☆
=============

----

<div class="content" markdown="1">

{% assign vote = "https://petitions.assemblee-nationale.fr/initiatives/" %}

{% for item in site.data.top_20 %}

[{{ item[1].title }}]({{vote}}{{ item[0] | prepend: "i-" }})

{% endfor %}

</div>

----

[home](/)
