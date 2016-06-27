#!/usr/bin/env perl6

use Net::HTTP::POST;
use JSON::Fast;

#Make the class.
class WebService::Slack::webhook {
    #Make some vars.
    has Str $!url;

    #Make some methods to build the object.
    #Take in a string as the URL to use.
    multi method new(Str:D :$url!) {
        if ($url ~~ /https\:\/\/hooks\.slack\.com\/services\//) {
            self.bless(:url($url));
        }
        else { die "Bad Slack integration URL '$url'" }
    }
    #Take in the path of a file that has the URL.
    multi method new(IO::Path:D :$path!) {
        if ($path ~~ :f & :r) {
            self.bless(:url($path.lines[0]));
        }
        else { die "Cannot read from the file '$path'"}
    }
    #Fail.
    multi method new($other?) { die "No Slack integration URL given!"; }


    #Now for the sending methods.
    #Using a hash for the info.
    multi method send(*%info) {
        #Make sure the data is valid.
        unless all %info.values.map({$_ ~~ Str | Any}) {
            die "Bad data in key-value pairs.\nGot: {%info.pairs}";
        }

        #Setup the data to be sent.
        my %header = :Content-type("application/json");
        my $body = Buf.new(to-json(%info).ords);

        #Send the request.
        my $resp = Net::HTTP::POST($!url, :%header, :$body);
    }

    #using a string for the info.
    multi method send(Str $msg) {
        my %info = (text => $msg);
        callwith(%info);
    }
}
