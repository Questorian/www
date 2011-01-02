#!/usr/bin/perl

#!d:/SHRDATA/PROD/PROJECTS/BIN/Perl/bin/perl.exe


# version fo where the Perl CGI module is not present on server
#  instead just print plain text to web browser


my $t = localtime;



print "Content-type: text/html\r\n\r\n";
print "Hello, World. Current time: $t";


print "<table align=center border=2>";

my @vars;
foreach $key (keys %ENV) {
	  @vars = ($key, $ENV{$key});
          print Tr, td(\@vars);
     }
print "</table>";