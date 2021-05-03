package Clang::CastXML::Exception::ParseException;

use Moo;
use 5.022;
use experimental qw( signatures );

# ABSTRACT: Exception for when XML parsing fails
# VERSION

=head1 DESCRIPTION

This class represents a XML parser error for CastXML.

=head1 EXTENDS

This class extends L<Clang::CastXML::Exception>.

=cut

extends 'Clang::CastXML::Exception';

=head1 METHOD

=head2 message

 my $message = $ex->message;

Returns the message for the exception.

=cut

sub message ($self)
{
  defined $self->previous_exception
    ? ($self->previous_exception =~ s/\s+$//r =~ s/^\s+//r) . "\nXML Parser exception"
    : "XML Parser exception";
}

1;

=head1 SEE ALSO

L<Clang::CastXML>, L<Clang::CastXML::Exception>

=cut
