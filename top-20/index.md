☆ TOP 20 ☆
=============

----

<div class="content" markdown="1">

{% assign vote = "https://petitions.assemblee-nationale.fr/initiatives/i-" %}

{% for item in site.data.top_20 %}

{% assign link = vote %}
{% assign title = item.title | replace: "|", "\\|" %}
{% assign id = item.id | string | prepend: "i-" %}
{% if site.data.title[id] %} {% assign link = "/" %}
{% endif %}

[{{ title }}]({{link}}{{item.id}})

{% endfor %}

</div>

----

[home](/)
