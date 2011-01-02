#!/usr/bin/perl

use strict;
use DBI;
use CGI qw(:standard :html3);

#define connection variables
my $db_host     = "www.projectipanema.com";
my $db_database = "usr_web222_5";
my $db_userid   = "web222";
my $db_password = "uV+K^oKDK5gr";

# QUERIES - query isolation
my $query_01 = q{
SELECT  
  first_name, last_name, email 
FROM 
  subscribers
};

# DBI & database variables
my ( $dbh, $sth, $count );

print header, "\n\n", start_html("DBQuery"), h1("DBQuery");

print "starting call to DBI...", p;

$dbh = DBI->connect( "DBI:mysql:host=$db_host;database=$db_database",
    $db_userid, $db_password, { PrintError => 1, RaiseError => 1 } );

print "after call to DBI...", p;

$sth = $dbh->prepare($query_01);

print "just after the SELECT statement...", p;

$sth->execute;
$count = 0;

# print the output
print "<table align=center border=2>";
while ( my @val = $sth->fetchrow_array() ) {

    #lets make the email address one we can actually email:
    $val[2] = "<a href=\"mailto:$val[2]\">$val[2]</a>";
    print Tr, td( \@val );
    $count++;
}
print "</table>";
print "$count rows total returned";
$sth->finish();
$dbh->disconnect();
exit(0);
