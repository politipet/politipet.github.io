☆ PLUS VOTÉES ☆
===============

en 10 jours
-----------

----

<div class="content" markdown="1">

{% assign link = "https://petitions.assemblee-nationale.fr/initiatives/i-" %}

{% for item in site.data.dyn %}

{% if forloop.index > 10 %} {% break %} {% endif %}

{% assign id = item.id | replace: "i-", "" %}
{% assign title = item.theme | replace: "|", "\\|" %}
{% if title == "" %}    {% assign title = site.data.title[id] %} {% endif %}
{% if title == empty %} {% assign title = item.id %} {% endif %}
{% if site.data.title[id] %} {% assign link = "/" %} {% endif %}

[{{ title }}]({{link}}{{id}}) (+{{item.diff}} / {{item.score}})

{% endfor %}

</div>

----

[home](/)
