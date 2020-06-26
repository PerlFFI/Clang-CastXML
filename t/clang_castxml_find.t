use Test2::V0 -no_srand => 1;
use Clang::CastXML::Find;
use Path::Tiny qw( path );
use Env qw( @PATH );

delete $ENV{PERL_CLANG_CASTXML_PATH};
@PATH = ();

subtest 'env var' => sub {

  local $ENV{PERL_CLANG_CASTXML_PATH} = path('corpus/bin/castxml')->absolute->stringify;

  my $exe = Clang::CastXML::Find->where;
  ok -e $exe, 'found castxml executable';

};

subtest 'path' => sub {

  local $ENV{PATH} = $ENV{PATH};
  @PATH = path('corpus/bin')->absolute->stringify;

  my $exe = Clang::CastXML::Find->where;
  ok -e $exe, 'found castxml executable';

};

subtest 'fail' => sub {

  is(
    dies { Clang::CastXML::Find->where },
    match qr/Unable to find castxml/,
    'no found castxml executable'
  );

};

done_testing;
