# Testing

There is a script which will run existing tests, it can easily be run
from the repo root:

    $ stack test

Every test contains an `in.native` and an `out.native` file, and it's
contained in a directory whose name corresponds to the filter to be
tested. The idea is that the `out.native` file can be achieved
running:

    $ pandoc in.native --filter ../../../filters/<filter name> -o out.native

This is more than enough in order to test filters, since they can only
affect the native format. Most of pandoc's options don't matter.

Some filters might depend on libraries that are provided within the
stack project's dependencies, thus you want to test them using `stack
exec`. For example you can run this command in order to compare the
expected result with the output in `/tmp/out.native`

    $ stack exec -- pandoc --filter filters/filtro-references.hs tests/filtro-references/2/in.native -o /tmp/out.native
    $ meld tests/filtro-references/2/in.native /tmp/out.native

# Developing `test.hs`

While developing `test.hs` i often did experiments with the
interpreter. You can do so running:

    $ stack ghci test.hs

Keep in mind that most Turtle statements return values that do not
implement Show. You can see the results using `view`, for instance:

    *Main> view (inDir "tests/remove-page-numbers/1" (testAndReport "tests/remove-page-numbers/1"))

# New releases

- update the changelog picking a new version number
- update the `.cabal` file
- build and upload the executables on Github as done for previous releases

