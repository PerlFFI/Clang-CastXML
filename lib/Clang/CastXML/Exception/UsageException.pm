package Clang::CastXML::Exception::UsageException;

use Moo;
use 5.020;
use experimental qw( signatures );

# ABSTRACT: Exception for when the Clang::CastXML is fed rubbish
# VERSION

=head1 DESCRIPTION

This class represents a usage exception.  Usually when you provide the wrong
types of arguments to a method or function.

=head1 EXTENDS

This class extends L<Clang::CastXML::Exception>.

=cut

extends 'Clang::CastXML::Exception';

=head1 PROPERTIES

=head2 diagnostic

 my $diag = $ex->diagnostic;

This returns a concise diagnostic of what usage was wrong.

=cut

has diagnostic => (
  is       => 'ro',
  required => 1,
);

=head1 METHODS

=head2 message

 my $message = $ex->message;

This returns the exception message.

=cut

sub message { shift->diagnostic }

1;

=head1 SEE ALSO

L<Clang::CastXML>, L<Clang::CastXML::Exception>

=cut
