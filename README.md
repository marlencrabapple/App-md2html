# NAME

App::md2html - Hoedown based Markdown to HTML converter

# SYNOPSIS

## Progmatic Interface

    use App::md2html;

    my $mdstr = q'# Simple Markdown Doc
    ...
    ';

    # OOP interface
    my $md2html = App::md2html->new();
    $md2html->to_html()

## CLI interface: md2html.pl

    $ md2html --html5 --head   -o README.html README.md

# DESCRIPTION

App::md2html is  ...

# AUTHOR

Ian P Bradley <crabapp@hikki.tech>

# COPYRIGHT

Copyright 2026- Ian P Bradley

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO
