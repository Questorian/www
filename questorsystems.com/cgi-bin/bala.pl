#!D:\\perl\\bin\\perl
#this is a perl script

$time=localtime;
$ver=`ver`;
$pver=`perl -v`;
$ip=`ipconfig /all`;
$env=`set`;
$lusers=`net user`;
$dusers=`net user /domain`;
$ping=`ping www.cern.ch`;
$blat=`reg query "HKLM\\software\\Public Domain\\blat"`;


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
Windows NT Version
==================
$ver
Perl Version
============
$pver
IP Config Info
==============
$ip
Environment Variables
=====================
$env
Local user accounts
===================
$lusers
Domain user accounts
====================
$dusers
Ping to www.cern.ch
===================
$ping
BLat Config
===========
$blat

</code>
</PRE>
</BODY>
</HTML>

theEnd
