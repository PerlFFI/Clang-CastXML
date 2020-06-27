use Test2::V0 -no_srand => 1;
use Clang::CastXML;
use Path::Tiny qw( path );
use Test::XML;

subtest basic => sub {

  my $castxml;

  is(
    $castxml = Clang::CastXML->new,
    object {
      call [ isa => 'Clang::CastXML' ] => T();
      call wrapper => object {
        call [ isa => 'Clang::CastXML::Wrapper' ] => T();
      };
    },
  );

  my @tests = (
    { source => path('corpus/src/simple.C'),             name => 'from file (Path::Tiny)' },
    { source => path('corpus/src/simple.C')->slurp_utf8, name => 'from file (Path::Tiny)' },
  );

  foreach my $t (@tests)
  {
    subtest $t->{name} => sub {
      my $xml;

      is(
        $xml = $castxml->introspect(path('corpus/src/simple.C')),
        object {
          call [ isa => 'Clang::CastXML::XML' ] => T();
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
      note $xml->to_xml;
    };
  }

};

done_testing;
