#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'SXIP::Digest' );
}

diag( "Testing SXIP::Digest $SXIP::Digest::VERSION, Perl $], $^X" );
