{-

Questo filtro modifica gli acronimi in un documento applicando i
consigli della Guida al linguaggio della Pubblica Amministrazione che
trovate al seguente indirizzo:

http://guida-linguaggio-pubblica-amministrazione.readthedocs.io/it/latest/le-parole-della-pubblica-amministrazione/a.html

-}
#!/usr/bin/env runhaskell
import Text.Pandoc.JSON
import Text.Pandoc.Definition
import Data.List

-- parte leggibile anche da chi non è esperto di programmazione

operazioni = (sostituzione ("ANPR" `e` "anpr" `diventa` "Anpr")) `e`
             (sostituzione ("ANAS" `e` "anas" `diventa` "Anas"))

-- qui sotto ci sono le basi che rendono il filtro eseguibile

e a b = [a, b]

diventa = (,)

serie [o1, o2] = o1 . o2

sostituzione :: ([String], String) -> Inline -> Inline
sostituzione  configurazione (Str s)
  | elem s insieme = Str sostituto
  | otherwise      = Str s
  where (insieme, sostituto) = configurazione

main = toJSONFilter $ serie operazioni
