
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

### `bold-headers.hs`

Quando si converte da PDF a DOCX a volte gli headers vengono
interpretati semplicemente come testo in grassetto, e questo impedisce
la generazione di un indice per la documentazione. Questo filtro
individua i paragrafi che contengono solo testo in grassetto e li
converte in headers. È un processo soggetto ad errore ma in alcuni
casi può ridurre il lavoro richiesto per la pubblicazione. Il filtro
converte i paragrafi in grassetto in headers di livello 2 ma si può
modificare facilmente per usare un altro livello

### `add-headers.hs`

In alcuni casi il documento da tradurre potrebbe contenere headers in una struttura non gerarchica, che crea errori quando si cerca di convertire l'RST in HTML tramite Sphinx. Usando questo filtro vengono aggiunti gli header dove mancano, con un testo di riempimento (_header added by pandoc_)

### `loosen-lists.hs`

Fa in modo che le liste vengano scritte mantenendo uno spazio fra ogni elemento. Può essere utile quando si usa pandoc come linter per processare documenti già in formato RST

### `remove-divs.hs`

Elimina gli elementi `div` dal documento, utile quando si usi pandoc per convertire un file da HTML a RST

### `remove-quotes.hs`

A volte pandoc interpreta i blocchi di testo con indentazione come una citazione (quote). Nel caso in cui questo non fosse desiderato, applicare questo filtro eliminerà le citazioni

### `to-sphinx.hs`

Produce files pronti da essere usati con Sphinx. Questo filtro è ancora in via di miglioramento, se siete interessati ad utilizzarlo per favore mettetevi in contatto col team di Docs Italia

