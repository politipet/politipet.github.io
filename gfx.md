Participation
=============

----

<div id="contents">

{% assign vote = "https://petitions.assemblee-nationale.fr/initiatives" %}
{% assign search = "?filter[search_text]=" %}

{% for item in site.data.tdg %}

{% case item.id %}
  {% when "bassine" %} {% assign url = search | append: "bassine" %}
  {% when "planlfi" %} {% assign url = search | append: "plan+d'urgence" %}
  {% else %}           {% assign url = item.id %}
{% endcase %}

<div id="{{item.id}}">

<a href="{{item.id}}">
  <img alt="{{item.text}}" src="{{item.id}}.graph.png">
</a>

<span class="button bak-button">&lt;&lt;</span>
<span class="button score"><a href="{{vote}}/{{url}}">
{{ site.data.all[item.id].score }}
</a></span>
<span class="button fwd-button">&gt;&gt;</span>

</div>

{% endfor %}

</div>

----

[home](/)
