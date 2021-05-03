package Clang::CastXML::Exception::ProcessException::BadCastXMLVersionException;

use Moo;
use 5.022;
use experimental qw( signatures );

# ABSTRACT: Exception for when we can't find the CastXML version
# VERSION

=head1 DESCRIPTION

This class represents an exception when trying to determine the CastXML
version.

=head1 EXTENDS

This class extends L<Clang::CastXML::Exception::ProcessException>.

=cut

extends 'Clang::CastXML::Exception::ProcessException';

=head1 METHODS

=head2 message

 my $message = $ex->message;

Returns the exception message.

=cut

sub message ($) { "unable to find castxml version" }

1;

=head1 SEE ALSO

L<Clang::CastXML>, L<Clang::CastXML::Exception>,
L<Clang::CastXML::Exception::ProcessException>

=cut
