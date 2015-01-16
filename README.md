Log::Log4perl::Appender::Elasticsearch - Log to Elasticsearch

This package contains two modules, that provide ability to write log entries to Elasticsearch.

  * Log::Log4perl::Appender::Elasticsearch sends log entries via <a href="http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/docs-index_.html">Indes API</a>.

  * Log::Log4perl::Appender::Elasticsearch::Bulk does the same task by using <a href="http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/docs-bulk.html">Bulk API</a>.


```perl
use Log::Log4perl;

Log::Log4perl->init(\<<'HERE');
log4perl.logger=DEBUG, ES

log4perl.appender.ES = Log::Log4perl::Appender::Elasticsearch
log4perl.appender.ES.layout = Log::Log4perl::Layout::NoopLayout

log4perl.appender.ES.body.level = %p
log4perl.appender.ES.body.module = %M
log4perl.appender.ES.body.line = %L

log4perl.appender.ES.nodes = localhost:9200
log4perl.appender.ES.index = log4perl
log4perl.appender.ES.type = entry

log4perl.appender.ES.use_https = 0
log4perl.appender.ES.user_agent.timeout = 5

log4perl.appender.ES.headers.User-Agent = foo
HERE

Log::Log4perl::get_logger()->info("OK");
```
