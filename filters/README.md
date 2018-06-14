
Qui collezioniamo alcuni filtri che ci sono stati utili per tradurre
documenti con Pandoc. I filtri si possono utilizzare usando l'opzione
`--filter <nome filtro>` quando si esegue pandoc. Per maggiori
informazioni consultate [la documentazione Pandoc sui filtri (in
inglese)](http://pandoc.org/filters.html)

### `filtro-didascalia.hs`

Permette di convertire correttamente immagini con didascalia. Si
aspetta un paragrafo contenente solo un'immagine seguito da un
paragrafo formattato con stile didascalia. Richiede che pandoc sia
eseguito con l'opzione `-f docx+styles`

### `filtro-quotes.hs`

A volte pandoc interpreta i blocchi di testo con indentazione come una citazione (quote). Nel caso in cui questo non fosse desiderato, applicare questo filtro eliminerà le citazioni

### `filtro-acronimi.hs`

Un filtro creato per fini dimostrativi, più leggibile degli altri

### `filtro-stile-liste.hs`

Fa in modo che le liste vengano scritte mantenendo uno spazio fra ogni elemento. Può essere utile quando si usa pandoc come linter per processare documenti già in formato RST

### `bold-headers.hs`

Quando si converte da PDF a DOCX a volte gli headers vengono
interpretati semplicemente come testo in grassetto, e questo impedisce
la generazione di un indice per la documentazione. Questo filtro
individua i paragrafi che contengono solo testo in grassetto e li
converte in headers. È un processo soggetto ad errore ma in alcuni
casi può ridurre il lavoro richiesto per la pubblicazione. Il filtro
converte i paragrafi in grassetto in headers di livello 2 ma si può
modificare facilmente per usare un altro livello

### `remove-page-numbers.hs`

Quando si converte da PDF a DOCX a volte i numeri di pagina rimangono
nel corpo del documento. Questo filtro rimuove i paragrafi che
contengono solo un numero intero.

### `add-headers.hs`

In alcuni casi il documento da tradurre potrebbe contenere headers in una struttura non gerarchica, che crea errori quando si cerca di convertire l'RST in HTML tramite Sphinx. Usando questo filtro vengono aggiunti gli header dove mancano, con un testo di riempimento (_header added by pandoc_)

### `filtro-rimuovi-div.hs`

Elimina gli elementi `div` dal documento, utile quando si usi pandoc
per convertire un file da HTML ad rST. Utile anche quando pandoc viene
invocato con l'opzione `-f docx+styles` che introduce molti div
indicanti lo stile del documento originale `.docx`

#### Nota sui nomi

Alcuni di questi filtri hanno un nome che comincia con `filtro-`. Questi filtri possono essere installati nel sistema dell'utente ed eseguiti utilizzando il loro nome, per questo aggiungiamo il prefisso `filtro-` in modo da ridurre il rischio di conflitti con altri comandi già esistenti nel sistema.

```
 ~ $ pandoc -t json | filtro-acronimi | pandoc -f json
ANAS
<p>Anas</p>
 ~ $ 
```

