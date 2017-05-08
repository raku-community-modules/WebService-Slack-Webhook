#!/usr/bin/env perl6

use Net::HTTP::POST;
use JSON::Fast;

#Make the class.
class WebService::Slack::Webhook {
    #Make some vars.
    has Str $.url is required where {$_ ~~ regex {'https://hooks.slack.com/services/'} };

    #Using a hash for the info.
    multi method send(%info) {
        say "Entering hash method.";
        #Make sure the data is valid.
        unless all %info.values.map({$_ ~~ Str|Any}) {
            die "Bad data in key-value pairs.\nGot: {%info.pairs}";
        }

        #Setup the data to be sent.
        my %header = :Content-type("application/json");
        my $body = Buf.new(to-json(%info).ords);

        #Send the request.
        say $.url.perl ~ "\n" ~ %header.perl ~ "\n" ~ %info.perl;
        my $resp = Net::HTTP::POST($.url, :%header, :$body);
    }

    #using a string for the info.
    multi method send(Str $msg) {
        say "Entering string method.";
        my %info = (:text($msg));
        self.send(%info);
    }
}
