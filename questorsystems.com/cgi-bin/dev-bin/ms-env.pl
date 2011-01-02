#!/usr/bin/perl

use lib '.';

use CGI;
use File::Find;
use strict;

# $VERSION = sprintf "%d.%02d", '$Revision: 2.0 $ ' =~ /(\d+)\.(\d+)/;

print header, "\n";
print start_html(-dtd=>'-//W3C//DTD HTML 4.0 Transitional//EN',
		 -title=>"Perl Environment: $ENV{SERVER_NAME}"), "\n";

print h1("Perl Environment: $ENV{SERVER_NAME}"), "\n";

print p("Perl Version: $]"), "\n";

print p("CGI.pm Version: $CGI::VERSION"), "\n";

print p("Library Path (\@INC):"), "\n";

print ul(li([@INC])), "\n";

print p('Modules:'), "\n";

my @mods;
my $list;
my $dir;
foreach $_ (@INC) {
  @mods = ();
  $dir = $_;
  find(\&wanted, $_);

  $list .= ul(li("$dir"),
	      ul(li([sort @mods])));
}

print $list, "\n";

sub wanted {
  return unless /\.pm$/;

  push @mods, $File::Find::name;
}


