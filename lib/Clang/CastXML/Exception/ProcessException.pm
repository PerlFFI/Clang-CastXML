package Clang::CastXML::Exception::ProcessException;

use Moo;
use 5.020;
use experimental qw( signatures );

# ABSTRACT: Exception for when the CastXML process fails
# VERSION

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EXTENDS

This class extends L<Clang::CastXML::Exception>.

=cut

extends 'Clang::CastXML::Exception';

=head1 PROPERTIES

=head2 result

=cut

has result => (
  is       => 'ro',
  required => 1,
);

1;
