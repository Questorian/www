#!/usr/bin/perl

use Mail::Mailer;

my $from_address = "webadmin\@questor.ch";
my $to_address = "tech3\@questor.ch";
my $subject = "IPTVNow: How good it feels";
my $body = "Hello Farley\n\nToday we talk again about IPTV.";


$mailer = Mail::Mailer->new("sendmail");
$mailer->open({ From    => $from_address,
                To      => $to_address,
                Subject => $subject,
              })
    or die "Can't open: $!\n";
print $mailer $body;
$mailer->close();
