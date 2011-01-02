#!/usr/bin/perl
#!d:/SHRDATA/PROD/PROJECTS/BIN/Perl/bin/perl.exe


use CGI qw(:standard :html3);
use DBI;



my $t = localtime;
my $server = $ENV{'SERVER_NAME'};

my @name = `uname -a`;
my @if = `ifconfig`;

print header, start_html("env - $server"), h1("Time on $server"), "Localtime: $t";

# print the table ourselves, do not use CGI module

print h1("Server Environment");
print <<EOT
<PRE>
  Server Name:       $ENV{SERVER_NAME}
  Remote Address: $ENV{REMOTE_ADDR};
  Listening on Port: $ENV{SERVER_PORT}
  Server Software:  $ENV{SERVER_SOFTWARE}
  Server Protocol:   $ENV{SERVER_PROTOCOL}
  CGI Version:         $ENV{GATEWAY_INTERFACE}
  Uname:               @name
  Ifconfig:             @if
</PRE>
EOT
;

print h1("Perl Configuration");
my @ver = `perl -V`;
foreach my $line (@ver){
  print $line, p;
  }


print h2("DBI Drivers Installed");

my @driver_names = DBI->available_drivers;
foreach my $driver (@driver_names){
  print $driver, p;
  }


print h1('Environment variables');

print "<table align=center border=2>";
         print Tr, td( ["<b>Variable", "<b>Value"] );

my @vars;
foreach $key (sort (keys %ENV)) {
	  @vars = ($key, $ENV{$key});
          print Tr, td(\@vars);
     }
print "</table>";




print h1('System Processes');
my @buff =  `ps -ef`;

print "<table align=center border=2>";
foreach my $line (@buff) { 
 my @b2 =  split(/\s+/, $line);
 print Tr, td(\@b2);
 }
print "</table>";


print h1('Calender'), "<PRE>";
my @buff =  `cal 2007`;
print @buff;
print "</PRE>";
