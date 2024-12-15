use Net::HTTP::POST;
use JSON::Fast;

#Make the class.
class WebService::Slack::Webhook {
    #Make some vars.
    has Str $.url is required where {$_ ~~ regex {'https://hooks.slack.com/services/'} };
    has %.defaults;
    has Bool $.debug = False;

    #Using a hash for the info.
    multi method send(%info) {
        #Spit out some debugging stuff.
        if $.debug {
            note "Args passed: ", %info.gist;
            note "Defaults ", %!defaults.gist;
        }

        #Add the defaults.
        %info.append: %!defaults.pairs.grep(-> $p {!%info{$p.key}});

        #Setup the data to be sent.
        my %header = :Content-type("application/json");
        my $body = Buf.new(to-json(%info).ords);

        #Send the request.
        if $.debug { note "Data to send: ", %info.gist; return %info; }
        else { return Net::HTTP::POST($.url, :%header, :$body); }
    }

    #using a string for the info.
    multi method send(Str $msg) {
        note "Calling the Str method" if $.debug;
        self.send: %(:text($msg));
    }
}


=begin pod

=head1 NAME

WebService::Slack::Webhook - Support for Slack's WebService API

=head1 SYNOPSIS

=begin code :lang<raku>

use WebService::Slack::Webhook;

my $slack = WebService::Slack::Webhook.new(url => $url);

$slack.send("Beep, boop. *excited robot sounds*");

=end code

=head1 DESCRIPTION

The idea is to make this module as simple to use as possible. In an
effort to do this, info will be passed as a hash instead of named
arguments. This is because Slack's API for webhooks is not documented
terribly well, and they are always new additions to it. So, instead
of preventing you from sending a particular bit of data, just pass
a hash and it will be sent.

=head1 USAGE

=head2 .new

The C<.new> method will require an 'incoming webhook' integration
link from Slack, this way it knows where to connect and has the
correct authentication to do so.

One of these links will be given after setting up an integration
using L<this link|https://my.slack.com/services/new/incoming-webhook/>
"New Slack incoming webhook". If the url is not given an exception
will be thrown. The syntax for this method will look like this:

=begin code :lang<raku>

#String containing the URL.
my $slack = WebService::Slack::Webhook.new(url => $url);

=end code

Defaults are now available as well. This should make it easier to
use this module, because instead of having to pass a huge hash every
time, it can just be set as a default. Note that the defaults can
still be overridden just by setting the option to something else
when passing a hash. Setting defaults:

=begin code :lang<raku>

#Setting a default hash for the object.
my $slack = WebService::Slack::Webhook.new(
    url      => $url,
    defaults => %( username => "System Messenger" )
);

=end code

=head2 .send

This will be the method to send a message from. It will be overloaded
so that it can be used easier. The correct syntax for it will be:

=begin code :lang<raku>

#Using the '$slack' variable from the previous example...

#Using a hash.
my %info = (
  username   => "Jimmy the Robot",
  icon_emoji => ":robot_face:",
  text       => "Beep, boop. *excited robot sounds*"
);
$slack.send(%info);

#Or if you just want to send something...

#Just a string.
$slack.send("Beep, boop. *excited robot sounds*");

=end code

=head1 AUTHOR

Nic Quoziente

=head1 COPYRIGHT AND LICENSE

Copyright 2016 - 2017 Nic Quoziente

Copyright 2024 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
