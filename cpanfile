requires 'perl', 'v5.40';

requires 'Syntax::Keyword::Defer';
requires 'Syntax::Keyword::Dynamically';
requires 'IO::Handle::Common';
requires 'Path::Tiny';
requires 'Const::Fast';
requires 'Text::Markdown::Hoedown';
requires 'Object::Pad';
requires 'HTML::Escape';

on test => sub {
    requires 'Test::More', '0.96';
};
