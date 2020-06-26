package Clang::CastXML::Wrapper;

use Moo;
use 5.020;
use experimental qw( signatures );
use Carp ();
use Capture::Tiny ();
use Clang::CastXML::Wrapper::Result;

# ABSTRACT: Lowish level wrapper around the CastXML binary
# VERSION

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 PROPERTIES

=head2 exe

 my $exe = $wrapper->exe;

Returns the path to the castxml executable used by the wrapper class.

=cut

has exe => (
  is      => 'ro',
  lazy    => 1,
  default => sub {
    require Clang::CastXML::Find;
    Clang::CastXML::Find->where;
  },
);

=head1 METHODS

=head2 raw

 my $result = $wrapper->raw(@arguments);

Runs the castxml command with the given arguments.  The result is a hash
ref with these keys:

=over 4

=item out

The stdout of the process.

=item err

The stderr of the process.

=item ret

The return value of the process (0 is for success)

=item sig

The signal that terminated the process, if any

=back

=cut

sub raw ($self, @arguments)
{
  my($out,$err,$ret,$sig) = Capture::Tiny::capture {
    system $self->exe, @arguments;
    ($? >> 8,$? & 127);
  };

  Clang::CastXML::Wrapper::Result->new(
    wrapper => $self,
    args    => [@arguments],
    out => $out, err => $err, ret => $ret, sig => $sig,
  );
}

1;
