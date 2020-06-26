package Clang::CastXML::Wrapper::Result;

use Moo;
use 5.020;
use experimental qw( signatures );

# ABSTRACT: The result of a Clang::CastXML::Wrapper run
# VERSION

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 PROPERTIES

=head2 wrapper

=head2 args

=head2 out

=head2 err

=head2 ret

=head2 sig

=cut

has $_ => (
  is       => 'ro',
  required => 1,
) for qw( wrapper args out err ret sig );

=head1 METHODS

=head2 is_success

=cut

sub is_success ($self)
{
  $self->ret == 0 && $self->sig == 0;
}

1;
