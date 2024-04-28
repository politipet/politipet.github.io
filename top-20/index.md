☆ POLITIPET ☆
=============

----

<div class="content" markdown="1">

{% assign vote = "https://petitions.assemblee-nationale.fr/initiatives/" %}

{% for item in site.data.top_20 %}

[{{ item.title }}]({{vote}}i-{{item.id}})

{% endfor %}

</div>

----

[home](/)
