requires 'perl', 'v5.40';

requires 'Syntax::Keyword::Defer';
requires 'Syntax::Keyword::Dynamically';
requires 'IO::Handle::Common';
requires 'Path::Tiny';
requires 'Const::Fast';
requires 'Text::Markdown::Hoedown';
requires 'Object::Pad';
requires 'HTML::Escape';

feature 'md2html.pl' => sub {
  recommends 'App::md2html';
  recommends 'Text::Markdown::Hoedown';
};

on test => sub {
    requires 'Test::More', '0.96';
};
