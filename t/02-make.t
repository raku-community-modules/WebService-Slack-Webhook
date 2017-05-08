#!/usr/bin/env perl6

use Test;
use lib 'lib';

use WebService::Slack::Webhook;

#Make some vars
my $fake-url = "https://hooks.slack.com/services/example.html";

#Make a bad object.
dies-ok {WebService::Slack::Webhook.new()},
    'Bad object fails correctly';

#Make a good object with a url.
isa-ok WebService::Slack::Webhook.new(url => "$fake-url"),
    'WebService::Slack::Webhook',
    'Good object can be made with url';

done-testing;
