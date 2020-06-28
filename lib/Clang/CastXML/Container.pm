package Clang::CastXML::Container;

use Moo;
use 5.020;
use experimental qw( signatures );
use XML::Parser;

# ABSTRACT: Container class for XML output from CastXML
# VERSION

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 PROPERTIES

=head2 result

=head2 source

=head2 dest

=cut

has $_ => (
  is       => 'ro',
  required => 1,
) for qw( result source dest );

=head1 METHODS

=head2 to_xml

 my $xml = $xml->to_xml;

Returns the raw XML as a utf-8 string.

=cut

sub to_xml ($self)
{
  return $self->dest->slurp_utf8;
}

=head2 to_href

=cut

sub to_href ($self)
{
  my $cur = { inner => [] };
  my @stack;

  my $parser = XML::Parser->new(
    Handlers => {
      Start => sub ($, $element, %attrs) {

        # Fixups
        delete $attrs{location}; # redundant
        if($element eq 'Function')
        {
          # TODO: This works for current Clang (probably).  If we need to
          # support other compiles, like Visual C++ this computed
          # mangle will probably have to be updated.
          my $bad_mangle = '_Z' . length($attrs{name}) . $attrs{name};
          delete $attrs{mangled} if $attrs{mangled} eq $bad_mangle;
        }

        my $inner = ( $cur->{inner} //= [] );
        push @stack, $cur;
        $cur = {
          _class => $element,
          %attrs,
        };
        push @$inner, $cur;
      },
      End   => sub ($, $element) {
        my $save = $cur;
        $cur = pop @stack;

        delete $save->{file} if defined $save->{file} && $save->{file} eq ($cur->{file} // '');
        delete $save->{line} if defined $save->{line} && $save->{line} eq ($cur->{line} // '');
      }
    },
  );

  my $fh = $self->dest->openr;
  $parser->parse($fh);

  return $cur->{inner}->[0];
}

1;
