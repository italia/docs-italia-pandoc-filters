### `add-headers.hs`

In alcuni casi il documento da tradurre potrebbe contenere headers in una struttura non gerarchica, che crea errori quando si cerca di convertire l'RST in HTML tramite Sphinx. Usando questo filtro vengono aggiunti gli header dove mancano, con un testo di riempimento (_header added by pandoc_)

### `flatten.hs`

Questo filtro permette di tradurre inlines annidiati, eliminando alcuni errori di sintassi RST

### `loosen-lists.hs`

Fa in modo che le liste vengano scritte mantenendo uno spazio fra ogni elemento. Può essere utile quando si usa pandoc come linter per processare documenti già in formato RST

### `merge-code.hs`

Fonde i blocchi codice consecutivi. Alcuni documenti da tradurre potrebbero avere il codice formattato in piccoli blocchi, e con questo filtro si può ottenere un documento RST più leggibile

### `remove-divs.hs`

Elimina gli elementi `div` dal documento, utile quando si usi pandoc per convertire un file da HTML a RST

### `remove-quotes.hs`

A volte pandoc interpreta i blocchi di testo con indentazione come una citazione (quote). Nel caso in cui questo non fosse desiderato, applicando questo filtro eliminerà le citazioni

### `to-sphinx.hs`

Produce files pronti da essere usati con Sphinx. Questo filtro è ancora in via di miglioramento, se siete interessati ad utilizzarlo per favore mettetevi in contatto col team di Docs Italia

