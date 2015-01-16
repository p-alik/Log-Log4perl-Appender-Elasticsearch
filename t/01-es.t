use warnings;
use strict;

use Test::More;

use_ok 'Log::Log4perl';
use_ok 'Log::Log4perl::Appender::Elasticsearch';
can_ok 'Log::Log4perl::Appender::Elasticsearch', qw/
    log
    _headers
    _prepare_body
    _request
    _send_request
    _uri
    _to_json
    /;

my %args = (
    nodes      => 'localhost:9200',
    'index'    => 'log4perl',
    type       => 'entry',
    use_https  => 0,
    user_agent => { timeout => 5 },
    headers    => { 'User-Agent' => ['foo'] },
    body       => { module => '%M', level => '%p', line => '%L' }
);

my $app = new_ok 'Log::Log4perl::Appender::Elasticsearch', [%args];

isa_ok($app, 'Log::Log4perl::Appender');
ok(my $uri = $app->_uri($app->{_nodes}[0], join('-', 'foo', int(rand(100)))),
    '_uri');
ok(my $h = $app->_headers($uri), '_headers');

subtest 'log', sub {
    $ENV{LOG2NODE} || plan skip_all => 'log without $ENV{LOG2NODE}';

    ok(Log::Log4perl->init(\<<"EOCFG"), 'Log::Log4perl->init');

log4perl.logger=DEBUG, ES

log4perl.appender.ES = Log::Log4perl::Appender::Elasticsearch
log4perl.appender.ES.layout = Log::Log4perl::Layout::NoopLayout

log4perl.appender.ES.body.level = %p
log4perl.appender.ES.body.module = %M
log4perl.appender.ES.body.line = %L

log4perl.appender.ES.nodes = $ENV{LOG2NODE}
log4perl.appender.ES.index = log4perl
log4perl.appender.ES.type = entry

log4perl.appender.ES.use_https = 0
log4perl.appender.ES.ua.timeout = 5

log4perl.appender.ES.headers.User-Agent = foo
EOCFG

    ok(my $l = Log::Log4perl::get_logger(), 'Log::Log4perl::get_logger()');
    foreach (qw/error info debug/) {
        ok $l->$_("OK"), "$_('$_ Message')";
    }
};

done_testing();

