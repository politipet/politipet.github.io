☆ POLITIPET ☆
=============

----

<div class="content" markdown="1">

{% assign vote = "https://petitions.assemblee-nationale.fr/initiatives/i-" %}

{% for item in site.data.top_40 %}

{% assign link = vote %}
{% assign id = item.id | string | prepend: "i-" %}
{% if site.data.title[id] %} {% assign link = "/" %}
{% endif %}

[{{ item.title }}]({{link}}{{item.id}})

{% endfor %}

</div>

----

[home](/)
