package Clang::CastXML::XML;

use Moo;
use 5.020;
use experimental qw( signatures );

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

1;
