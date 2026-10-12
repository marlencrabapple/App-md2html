#!/usr/bin/env perl

use Object::Pad ':experimental(:all)';

package md2html::cli;

class md2html::cli;

use v5.40;

use Getopt::Long qw(GetOptionsFromArray :config no_ignore_case);
use Syntax::Keyword::Defer;
use Const::Fast;
use Path::Tiny;
use IO::Handle::Common;
use List::Util qw'any first';
use App::md2html;
use builtin;

const our $NO_FILENAME => '-';

field $infile  : reader : param(in)  = [];
field $outfile : reader : param(out) = [];
field $cliopt  : reader;
field $md2html : reader;

ADJUST : params (%param) {
    $cliopt  = \%param;
    $md2html = App::md2html->new(
        map { ( ( $_ =~ s/-/_/rg ) => $$cliopt{$_} ) }
          keys %$cliopt
    );
    dmsg $self
  }

  method run ( $infile, $outfile ) {
    push @$infile, $STDIN unless scalar @$infile;

    foreach my ( $i, $file ) ( builtin::indexed @$infile ) {
        my $instr;

        if ( !-t STDIN ) {
            my @lines = <STDIN>;
            $instr = join "", @lines;
        }
        else {
            if ( !$file || $file eq $NO_FILENAME ) {
                fatal "No input provided.";
            }
            my $file = path($file);
            $instr = $file->slurp_raw;
        }

        my $body = $md2html->convert($instr);

        # TODO: create output file from mask string
        if ( my $outfile = $$outfile[$i] ) {
            path($outfile)->spew($body);
        }
        else {
            say $body if $body;
        }
    }
}

method cli : common ( $argv = \@ARGV ) {
    my %cliopt = ( in => [], out => [] );

    GetOptionsFromArray(
        $argv,
        \%cliopt,

        'infile=s@',
        'outfile=s@',

        'encoding-in|charset|charset-in|encoding|inencoding=s',
        'encoding-out|outcharset|outencoding|outencode|charset-out=s',

        'css|stylesheeet:s',

        'toc:s',

        'htmldoc|html-document|full-html|html-page!',

        #'doctype:s',
        #'header:s',
        'embedded|fragment',

        'html-ver=s',
        'xhtml',
        'html5',
        'minify=s',
        'no-minify',

        #'passthrough=s',    # TODO: passthrough based on file ext
        'debug+',
        'verbose+',
        '<>' => sub ($infile) {
            push $cliopt{in}->@*, $infile;
        }
    );

    my $in  = delete $cliopt{in};
    my $out = delete $cliopt{out};

    my $md2html = $class->new(%cliopt);
    $md2html->run( $in, $out );

    $md2html;
}

package md2html;

use v5.40;

use IO::Handle::Common;

our $cli = md2html::cli->cli( \@ARGV );
dmsg $cli;
