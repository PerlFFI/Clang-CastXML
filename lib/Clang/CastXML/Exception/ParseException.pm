package Clang::CastXML::Exception::ParseException;

use Moo;
use 5.020;
use experimental qw( signatures );

# ABSTRACT: Exception for when XML parsing fails
# VERSION

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EXTENDS

This class extends L<Clang::CastXML::Exception>.

=cut

extends 'Clang::CastXML::Exception';

=head1 METHOD

=head2 message

=cut

sub message ($self)
{
  defined $self->previous_exception
    ? ($self->previous_exception =~ s/\s+$//r =~ s/^\s+//r) . "\nXML Parser exception"
    : "XML Parser exception";
}

1;
