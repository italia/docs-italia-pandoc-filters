# Testing

There is a script which will run existing tests, it can easily be run
from the repo root:

    $ stack exec test

Every test contains an `in.native` and an `out.native` file, and it's
contained in a directory whose name corresponds to the filter to be
tested. The idea is that the `out.native` file can be achieved
running:

    $ pandoc in.native --filter <filter name> -o out.native

This is more than enough in order to test filters, since they can only
affect the native format. Pandoc's options don't matter

While developing `test.hs` i often did experiments with the
interpreter. You can do so running:

    $ stack ghci test.hs

Keep in mind that most Turtle statements return values that do not
implement Show. You can see the results using `view`, for instance:

    *Main> view (inDir "tests/remove-page-numbers/1" (testAndReport "tests/remove-page-numbers/1"))
