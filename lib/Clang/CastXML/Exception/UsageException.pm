package Clang::CastXML::Exception::UsageException;

use Moo;
use 5.020;
use experimental qw( signatures );

# ABSTRACT: Exception for when the Clang::CastXML is fed rubbish
# VERSION

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EXTENDS

This class extends L<Clang::CastXML::Exception>.

=cut

extends 'Clang::CastXML::Exception';

=head1 PROPERTIES

=head2 diagnostic

=cut

has diagnostic => (
  is       => 'ro',
  required => 1,
);

=head1 METHODS

=head2 message

=cut

sub message { shift->diagnostic }

1;
