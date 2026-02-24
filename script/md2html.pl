#!/usr/bin/env perl

# read from std in for every element in @ARGV
# if stdin is empty open $ARGV[n] as file
# if ARGV is empty read stdin until eof
use Object::Pad ':experimental(:all)';

package md2html::cli;

class md2html::cli;

use lib 'lib';

use v5.40;

use Getopt::Long qw(GetOptionsFromArray :config no_ignore_case);
use Syntax::Keyword::Defer;
use Const::Fast;
use Path::Tiny;
use IPC::Nosh::IO;

use App::md2html;

const our $NO_FILENAME => '-';

#field $parser;

field $infile : reader = [];
field $outfile = [];

field $cliopt :
  reader { { infile => $infile, charset => 'UTF-8', $outfile => $outfile } };

field $parser : reader {
    md2html->new(
        encoding_in  => $$cliopt{charset},
        encoding_out => $$cliopt{outcharset}
    )
};

field $done;

method run {
    dmsg $infile;

    push @$infile, $STDIN unless scalar @$infile;

    foreach my $file (@$infile) {
        state $i = 0;
        defer { $i++ };

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

        my $body = $self->parser->to_html($instr);

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

    my $self = $class->new;

    GetOptionsFromArray(
        $argv,
        $self->cliopt,
        'outfile=s{,}',
        'charset|encoding|inencoding=s',
        'outcharset|outencoding|outencode=s',
        'stylesheet=s',
        'passthrough=s',    # TODO: passthrough based on file ext
        '<>' => sub ($file) {
            push $self->infile->@*, $file;
        }
    );

    $self->run;
}

md2html::cli->cli( \@ARGV )
