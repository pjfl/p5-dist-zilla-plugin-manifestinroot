<div>
    <a href="https://travis-ci.org/pjfl/p5-dist-zilla-plugin-manifestinroot"><img src="https://travis-ci.org/pjfl/p5-dist-zilla-plugin-manifestinroot.svg?branch=master" alt="Travis CI Badge"></a>
    <a href="http://badge.fury.io/pl/Dist-Zilla-Plugin-ManifestInRoot"><img src="https://badge.fury.io/pl/Dist-Zilla-Plugin-ManifestInRoot.svg" alt="CPAN Badge"></a>
    <a href="http://cpants.cpanauthors.org/dist/Dist-Zilla-Plugin-ManifestInRoot"><img src="http://cpants.cpanauthors.org/dist/Dist-Zilla-Plugin-ManifestInRoot.png" alt="Kwalitee Badge"></a>
</div>

# Name

Dist::Zilla::Plugin::ManifestInRoot - Puts the MANIFEST file in the project root

# Synopsis

    # In your dist.ini
    [ManifestInRoot]

# Version

This documents version v0.6.$Rev: 1 $ of [Dist::Zilla::Plugin::ManifestInRoot](https://metacpan.org/pod/Dist::Zilla::Plugin::ManifestInRoot)

# Description

Puts the `MANIFEST` file in the project root so that it can be used by
other programs, e.g. `module_provision update_version 0.1 0.2`

# Configuration and Environment

None

# Subroutines/Methods

## after\_build

Copy the `MANIFEST` file from the build directory to the project root

## before\_build

Delete the existing `MANIFEST` file

## gather\_files

Create the content providing callback

# Diagnostics

None

# Dependencies

- [Dist::Zilla::Role::InstallTool](https://metacpan.org/pod/Dist::Zilla::Role::InstallTool)
- [File::Slurp](https://metacpan.org/pod/File::Slurp)
- [Moose](https://metacpan.org/pod/Moose)

# Incompatibilities

There are no known incompatibilities in this module

# Bugs and Limitations

There are no known bugs in this module. Please report problems to
http://rt.cpan.org/NoAuth/Bugs.html?Dist=Dist-Zilla-Plugin-ManifestInRoot.
Patches are welcome

# Acknowledgements

Larry Wall - For the Perl programming language

# Author

Peter Flanigan, `<pjfl@cpan.org>`

# License and Copyright

Copyright (c) 2015 Peter Flanigan. All rights reserved

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself. See [perlartistic](https://metacpan.org/pod/perlartistic)

This program is distributed in the hope that it will be useful,
but WITHOUT WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE
