☆ PLUS VOTÉES / 10j☆
====================

----

<div class="content" markdown="1">

{% assign link = "https://petitions.assemblee-nationale.fr/initiatives/" %}

{% for item in site.data.dyn %}

{% if forloop.index > 10 %} {% break %} {% endif %}

{% assign id = item.id | replace: "i-", "" %}
{% assign title = item.theme | replace: "|", "\\|" %}
{% unless title %} {% assign title = site.data.title[id] %}
{% endunless %}
{% unless title %} {% assign title = item.id %}
{% endunless %}
{% if site.data.title[id] %} {% assign link = "/" %}
{% endif %}

[{{ title }}]({{link}}{{item.id}}) (+{{item.diff}})

{% endfor %}

</div>

----

[home](/)
