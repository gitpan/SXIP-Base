use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'SXIP::Base',
    license             => 'bsd',
    dist_author         => 'Sxip Identity <dev@sxip.org>',
    dist_version_from   => 'lib/SXIP/Digest.pm',
    build_requires => {
        'Test::More'            => 0,
        'Digest::SHA1'          => 0,
    },
    create_makefile_pl  => 'passthrough',
    add_to_cleanup      => [ 'SXIP-Base-*' ],
);

$builder->create_build_script();
