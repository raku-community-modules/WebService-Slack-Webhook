#!/usr/bin/env perl6

use Test;
use lib 'lib';

use WebService::Slack::webhook;

#Make some vars
my $fake-url = "https://hooks.slack.com/services/example.html";

#Make a bad object.
dies-ok {WebService::Slack::webhook.new()},
    'Bad object fails correctly';

#Make a good object with a url.
isa-ok WebService::Slack::webhook.new(url => "$fake-url"),
    'WebService::Slack::webhook',
    'Good object can be made with url';

done-testing;
