requires 'perl', 'v5.40';

requires 'IO::Handle::Common', '0.01_3',
  dist => 'CRABAPP/IO-Handle-Common-0.01_3-TRIAL.tar.gz';

requires 'Object::Pad',                     '0.825';
requires 'XS::Parse::Sublike',              '0.41';
requires 'MIME::Type',                      '2.30';
requires 'Unicode::UTF8',                   '0.75';
requires 'HTML::Escape',                    '1.11';
requires 'Sub::Exporter::Progressive',      '0.001013';
requires 'Class::Exporter',                 '0.03';
requires 'MIME::Types',                     '2.30';
requires 'Text::Markdown::Hoedown',         '1.03';
requires 'Const::Fast',                     '0.014';
requires 'Data::Dumper::Names',             '0.03';
requires 'Devel::StackTrace::Frame',        '2.05';
requires 'Path::Tiny',                      '0.150';
requires 'Devel::StackTrace::WithLexicals', '2.01';
requires 'XS::Parse::Keyword',              '0.49';
requires 'Syntax::Keyword::Defer',          '0.11';
requires 'Syntax::Keyword::Dynamically',    '0.14';
requires 'PadWalker',                       '2.5';
requires 'Devel::StackTrace',               '2.05';
requires 'Object::Pad::MOP::Class',         '0.825';

on test => sub {
    requires 'Test::More', '0.96';
};
