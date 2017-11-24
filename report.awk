#!/usr/bin/awk -f

BEGIN {
    nlangs = -1
    n = 0
}

/fib-|fib_/ {
    ++nlangs

    lang = $0
    gsub(".*fib[-_]","", lang)
    gsub(" .+","", lang)

    langs[nlangs] = lang
    n = 0
}

/fib\./ {
    ++nlangs

    lang = $0
    gsub(".* time ","", lang)
    gsub(" .+","", lang)
	if (lang == "scala" || lang == "swift") {
		lang = lang "_script"
	} else if (lang ~ "php$") {
        split(lang, tmp, "/")
        lang=tmp[5]
	}

    langs[nlangs] = lang
    n = 0
}

/Fib/ {
    ++nlangs

    lang = $0
    gsub(".*/java -cp ","", lang)
    gsub(" *FibJava .+$","", lang)

    langs[nlangs] = lang
    n = 0
}

!/fib|Fib/{
    map[nlangs,n++] = $1
}

END {
    ++nlangs

    for (j = 0; j < nlangs; ++j) {
        printf("%s,", langs[j])
    }
    print("")

    for (i = 0; i < n; ++i) {
        for (j = 0; j < nlangs; ++j) {
            printf("%s, ", map[j,i])
        }
        print("")
    }
}
