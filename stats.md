Statistiques
============

----

[![votes par jour](votes-per-day.png)][all-votes.txt]

votes par jour sur l'ensemble des initiatives

[all-votes.txt]: https://github.com/politipet/data/blob/master/all-votes.txt
☆

[![top 5 plus dynamiques](dyn-top-5.png)][all-dyn.txt]

voix collectées en 10 jours

(total : {{site.data.dyn[11].comm}})

[all-dyn.txt]: https://github.com/politipet/data/blob/master/all-dyn.txt

☆

[![pie chart PAN](pie-chart-PAN.png)][show-comm]

initiatives par commission

(total : {{site.data.alive.size}})

[show-comm]: https://github.com/politipet/data/blob/master/all-stat.txt
☆

[Top of The Pets](https://seenthis.net/messages/1021649)

☆

Top 20
------

<table style="font-family: monospace">
{% for item in site.data.all %}
{% assign score = item[1].score | divided_by: 1000.0 | round: 1 %}
{% assign score = score | string | append: "k" %}
{% assign base = "https://petitions.assemblee-nationale.fr/initiatives/" %}
{% assign link = base | append: item[0] %}
<tr><td align="right">{{score}}</td><td><a href="{{link}}">{{item[0]}}</a></td></tr>
{% if forloop.index == 20 %} {% break %} {% endif %}
{% assign mod_5 = forloop.index | modulo: 5 %}
{% if mod_5 == 0 %} <tr style="height: .7em"></tr> {% endif %}
{% endfor %}
</table>

----

[home](/)
