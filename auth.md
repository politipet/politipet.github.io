<div class="info" markdown="1">

Authentifiez-vous anonymement comme personne physique majeure avec
le bouton [[s'authentifier]]. Terminez en cliquant le bouton
[[continuer sur la plateforme]] et fermez la page. Vous êtes authentifié·e
pour une demi-heure. Votez la proposition avec le bouton [[voter]].

<center> 🎃 🎃 🎃 </center>

<div id='footer' class="info-page" style="text-align:center" markdown="1">

[s'authentifier avec France Connect][auth]

[voter][vote]

</div>

Pour voter aux initiatives citoyennes à l'Assemblée nationale,
il faut prouver qu'on est une personne physique majeure.

La plateforme utilise France Connect comme tiers de confiance
pour authentifier (et non identifier) les personnes physiques,
vérifier l'age et garantir l'anonymat du vote.

</div>


[auth]: https://petitions.assemblee-nationale.fr/users/auth/france_connect_uid
[vote]: https://petitions.assemblee-nationale.fr/initiatives/

<script>
auth = document.querySelector("#footer p:first-child a")
vote = document.querySelector("#footer p:last-child a")
vote.href += location.search.replace("?", "i-")
vote.setAttribute("target", "blank_")
auth.setAttribute("target", "blank_")
</script>
