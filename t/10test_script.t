# @(#)Ident: 10test_script.t 2013-08-07 10:54 pjf ;

use strict;
use warnings;
use version; our $VERSION = qv( sprintf '0.1.%d', q$Rev: 2 $ =~ /\d+/gmx );
use File::Spec::Functions   qw( catdir updir );
use FindBin                 qw( $Bin );
use lib                 catdir( $Bin, updir, q(lib) );

use Module::Build;
use Test::More;

my $reason;

BEGIN {
   my $builder = eval { Module::Build->current };

   $builder and $reason = $builder->notes->{stop_tests};
   $reason  and $reason =~ m{ \A TESTS: }mx and plan skip_all => $reason;
}

use ExtUtils::Manifest;
use Test::DZil;

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

my $manihash = ExtUtils::Manifest::maniread( $tzil->root->file( 'MANIFEST' ) );

is_deeply(
          [ sort keys %$manihash ],
          [ sort(
                 q{file with spaces.txt},
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
                 'dist.ini',
                 'Dist/Zilla/Plugin/ManifestInRoot.pm',
                 ) ],
          'manifest quotes files with spaces'
          );

done_testing;

# Local Variables:
# mode: perl
# tab-width: 3
# End:
