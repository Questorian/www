#!/usr/bin/perl

use strict;

use CGI;

my $cgiobject = new CGI;

my $fname=$cgiobject->param("fname");
my $email_add=$cgiobject->param("email_add");
my $email_msg=$cgiobject->param("email_msg");
my $tel_no=$cgiobject->param("tel_no");
my $datetime = localtime;
my $var;


print "Content-type: text/html\n\n";

# check the form was completed properly - if not go back
if (! $fname ) {
    $var = "Name";
	}
if (! $email_add ) {
    $var = "Your email address";
	}

# check validity of email address
if ( ! ($email_add =~ m/^[A-z0-9_\-]+[@][A-z0-9_\-]+([.][A-z0-9_\-]+)+[A-z]{2,4}$/) ) {
    $var = "A valid email address";
	}
if (! $email_msg ) {
    $var = "Message body";
	}

if ($var) {
  PrintErr($var);
	}
 
open (MAIL, "|/usr/lib/sendmail info\@QuestorSystems.com") || &errormess;
 print MAIL "From: $email_add\n";
 print MAIL "Reply-to: $email_add\n";
 print MAIL "Cc: $email_add\n";
 print MAIL "Subject: www.QuestorSystems.com - Contact Request\n";

 print MAIL "Name  $fname\n";
 print MAIL "Email $email_add\n";
 print MAIL "Tel   $tel_no\n";
 print MAIL "Time  $datetime\n\n";
 print MAIL "Msg   $email_msg\n";
close(MAIL);

 

print <<"html";
<HTML>
<HEAD>
<TITLE>Questor IPTV :: Points of Contact :: Team-Questor :: Contact Us </TITLE>
</HEAD>
<BODY >
<H4>Thank you $fname - your message has been sent. You will be contacted within the next 72 hours.
<center>
<a href="http://www.QuestorSystems.com/contact.html">return to contact page</a>
</center>
</BODY>
</HTML>
html

exit;

 sub errormess {
   print "<BR>Problem sending mail Aborting\n";
  exit;  
}


sub PrintErr()
{
my ($var)=@_;


print <<"html";
<HTML>
<HEAD>
<TITLE>Questor IPTV :: Points of Contact :: Team-Questor :: Contact Us </TITLE>
</HEAD>
<BODY TEXT="RED">
<H4>Sorry! $var field needs to be specified. Please hit the <- [BACK] browser-button and try again....
</BODY>
</HTML>
html

exit;

}
