package Clang::CastXML::Wrapper::Result;

use Moo;
use 5.022;
use experimental qw( signatures );

# ABSTRACT: The result of a Clang::CastXML::Wrapper run
# VERSION

=head1 SYNOPSIS

 use Clang::CastXML::Wrapper;
 
 my $wrapper = Clang::CastXML::Wrapper->new;
 my $result = $wrapper->raw('--version');

=head1 DESCRIPTION

This class represents the result of running CastXML.

=head1 PROPERTIES

=head2 wrapper

 my $wrapper = $result->wrapper;

Returns the L<Clang::CastXML::Wrapper> which ran CastXML.

=head2 args

 my @args = $result->args->@*;

Returns the arguments passed to CastXML.

=head2 out

 my $out = $result->out;

Returns the standard output.

=head2 err

 my $err = $result->err;

Returns the standard error.

=head2 ret

 my $ret = $result->ret;

Returns the command return value.

=head2 sig

 my $sig = $result->sig;

Returns the signal that killed the process, if any.  If not killed by
signal, this will be zero.

=cut

has $_ => (
  is       => 'ro',
  required => 1,
) for qw( wrapper args out err ret sig );

=head1 METHODS

=head2 is_success

 my $bool = $result->is_success;

Returns true if the run was successful.  That is, if both C<ret> and C<sig> are zero.

=cut

sub is_success ($self)
{
  $self->ret == 0 && $self->sig == 0;
}

1;

=head1 SEE ALSO

L<Clang::CastXML>, L<Clang::CastXML::Wrapper>

=cut
