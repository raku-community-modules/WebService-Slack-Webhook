#!/usr/bin/env perl6

use Test;
use lib 'lib';

use WebService::Slack::Webhook;

#Make some vars
my $fake-url = "https://hooks.slack.com/services/example/integration/url";

my $slack = WebService::Slack::Webhook.new(url => $fake-url);
my %info = (
    text => "This is a test with a hash",
    username => "test-bot"
);

ok $slack.send("This is a test with a string"), 'Send works with string arg';
ok $slack.send(%info), 'Send works with hash arg';

done-testing;
