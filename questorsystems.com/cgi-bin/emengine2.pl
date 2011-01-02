#!/usr/bin/perl

my $name = "Farley";
my $time = localtime;

open(SENDMAIL, "|/usr/lib/sendmail -oi -t -odq")
                    or die "Can't fork for sendmail: $!\n";
print SENDMAIL <<"EOF";
From: MyTVWorld.com WebAdmin <admin\@QuestorSystems.com>
To: The IPTV Customer <farley\@QuestorSystems.com>
Subject: IPTV: The Next hot thing?

Hello $name,


Today is a great day for IPTV and all that will happen with it in the future.


I know that a lot of people have already gone out and got everything together that they need to produce the next IPTV session servers, and cookie cutter machines. But in today's world this is just not enough. Who know's what could happen next, if we let Microsoft take the lead, it could be drastic, right?


Then I dashed for a train to Newcastle and since arriving here have filmed in what’s left, sad remnant, of the great shipyards on the Tyne and in the oldest church in England, St Paul’s in Jarrow, home of the great Bede and the site of the oldest piece of stained glass in Europe.  I’m beginning to film a series called ‘Written Britain’ and we’re starting with Bede and his great image of the sparrow going through the hall, going from darkness into light into darkness.  For Bede of course (sorry if this is too glib) the gravitational waves streamed down from heaven and his notion of cause was a deeply Christian, some would say superstitious, some would say deluded, view of the world.  However, the imagination required to believe in the gravitons and in gravitational waves and in much else that is happening in cutting edge physics can sometimes make Christianity seem quite a valid interpretation.


We hope to see you all at the TVWorld conference latter this year, in Olympia, London. I know that I am already looking forward to it.


We know you will be there too?

Regards,

Farley Balasuriya
Editor, IPTV Tribune
---
farley\@MyIPTVWorld.com
MyIPTVWorld.com - part of the Questor group
$time

EOF

close(SENDMAIL) or warn("sendmail did not close nicely");
