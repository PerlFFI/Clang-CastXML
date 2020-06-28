# Clang::CastXML [![Build Status](https://travis-ci.org/PerlFFI/Clang-CastXML.svg)](http://travis-ci.org/PerlFFI/Clang-CastXML) ![windows](https://github.com/PerlFFI/Clang-CastXML/workflows/windows/badge.svg) ![macos](https://github.com/PerlFFI/Clang-CastXML/workflows/macos/badge.svg)

C-family abstract syntax tree output tool

# SYNOPSIS

```perl
use Clang::CastXML;
use Path::Tiny qw( path );

my $castxml = Clang::CastXML->new;
my $container = $castxml->introspect( path('foo.C') );
my $raw_xml = $container->to_xml;
```

# DESCRIPTION

This class provides an interface to CastXML for introspecting C/C++ code.
This can be useful for writing FFI or XS bindings.

# PROPERTIES

## wrapper

```perl
my $wrapper = $castxml->wrapper;
```

Returns the [Clang::CastXML::Wrapper](https://metacpan.org/pod/Clang::CastXML::Wrapper) instance.  The default is usually reasonable.

# METHODS

## introspect

```perl
my $container = $castxml->introspect($source);
my $container = $castxml->introspect($source, $dest);
```

This runs CastXML on the given source and returns an XML container which can be used
to get the raw XML, or to convert it to a more useful format.

`$source` should be either a [Path::Tiny](https://metacpan.org/pod/Path::Tiny) object for the C/C++ source file, or
a string containing the C/C++ source.

`$dest` is optional, and if provided should be a [Path::Tiny](https://metacpan.org/pod/Path::Tiny) object where the
XML will be written.  If not provided, then a temporary file will be created.

`$container` is an instance of [Clang::CastXML::Container](https://metacpan.org/pod/Clang::CastXML::Container).

May throw an exception:

- [Clang::CastXML::Exception::UsageException](https://metacpan.org/pod/Clang::CastXML::Exception::UsageException)

    If you pass in a `$source` or `$dest` of the wrong type.

- [Clang::CastXML::Exception::ProcessException::IntrospectException](https://metacpan.org/pod/Clang::CastXML::Exception::ProcessException::IntrospectException)

    If there is an error running the `castxml` executable.

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2020 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
