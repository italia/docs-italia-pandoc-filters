# Testing

There is a script which will run existing tests, it can easily be run:

    $ ./test

Every test contains an `in.native` and an `out.native` file, and it's
contained in a directory whose name corresponds to the filter to be
tested. The idea is that the `out.native` file can be achieved
running:

    $ pandoc in.native --filter <filter name> -o out.native

This is more than enough in order to test filters, since they can only
affect the native format. Pandoc's options don't matter

