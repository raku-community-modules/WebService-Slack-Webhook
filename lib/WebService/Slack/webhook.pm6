#!/usr/bin/env perl6

use Net::HTTP::POST;
use JSON::Fast;

#Make the class.
class WebService::Slack::webhook {
    #Make some vars.
    has Str $!url;

    #Make some methods to build the object.
    multi method new(Str:D $var) { self.bless(:url($var)); }
    multi method new($other?) { die "No Slack integration given!"; }
}
