#!/usr/bin/perl 

use LWP::UserAgent;
# use LWP::Protocol::socks;

system(($^O eq 'MSWin32') ? 'cls' : 'clear');

print " \n \t Subdomain Enum\n\n";

die "usage : perl $0 host.com subs.txt" unless $ARGV[1];


open(lst, $ARGV[1]) or die("Could not open file.");
@lst = <lst>;

print "\n    Target : $ARGV[0] ...\n";
 print "  \t [*] Load ".scalar(@lst)." Subs \n\n";

foreach $sub (@lst) { 

$ff = $sub.".".$ARGV[0];
$ff =~ s/\n//gi;

print "\n    Try $ff \n";
 $ua = LWP::UserAgent->new();
 #  $ua->proxy([qw/ http https /] => 'socks://127.0.0.1:9150');  # Tor Browsers SOcks
   $ua->agent("Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36");
   $res = $ua->get("http://".$ff)->code;

if($res =~ /200/) {

print "\n {+} $ff / 200 OK\n\n";

       open(SAVE , ">>subs_saved.txt");
       print SAVE $ff."\n";
       close(SAVE);
}

}
      
# close(lst);
