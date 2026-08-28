requires 'perl', 'v5.40';

requires 'Getopt::Long';
requires 'Syntax::Keyword::Defer';
requires 'Syntax::Keyword::Dynamically';
requires 'IO::Handle::Common';
requires 'Path::Tiny';
requires 'Const::Fast';
requires 'Text::Markdown::Hoedown';
requires 'Object::Pad';
requires 'HTML::Escape';
requires 'MIME::Types';

on test => sub {
    requires 'Test::More', '0.96';
};
