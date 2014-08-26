use strict;
use warnings;
use File::Spec::Functions qw( catdir updir );
use FindBin               qw( $Bin );
use lib               catdir( $Bin, updir, 'lib' );

use Test::More;
use Test::Requires { version => 0.88 };
use Module::Build;

my $notes = {}; my $perl_ver;

BEGIN {
   my $builder = eval { Module::Build->current };
      $builder and $notes = $builder->notes;
      $perl_ver = $notes->{min_perl_version} || 5.008;
}

use Test::Requires "${perl_ver}";
use ExtUtils::Manifest;
use Test::DZil;
use Sys::Hostname;

SKIP: {
   hostname eq 'w5050029' and skip 'Fucking broken crap', 1;

   my $tzil = Builder->from_config
      (  { dist_root => 'lib' },
         { add_files => {
            q{source/file with spaces.txt}        => "foo\n",
            # q{source/file\\with some\\whacks.txt} => "bar\n",
            # q{source/'file-with-ticks.txt'}       => "baz\n",
            # q{source/file'with'quotes\\or\\backslash.txt} => "quux\n",
            'source/dist.ini' => simple_ini(
                                            'GatherDir',
                                            'ManifestInRoot',
                                            ),
            },
            },
         );

   $tzil->build;

   my $manihash = ExtUtils::Manifest::maniread
      ( $tzil->root->file( 'MANIFEST' ) );

   is_deeply(
             [ sort keys %$manihash ],
             [ sort(
                    q{file with spaces.txt},
                    'MANIFEST',
                    'dist.ini',
                    'Dist/Zilla/Plugin/ManifestInRoot.pm',
                    ) ],
             'manifest quotes files with spaces'
             );

   my @manilines = split /\n/, $tzil->slurp_file( 'source/MANIFEST' );

   chomp @manilines;

   is_deeply(
             [ sort @manilines ],
             [ sort(
                    qq{'file with spaces.txt'},
                    'MANIFEST',
                    'dist.ini',
                    'Dist/Zilla/Plugin/ManifestInRoot.pm',
                    ) ],
             'manifest quotes files with spaces'
             );
}

done_testing;

# Local Variables:
# mode: perl
# tab-width: 3
# End:
