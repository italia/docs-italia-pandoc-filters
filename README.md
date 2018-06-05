
# Filtri Pandoc per Docs Italia

Questo repository contiene la nostra collezione di filtri pandoc. [Qui](filters/README.md) troverete una breve descrizione per ciascun filtro.

### Breve introduzione ai filtri in pandoc

Un filtro pandoc è un file che contiene istruzioni per modificare un documento, come una macro di Office. I filtri possono essere scritti in qualsiasi linguaggio di programmazione ed applicati a documenti scritti in un qualsiasi formato supportato da pandoc come `.rst`, `.docx`, `.odt`, `.html`, `.markdown`.

Consideriamo il filtro `parole`, che applica i consigli della [Guida al linguaggio della Pubblica Amministrazione](http://guida-linguaggio-pubblica-amministrazione.readthedocs.io/it/latest/le-parole-della-pubblica-amministrazione/a.html) modificando gli acronimi in un documento. Non è necessario essere un programmatore per capire [la logica seguita da questo filtro](filters/parole.hs), che può essere applicato ad un documento così:

    $ pandoc --filter filters/parole.hs da-filtrare.rst -o filtrato.rst

Nel documento `filtrato.rst` gli acronimi per Anas e Anpr saranno tutti corretti. Un filtro è quindi un modo semplice e potente di modificare un documento. Inoltre un filtro è un programma molto portabile, cioè facile da scambiare con i colleghi di altri uffici.

##### Software License

Copyright (c) the respective contributors, as shown by the AUTHORS file.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
