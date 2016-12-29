package Dist::Zilla::Plugin::ManifestInRoot;

use namespace::autoclean;
use version; our $VERSION = qv( sprintf '0.16.%d', q$Rev: 1 $ =~ /\d+/gmx );

use Moose;
use Dist::Zilla::File::FromCode;
use File::Spec::Functions qw( catfile );
use Path::Tiny qw( path );

with 'Dist::Zilla::Role::AfterBuild';
with 'Dist::Zilla::Role::BeforeBuild';
with 'Dist::Zilla::Role::FileGatherer';

# Public attributes
has 'excludes' => is => 'ro', traits => [ 'Array' ],
   default     => sub { [ qw( LICENSE META.json META.yml README SIGNATURE
                              t/00report-metadata.dd t/00report-metadata.t ) ]},
   handles     => { 'excluding' => 'elements', }, init_arg => 'exclude';

# Private functions
my $_fix_filename = sub {
   my $name = shift; $name =~ m{ [ \'\\] }mx or return $name;

   $name =~ s{ \\ }{\\\\}gmx; $name =~ s{ ' }{\\'}gmx;

   return qq{'$name'};
};

# Public methods
sub after_build {
   my ($self, $args) = @_;

   my $excluding = join '|', $self->excluding;
   my $from      = path( $args->{build_root}, 'MANIFEST' );
   my @lines     = grep { not m{ \A (?: $excluding ) \r?\n \z }mx }
                   $from->lines;
   my $to        = path( $self->zilla->root, 'MANIFEST' );

   $to->spew( @lines );

   return;
}

sub before_build {
   my $self = shift; unlink catfile( $self->zilla->root, 'MANIFEST' ); return;
}

sub gather_files {
   my ($self, $arg) = @_; my $zilla = $self->zilla;

   my $file = Dist::Zilla::File::FromCode->new( {
      name => 'MANIFEST',
      code => sub {
         (join "\n", map { $_fix_filename->( $_ ) }
                sort map { $_->name               } @{ $zilla->files } )."\n";
         },
      } );

   $self->add_file( $file );
   return;
}

sub mvp_multivalue_args {
   return qw( exclude );
}

1;

__END__

=pod

=encoding utf-8

=begin html

<a href="https://travis-ci.org/pjfl/p5-dist-zilla-plugin-manifestinroot"><img src="https://travis-ci.org/pjfl/p5-dist-zilla-plugin-manifestinroot.svg?branch=master" alt="Travis CI Badge"></a>
<a href="http://badge.fury.io/pl/Dist-Zilla-Plugin-ManifestInRoot"><img src="https://badge.fury.io/pl/Dist-Zilla-Plugin-ManifestInRoot.svg" alt="CPAN Badge"></a>
<a href="http://cpants.cpanauthors.org/dist/Dist-Zilla-Plugin-ManifestInRoot"><img src="http://cpants.cpanauthors.org/dist/Dist-Zilla-Plugin-ManifestInRoot.png" alt="Kwalitee Badge"></a>

=end html

=head1 Name

Dist::Zilla::Plugin::ManifestInRoot - Puts the MANIFEST file in the project root

=head1 Synopsis

   # In your dist.ini
   [ManifestInRoot]

=head1 Version

This documents version v0.16.$Rev: 1 $ of L<Dist::Zilla::Plugin::ManifestInRoot>

=head1 Description

Puts the F<MANIFEST> file in the project root so that it can be used by
other programs, e.g. L<App::Cpanminus> and L<Module::Provision>

=head1 Configuration and Environment

Defined these attributes;

=over 3

=item C<excludes>

An array reference of file names to exclude from the root directory copy of the
manifest.  Set using the multivalued initialisation argument C<exclude>.
Defaults to the list of files generated by the build process

=back

=head1 Subroutines/Methods

=head2 after_build

Copy the F<MANIFEST> file from the build directory to the project root filtering
out unwanted files

=head2 before_build

Delete the existing F<MANIFEST> file

=head2 gather_files

Create the content providing callback

=head2 C<mvp_multivalue_args>

Returns a list of configuration attribute names that are treated as
multi valued

=head1 Diagnostics

None

=head1 Dependencies

=over 3

=item L<Dist::Zilla::Role::InstallTool>

=item L<File::Slurp>

=item L<Moose>

=back

=head1 Incompatibilities

There are no known incompatibilities in this module

=head1 Bugs and Limitations

There are no known bugs in this module. Please report problems to
http://rt.cpan.org/NoAuth/Bugs.html?Dist=Dist-Zilla-Plugin-ManifestInRoot.
Patches are welcome

=head1 Acknowledgements

Larry Wall - For the Perl programming language

=head1 Author

Peter Flanigan, C<< <pjfl@cpan.org> >>

=head1 License and Copyright

Copyright (c) 2015 Peter Flanigan. All rights reserved

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself. See L<perlartistic>

This program is distributed in the hope that it will be useful,
but WITHOUT WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE

=cut

# Local Variables:
# mode: perl
# tab-width: 3
# End:
