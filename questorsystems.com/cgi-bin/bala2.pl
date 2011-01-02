#!/usr/bin/perl

$time=localtime;

my $var = `ps -ef`;


print <<theEnd;
content-type: text/html

<HTML>
<HEAD>
<TITLE>Questor Systems Server configuration</TITLE>
</HEAD>

<BODY>
<H1>Questor Systems Server configuration, $time</H1>
<PRE>
<code>
hello world. Current time is $time
<p> $var

</code>
</PRE>
</BODY>
</HTML>

theEnd
