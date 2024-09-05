SITE=https://macron-destitution.fr

main() {
	case $1 in
		--score)
			get_score
			;;
		--poll)
			poll
			;;
		--help|-h|"")
			echo "usage: $0 [--score|--poll]"
			;;
		*)
			echo "unknown option: $1"
			$0 -h
			exit 1
			;;
	esac
}


poll() {
	while true; do
		date=$(date +"%F %T")
		score=$(get_score)

		[ "$score" = "$last" ] && continue

		printf "%s\t%s\t%s\n" $date $score
		last=$score
		sleep 1m
	done
}


get_score() {
	curl -s $SITE \
	| grep -m 1 "ont signé.</strong>" \
	| sed 's/.*<strong>//; s/&nbsp;//; s/ ont signé.*//'
}


main "$@"
