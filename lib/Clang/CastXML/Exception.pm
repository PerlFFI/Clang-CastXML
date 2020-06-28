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

=head1 DESCRIPTION

=head1 ROLES

This class consumes the L<Throwable> and L<StackTrace::Auto> roles.

=cut

with 'Throwable', 'StackTrace::Auto';

=head1 METHODS

=head2 message

=cut

sub message ($self) { die("no message method defined for $self") }

=head2 to_string

=cut

sub to_string ($self)
{
  my $frame = $self->stack_trace->frame(0);
  return sprintf "%s at %s line %s", $self->message, $frame->filename, $frame->line;
}

1;
