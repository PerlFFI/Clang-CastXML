package Clang::CastXML::Exception::ProcessException::IntrospectException;

use Moo;
use 5.020;
use experimental qw( signatures );

# ABSTRACT: Exception for when castxml fails introspection
# VERSION

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EXTENDS

This class extends L<Clang::CastXML::Exception::ProcessException>.

=cut

extends 'Clang::CastXML::Exception::ProcessException';

=head1 METHODS

=head2 message

=cut

sub message ($self)
{
  $self->result->err . "\nerror calling castxml for introspection"
}

1;
