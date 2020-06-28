package Clang::CastXML;

use Moo;
use 5.020;
use experimental qw( signatures );
use Ref::Util qw( is_blessed_ref is_ref );
use Clang::CastXML::Container;
use Path::Tiny ();
use Carp ();
use Clang::CastXML::Exception::ProcessException::IntrospectException;

# ABSTRACT: C-family abstract syntax tree output tool
# VERSION

=head1 SYNOPSIS

 use Clang::CastXML;
 use Path::Tiny qw( path );
 
 my $castxml = Clang::CastXML->new;
 my $container = $castxml->introspect( path('foo.C') );
 my $raw_xml = $container->to_xml;

=head1 DESCRIPTION

This class provides an interface to CastXML for introspecting C/C++ code.
This can be useful for writing FFI or XS bindings.

=head1 PROPERTIES

=head2 wrapper

 my $wrapper = $castxml->wrapper;

Returns the L<Clang::CastXML::Wrapper> instance.  The default is usually reasonable.

=cut

has wrapper => (
  is      => 'ro',
  lazy    => 1,
  default => sub {
    require Clang::CastXML::Wrapper;
    Clang::CastXML::Wrapper->new;
  },
);

=head1 METHODS

=head2 introspect

 my $container = $castxml->introspect($source);
 my $container = $castxml->introspect($source, $dest);

This runs CastXML on the given source and returns an XML container which can be used
to get the raw XML, or to convert it to a more useful format.

C<$source> should be either a L<Path::Tiny> object for the C/C++ source file, or
a string containing the C/C++ source.

C<$dest> is optional, and if provided should be a L<Path::Tiny> object where the
XML will be written.  If not provided, then a temporary file will be created.

C<$container> is an instance of L<Clang::CastXML::Container>.

If an error happens during the introspection, an exception will be thrown.

=cut

sub introspect ($self, $source, $dest=undef)
{
  if(is_blessed_ref $source && $source->isa('Path::Tiny'))
  {
    # nothing to do
  }
  elsif(!is_ref $source && defined $source)
  {
    my $content = $source;
    $source = Path::Tiny->tempfile(
      TEMPLATE => 'castxml-XXXXXX',
      SUFFIX   => '.C',
    );
    $source->spew_utf8($content);
  }
  else
  {
    Carp::croak("Source should be either a Path::Tiny instance or string containing the C source");
  }

  $dest //= Path::Tiny->tempfile(
    TEMPLATE => 'castxml-XXXXXX',
    SUFFIX   => '.xml',
  );

  my $result = $self->wrapper->raw("--castxml-output=1", "-o" => "$dest", "$source");

  if($result->is_success)
  {
    return Clang::CastXML::Container->new(
      result => $result,
      source => $source,
      dest   => $dest,
    );
  }
  else
  {
    Clang::CastXML::Exception::ProcessException::IntrospectException->throw(
      result => $result,
    );
  }
}

1;
