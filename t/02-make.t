#!/usr/bin/env perl6

use Test;
use lib 'lib';

use WebService::Slack::webhook;

#Make some vars
my $fake-url = "https://host.slack.com/example";
my $file-name = ".slackurl";

#Make a bad object.
dies-ok {WebService::Slack::webhook.new()},
    'Bad object fails correctly';

#Make a good object with a url.
isa-ok WebService::Slack::webhook.new(url => "$fake-url"),
    'WebService::Slack::webhook',
    'Good object can be made with url';

#Make a good object with a path.
"$file-name".IO.spurt($fake-url); #Make the file.
isa-ok WebService::Slack::webhook.new(path => "$file-name"),
    'WebService::Slack::webhook',
    'Good object can be made with path';
"$file-name".IO.unlink; #Remove the file.


done-testing;
