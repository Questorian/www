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


# QUERIES - query isolation
my $query_02 = q{
SELECT  
 t, content, status
FROM 
  todo
};


# query 3 - insert another todo item
my $query_03 = q{

insert into todo set t = NOW(), status = 'open', content = 'remote - whatever' 

};

my $query_04 = q{
INSERT INTO
  todo (t, status, content)
VALUES
 (NOW(), 'open', 'remote - whatever')
};



# DBI & database variables
my ( $dbh, $sth, $count );

my $name = "DBQuery2";

print header, "\n\n", start_html($name), h1($name);

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


print h1("Todo");
$sth = $dbh->prepare($query_02);

$sth->execute;
$count = 0;

# print the output
print "<table align=center border=2>";
while ( my @val = $sth->fetchrow_array() ) {

    #lets make the email address one we can actually email:
    print Tr, td( \@val );
    $count++;
}
print "</table>";
print "$count rows total returned";


print h1("Insert into Todo table - Jah");
print "Trying to insert into the Todo table...";
$count = $dbh->do($query_04);
print "Return value: $count\n";


$sth->finish();
$dbh->disconnect();
exit(0);
