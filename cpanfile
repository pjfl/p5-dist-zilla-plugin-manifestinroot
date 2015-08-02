requires "Dist::Zilla" => "4.300033";
requires "Moose" => "2.0802";
requires "namespace::autoclean" => "0.22";
requires "perl" => "5.008";
requires "version" => "0.88";

on 'build' => sub {
  requires "Dist::Zilla" => "4.300033";
  requires "Module::Build" => "0.4004";
  requires "Test::Requires" => "0.06";
  requires "version" => "0.88";
};

on 'test' => sub {
  requires "File::Spec" => "0";
  requires "Module::Metadata" => "0";
  requires "Sys::Hostname" => "0";
};

on 'test' => sub {
  recommends "CPAN::Meta" => "2.120900";
};

on 'configure' => sub {
  requires "Module::Build" => "0.4004";
  requires "version" => "0.88";
};
