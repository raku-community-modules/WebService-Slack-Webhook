#!/usr/bin/env perl6

use Net::HTTP::POST;
use JSON::Fast;

#Make the class.
class WebService::Slack::Webhook {
    #Make some vars.
    has Str $.url is required where {$_ ~~ regex {'https://hooks.slack.com/services/'} };
    has %.defaults;

    #Using a hash for the info.
    multi method send(%info) {
        #Add the defaults.
        %info.append: %!defaults.pairs.grep(-> $p {!%info{$p.keys}});

        #Setup the data to be sent.
        my %header = :Content-type("application/json");
        my $body = Buf.new(to-json(%info).ords);

        #Send the request.
        my $resp = Net::HTTP::POST($.url, :%header, :$body);
    }

    #using a string for the info.
    multi method send(Str $msg) {
        self.send: %(:text($msg));
    }
}
