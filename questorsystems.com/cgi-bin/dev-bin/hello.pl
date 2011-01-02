#!/usr/bin/perl


use CGI qw(:standard :html3);


print header, "\n\n", start_html("hello.pl"), h1("hello.pl");
print "Hello world!", p;

print end_html;
