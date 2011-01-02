#!/usr/bin/perl

use strict;
use DBI;
use CGI qw(:standard :html3);

my $domain  = param('domain') || '<i>(No input)</i>';
my $extra_emails = param('extra_emails');

my $name="Site Checklist - Email Accounts";
my @emails;

my @id_list = qw(
Tele
Fax
TeleFax
Webmaster
Abuse
Admin
Postmaster
WhoIs
Test

Info
Help
Contracts
Support
Bills
Orders
Sales
Jobs

Sub0:9
AutoR0:9
BCast0:9

Farley
Geoff
Mike

);


# push other on from the form - if they entered any
foreach my $split (split(/\s+/,$extra_emails)) {
    push(@id_list, $split);
	}



foreach my $id (@id_list) {
  if ($id =~ m/([a-zA-Z0-9_-]+):(\d+)/) {
    my $basename = $1;
    my $max = $2;
    # print "note: $id has a colon in it! - we got a basename of $basename, and a max number of $max\n";
    for (my $i = 1; $i <= $max ;$i++) {
      push (@emails, $basename . $i . '@' . $domain);
    	}
  	}
    else {
      push (@emails, $id . '@' . $domain);
	}
}


# CGI - output section
print header, "\n\n", start_html($domain . ": $name"), h1($domain . ": $name");

my $now = localtime;

print "Created:", $now, "<br /><br />\n";

# now let's print them all out
foreach my $item (sort @emails) {
  print "$item <br />\n";
	}

print "Extra emails: $extra_emails\n";

# end the doc
print end_html;
