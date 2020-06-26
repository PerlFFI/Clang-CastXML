package mymm;

use strict;
use warnings;
use 5.020;

sub myWriteMakefile
{
  my %args = @_;

  {
    local $@ = '';
    my $exe = eval { require './lib/Clang/CastXML/Find.pm'; Clang::CastXML::Find->where };
    if(my $error = $@)
    {
      say STDERR "Unable to find CastXML.  Install the package with your package manager,";
      say STDERR "or set PERL_CLANG_CASTXML_PATH to the full path location of your castxml";
      say STDERR "error:$error";
      exit;
    }
    say "found castxml at:";
    say $exe;
  }

  require ExtUtils::MakeMaker;
  ExtUtils::MakeMaker::WriteMakefile(%args);
}

1;
