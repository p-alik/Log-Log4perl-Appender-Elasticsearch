#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Log::Log4perl::Appender::Elasticsearch' ) || print "Bail out!\n";
}

diag( "Testing Log::Log4perl::Appender::Elasticsearch $Log::Log4perl::Appender::Elasticsearch::VERSION, Perl $], $^X" );
