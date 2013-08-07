# @(#)$Ident: Build.PL 2013-08-07 10:43 pjf ;

use strict;
use warnings;
use inc::Bob; # Module::Build subclass
use version; our $VERSION = qv( sprintf '0.1.%d', q$Rev: 2 $ =~ /\d+/gmx );

Bob->new( {
   module    => 'Dist::Zilla::Plugin::ManifestInRoot',
   home_page => 'http://www.roxsoft.co.uk',
   requires  => {
      'version'        => 0.88,
      'namespace::autoclean' => 0.13,
      'Dist::Zilla'    => 4.300033,
      'File::Slurp'    => 9999.13,
      'Moose'          => 2.0802,
      'Moose::Autobox' => 0.12,   },
   recommends          => {
      'App::cpanminus' => 1.6005, },
   configure_requires  => {
      'version'        => 0.88,
      'Module::Build'  => 0.4004, },
   build_requires      => {
      'version'        => 0.88,
      'Dist::Zilla'    => 4.300033,
      'Module::Build'  => 0.4004, },
} )->create_build_script; # Goal!

# Local Variables:
# mode: perl
# eval: (load-project-state "dist-zilla-plugin-manifestinroot")
# tab-title: ManifestInRoot
# tab-width: 3
# End:
