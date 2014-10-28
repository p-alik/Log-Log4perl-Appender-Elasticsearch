Log::Log4perl::Appender::Elasticsearch - Log to Elasticsearch

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
