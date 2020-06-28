package Clang::CastXML::Exception;

use Moo;
use 5.020;
use experimental qw( signatures );
use overload
  '""' => sub { shift->to_string . "\n" },
  bool => sub { 1 }, fallback => 1;

# ABSTRACT: Base exception class for Clang::CastXML
# VERSION

=head1 SYNOPSIS

 package Clang::CastXML::Exception::MyException {
   use Moose;
 
   extends 'Clang::CastXML::Exception';
   has x => ( is => 'ro' );
 
   sub message
   {
     my($self) = @_;
     sprintf "oops error with x = %d", $self->x;
   }
 }
 
 # dies with an object expression tha stringifies to
 # "oops error with x = 1 at xxx.pl line xxx"
 Clang::CastXML::Exception::MyException->throw( x => 1);

=head1 DESCRIPTION

This is the base class for exceptions thrown by L<Clang::CastXML>.  It
keeps track of the stack where the exception is thrown, and stringifies
to a useful message.  Subclasses may add appropriate properties, and
must define a message method that generates the exception message.

=head1 ROLES

This class consumes the L<Throwable> and L<StackTrace::Auto> roles.

=cut

with 'Throwable', 'StackTrace::Auto';

=head1 METHODS

=head2 message

 my $message = $ex->message;

Get the message for the exception.  This must be defined in the subclass.

=cut

sub message ($self) { die "no message method defined for $self" }

=head2 to_string

 my $string = $ex->to_string;
 my $string = "$ex";

Generate the human readable string diagnostic for the exception.

=cut

sub to_string ($self)
{
  my $frame = $self->stack_trace->frame(0);
  return sprintf "%s at %s line %s", $self->message, $frame->filename, $frame->line;
}

1;

=head1 SEE ALSO

L<Clang::CastXML>

=cut
