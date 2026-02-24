use Object::Pad ':experimental(:all)';

package md2html;

class md2html;

use v5.40;

our $VERSION = '0.01';

use Encode qw(encode decode);
use Text::Markdown::Hoedown;

field $encoding_in = 'UTF-8';
field $encoding_out { $encoding_in }

field $html_options { HOEDOWN_HTML_HARD_WRAP | HOEDOWN_HTML_ESCAPE }
field $extensions {
    HOEDOWN_EXT_TABLES | HOEDOWN_EXT_FENCED_CODE | HOEDOWN_EXT_FOOTNOTES |
      HOEDOWN_EXT_AUTOLINK | HOEDOWN_EXT_STRIKETHROUGH |
      HOEDOWN_EXT_UNDERLINE | HOEDOWN_EXT_HIGHLIGHT | HOEDOWN_EXT_QUOTE |
      HOEDOWN_EXT_SUPERSCRIPT | HOEDOWN_EXT_MATH;
}

method to_html ($mdstr) {
    my $mdstr = decode( $encoding_in, $mdstr );

    my $out = markdown(
        encode( $encoding_out, $mdstr ),
        html_options => $html_options,
        extensions   => $extensions
    );

    if ( $encoding_in ne $encoding_out ) {

        # TODO: check if decode is needed at all
        $out = encode( $encoding_out, decode( $encoding_in, $out ) );
    }

    $out = qq"<!DOCTYPE html>
     <body>$out</body>
     ";

    $out;
}

method md2html : common ($mdstr, %opt) {
    my $self = $class->new(%opt);
    $self->to_html($mdstr);
}

1;
__END__

=encoding utf-8

=head1 NAME

App::md2html - Blah blah blah

=head1 SYNOPSIS

  use App::md2html;

=head1 DESCRIPTION

App::md2html is

=head1 AUTHOR

Ian P Bradley E<lt>crabapp@hikki.techE<gt>

=head1 COPYRIGHT

Copyright 2026- Ian P Bradley

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
