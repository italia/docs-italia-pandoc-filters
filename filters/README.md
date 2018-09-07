
Qui collezioniamo alcuni filtri che ci sono stati utili per tradurre
documenti con Pandoc. I filtri si possono utilizzare usando l'opzione
`--filter <nome filtro>` quando si esegue pandoc. Per maggiori
informazioni consultate [la documentazione Pandoc sui filtri (in
inglese)](http://pandoc.org/filters.html)

## Filtri installabili

I nomi di questi filtri cominciano con `filtro-`. Quando si installa
il software in questo repository usando `stack`, questi filtri possono
essere eseguiti utilizzando il loro nome, per questo aggiungiamo il
prefisso `filtro-` in modo da ridurre il rischio di conflitti con
altri comandi già esistenti nel sistema.

I filtri usati da
[`converti`](https://github.com/italia/docs-italia-comandi-conversione/blob/master/doc/comandi/converti.md)
sono [distribuiti in questo
modo](https://github.com/italia/docs-italia-pandoc-filters/releases).

Per esempio, dopo l'installazione, il `filtro-acronimi` può venire
usato con pandoc tramite l'opzione `--filter filtro-acronimi`, oppure
direttamente:

```
 ~ $ pandoc -t json | filtro-acronimi | pandoc -f json
ANAS
<p>Anas</p>
 ~ $ 
```

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

### `filtro-rimuovi-div.hs`

Elimina gli elementi `div` dal documento, utile quando si usi pandoc
per convertire un file da HTML ad rST. Utile anche quando pandoc viene
invocato con l'opzione `-f docx+styles` che introduce molti div
indicanti lo stile del documento originale `.docx`

### `filtro-references`

Sostituisce i link con i references, vedi
https://github.com/italia/docs-italia-comandi-conversione/issues/28

### `filtro-merge-code`

Fonde i blocchi codice consecutivi. Vedi https://github.com/italia/docs-italia-comandi-conversione/issues/93

## Altri filtri

Questi filtri sono stati sviluppati per alcuni casi specifici ed usati
più raramente. Possono comunque tornare utili

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

### `link-rfc`

Sostituisce testi come `RFC 1234` con links allo specifico RFC, come
per esempio https://tools.ietf.org/html/rfc1234. Vedi [la issue
corrispondente
](https://github.com/italia/docs-italia-comandi-conversione/issues/27)
per maggiori informazioni


