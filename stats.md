Statistiques
============

----

![votes par jour](votes-per-day.png)

votes par jour sur l'ensemble des PAN

☆

![pie chart PAN](pie-chart-PAN.png)

initiatives par commission

(total : {{site.data.alive.size}})

☆

[Top of The Pets](https://seenthis.net/messages/1021649)

☆

Top 20
------

<table style="font-family: monospace">
{% for item in site.data.all %}
{% assign score = item[1].score | divided_by: 1000.0 | round: 1 %}
{% assign score = score | string | append: "k" %}
<tr><td align="right">{{score}}</td><td>{{item[0]}}</td></tr>
{% if forloop.index == 20 %} {% break %} {% endif %}
{% endfor %}
</table>

----

[home](/)
