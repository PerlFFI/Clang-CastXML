package Clang::CastXML::Exception::ProcessException::BadCastXMLVersionException;

use Moo;
use 5.020;
use experimental qw( signatures );

# ABSTRACT: Exception for when we can't find the CastXML version
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

sub message { "unable to find castxml version" }

1;
