# @(#)$Ident: Build.PL 2013-08-15 10:10 pjf ;

use strict;
use warnings;

use File::Spec::Functions qw( splitdir splitpath );
use Module::Build;

sub whimper { print {*STDOUT} $_[ 0 ]."\n"; exit 0 }

my $perl_ver = ##{ $meta2{prereqs}->{runtime}->{requires}->{perl} ##};
my $module   = '##{ $zilla->main_module->name ##}';

$] >= $perl_ver or $ENV{PERL5_CPANPLUS_IS_VERSION}
   or whimper "Minimum required Perl version is ${perl_ver}";

Module::Build->subclass( code => do { local $/; <DATA> } )->new(
  'module_name' => __module_name2package_name( $module ),
  'notes'       => { min_perl_version => $perl_ver },
##{ $plugin->get_prereqs( 1 ) ##}
##{ $plugin->get_default('share_dir') ##}
)->create_build_script;

exit 0;

sub __module_name2package_name {
   my $module = shift; $module =~ s{ \.pm \z }{}mx;
   my (undef, $dir, $file) = splitpath( $module );
   my @dirs   = splitdir( $dir ); shift @dirs; length $dirs[ -1 ] or pop @dirs;

   return join '::', @dirs, $file;
}

__DATA__

sub _normalize_prereqs { # Dynamic config
   my $self = shift; my $p = $self->SUPER::_normalize_prereqs; return $p;
}
