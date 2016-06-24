#!/usr/bin/env perl6

use Test;
use lib 'lib';

use WebService::Slack::webhook;

#Make a bad object.
dies-ok {WebService::Slack::webhook.new()},
    'Bad object fails correctly';

#Make a good object.
my $slack = WebService::Slack::webhook.new("https://host.slack.com/example");
isa-ok $slack,
    'WebService::Slack::webhook',
    'Good object can be made';

done-testing;
