#!d:\perl\bin\perl
#use the mail server at mail.netlimited.net, sender webmaster@questor.ch


use CGI qw(:standard);

open (MAIL, ">mail.txt");
open (ACC, ">acc.txt");
open (LOG, ">>../logs/MessageClients.txt");

$time=localtime;
#read in our CGI paramters
read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});

@pairs=split(/&/, $buffer);
foreach $pair (@pairs){
  # Split the pair up into individual variables
  local($name, $value) = split(/=/, $pair);
  $name =~ tr/+/ /;
  $name =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
  $value =~ tr/+/ /;
  $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
  $params{$name}=$value;
  }

#start to create the email
print MAIL "From:$params{\"FromName\"}\nReply email:$params{\"FromEmail\"}\nserver time when sent: $time\n";
print MAIL "\nmessage:\n$params{\"message\"}\n\nbuffer:$buffer\n";
print MAIL "http://www.questor.ch\nmailto:webmaster\@questor.ch\n";
#and keep a note of who called
print LOG "$params{\"FromEmail\"}:$params{\"FromName\"}:$time\n";

#pass the command throught to the OS
#send an acknowledgement to the sender...
print ACC <<endOfAcc;
Hello $params{"FromName"},

Thank-you for your enquiry.

Please be assured that one of the team is looking at this
right now, and will get back to you just as soon as they have
some information for you, at the email address that you have 
furnished us with, $params{"FromEmail"}.

Kind regards,


The team at Questor
--
Questor Systems GmbH
http://www.questor.ch/contact.html mailto:info\@questor.ch
endOfAcc


# old one.  don't use!!! $blat0=`blat -install mail.netlimited.net webmaster\@questor.ch`;
# $blat0=`blat -install smtp01.netservers.net webmaster\@questor.ch`;
close(MAIL);
$blat=`blat mail.txt -t admin\@questor.ch  -s "QS-$params{"FromName"}" -i webmaster\@questor.ch`;
close(ACC);
$blat2=`blat acc.txt -t $params{"FromEmail"}  -s \"We received your email..." -i webmaster\@questor.ch`;
close(LOG);

print <<theEnd;
content-type: text/html

<HTML>
<HEAD>
<TITLE>Message send - $time</TITLE>
</HEAD>

<BODY>
<font face=arial color="black" SIZE=2>
<B>Message sent</B><P>
On $time (localtime), your message to <I>Questor Systems</I> has been successfully dispatched.<p>
Thank-you!<p>
<pre>
$blat
$blat2
</pre>
<a href="http://www.questor.ch/default.htm">Back to Questor Systems home page</a>
</BODY>
</HTML>

theEnd

