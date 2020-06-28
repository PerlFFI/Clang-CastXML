use Test2::V0 -no_srand => 1;
use Clang::CastXML;
use Path::Tiny qw( path );
use Test::XML;
use experimental qw( postderef );

subtest 'basic' => sub {

  my $xml;

  is(
    $xml = Clang::CastXML->new->introspect('int add1(int,int); extern "C" int add2(int,int);'),
    object {
      call [ isa => 'Clang::CastXML::Container' ] => T();
      call result => object {
        call [ isa => 'Clang::CastXML::Wrapper::Result' ] => T();
      };
      call source => object {
        call [ isa => 'Path::Tiny' ] => T();
        call basename => match qr/\.C$/;
      };
      call dest => object {
        call [ isa => 'Path::Tiny' ] => T();
        call basename => match qr/\.xml$/;
      };
    },
  );

  is_well_formed_xml($xml->to_xml);

  my $perl = $xml->to_href;

  my %func = map { $_->{name} => $_ } grep { $_->{_class} eq 'Function' } $perl->{inner}->@*;

  is(
    \%func,
    hash {
      field add1 => hash {
        field mangled => T();
        etc;
      };
      field add2 => hash {
        field mangled => DNE();
        etc;
      };
      etc;
    },
    'work around name mangle bug',
  );
  use YAML ();
  note YAML::Dump(\%func);

};

done_testing;
