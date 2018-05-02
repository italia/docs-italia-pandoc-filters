
Qui collezioniamo alcuni filtri che ci sono stati utili per tradurre
documenti con Pandoc. I filtri si possono utilizzare usando l'opzione
`--filter <nome filtro>` quando si esegue pandoc. Per maggiori
informazioni consultate [la documentazione Pandoc sui filtri (in
inglese)](http://pandoc.org/filters.html)

### `figure.hs`

Permette di convertire correttamente immagini con didascalia. Si
aspetta un paragrafo contenente solo un'immagine seguito da un
paragrafo formattato con stile didascalia. Richiede che pandoc sia
eseguito con l'opzione `-f docx+styles`

### `add-headers.hs`

In alcuni casi il documento da tradurre potrebbe contenere headers in una struttura non gerarchica, che crea errori quando si cerca di convertire l'RST in HTML tramite Sphinx. Usando questo filtro vengono aggiunti gli header dove mancano, con un testo di riempimento (_header added by pandoc_)

### `loosen-lists.hs`

Fa in modo che le liste vengano scritte mantenendo uno spazio fra ogni elemento. Può essere utile quando si usa pandoc come linter per processare documenti già in formato RST

### `remove-divs.hs`

Elimina gli elementi `div` dal documento, utile quando si usi pandoc per convertire un file da HTML a RST

### `remove-quotes.hs`

A volte pandoc interpreta i blocchi di testo con indentazione come una citazione (quote). Nel caso in cui questo non fosse desiderato, applicando questo filtro eliminerà le citazioni

### `to-sphinx.hs`

Produce files pronti da essere usati con Sphinx. Questo filtro è ancora in via di miglioramento, se siete interessati ad utilizzarlo per favore mettetevi in contatto col team di Docs Italia

