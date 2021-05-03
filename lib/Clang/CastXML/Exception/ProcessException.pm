package Clang::CastXML::Exception::ProcessException;

use Moo;
use 5.022;
use experimental qw( signatures );

# ABSTRACT: Exception for when the CastXML process fails
# VERSION

=head1 DESCRIPTION

This class represents a execution exception while running CastXML.
It shouldn't be thrown directly, instead it is subclassed by
L<Clang::CastXML::Exception::ProcessException::BadCastXMLVersionException>
and
L<Clang::CastXML::Exception::ProcessException::IntrospectException>
which represent specific types of processing exceptions.

=head1 EXTENDS

This class extends L<Clang::CastXML::Exception>.

=cut

extends 'Clang::CastXML::Exception';

=head1 PROPERTIES

=head2 result

 my $result = $ex->result;

This returns the L<Clang::CastXML::Wrapper::Result> of the failed
CastXML run.

=cut

has result => (
  is       => 'ro',
  required => 1,
);

1;

=head1 SEE ALSO

L<Clang::CastXML>, L<Clang::CastXML::Exception>,
L<Clang::CastXML::Exception::ProcessException::BadCastXMLVersionException>,
L<Clang::CastXML::Exception::ProcessException::IntrospectException>

=cut
