#!/usr/bin/env perl
package App::md2html::AuthorTest;

use v5.40;
use lib 'lib';

use IO::Handle::Common;
use Path::Try;
use App::md2html;
use IPC::Nosh;

our $verbose = 1;

sub md2html_pl ($inpath) {
    $inpath = path($inpath);
    run(
        [ qw'md2html', $inpath->absolute ],
        in  => path('README.md')->openr_utf8,
        out => sub ( $line, @ ) {
            say STDOUT "md2html.pl: $line" if $verbose;
        },
        autochomp => 1
    );
}
