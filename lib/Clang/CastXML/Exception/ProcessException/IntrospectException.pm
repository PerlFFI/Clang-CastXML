package Clang::CastXML::Exception::ProcessException::IntrospectException;

use Moo;
use 5.020;
use experimental qw( signatures );

# ABSTRACT: Exception for when castxml fails introspection
# VERSION

=head1 DESCRIPTION

This class represents an exception when trying to introspect C/C++
code by running CastXML.

=head1 EXTENDS

This class extends L<Clang::CastXML::Exception::ProcessException>.

=cut

extends 'Clang::CastXML::Exception::ProcessException';

=head1 METHODS

=head2 message

 my $message = $ex->message;

Returns the exception message.

=cut

sub message ($self)
{
  my $err = $self->result->err =~ s/\s+$//r =~ s/^\s+//r;
  $err ne ''
    ? "$err\nerror calling castxml for introspection"
    : "error calling castxml for introspection";
}

1;

=head1 SEE ALSO

L<Clang::CastXML>, L<Clang::CastXML::Exception>,
L<Clang::CastXML::Exception::ProcessException>

=cut
