use Test2::V0 -no_srand => 1;
use Clang::CastXML;
use Path::Tiny qw( path );
use Test::XML;

subtest basic => sub {

  my $xml;

  is(
    $xml = Clang::CastXML->new->introspect(''),
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

};

done_testing;
