#!/usr/bin/env perl

=pod

=head1 Using the script for create address range objects for Check Point dbedit
#===============================================================================
#
#       FILE: create_address_range.pl
#
#       USAGE: $ touch ./in_range.txt
#		 10.1.1.129 10.1.1.142
#		 10.2.2.1 10.2.2.100
#		 10.3.3.17 10.3.3.21
#		 etc
#
#		$ ./create_address_range.pl in_ranges.txt
#
#		$ cat ./range_objects.txt
#		  create address_range IP_range_10.1.1.129-10.1.1.142
#		  modify network_objects IP_range_10.1.1.129-10.1.1.142 ipaddr_first 10.1.1.129
#		  modify network_objects IP_range_10.1.1.129-10.1.1.142 ipaddr_last 10.1.1.142
#		  modify network_objects IP_range_10.1.1.129-10.1.1.142 color 'forest green'
#		  create address_range IP_range_10.2.2.1-10.2.2.100
#		  modify network_objects IP_range_10.2.2.1-10.2.2.100 ipaddr_first 10.2.2.1
#		  modify network_objects IP_range_10.2.2.1-10.2.2.100 ipaddr_last 10.2.2.100
#		  modify network_objects IP_range_10.2.2.1-10.2.2.100 color 'forest green'
#		  create address_range IP_range_10.3.3.17-10.3.3.21
#		  modify network_objects IP_range_10.3.3.17-10.3.3.21 ipaddr_first 10.3.3.17
#		  modify network_objects IP_range_10.3.3.17-10.3.3.21 ipaddr_last 10.3.3.21
#		  modify network_objects IP_range_10.3.3.17-10.3.3.21 color 'forest green'
#		
#  DESCRIPTION: Create network objects for Check Point dbedit
#
#      OPTIONS: ---
# REQUIREMENTS: Perl v5.14+ 
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Vladislav Sapunov 
# ORGANIZATION:
#      VERSION: 1.0.0
#      CREATED: 30.01.2024 22:48:36
#     REVISION: ---
#===============================================================================
=cut

use strict;
use warnings;
use v5.14;
use utf8;

# Result outFile for dbedit
my $outFile = 'range_objects.txt';

my $createAddressRange        = "create address_range ";
my $modifyNetworkObjects = "modify network_objects ";
my $ipaddrFirstCmd = "ipaddr_first ";
my $ipaddrLastCmd = "ipaddr_last ";
my $rangePrefix            = "IP_range_";
my $color                = "color \'forest green\'";

# Open result outFile for writing
open( FHW, '>', $outFile ) or die "Couldn't Open file $outFile" . "$!\n";

while ( defined( my $line = <> ) ) {
    chomp($line);
    $line =~ /^((\d+)\.(\d+)\.(\d+)\.(\d+))\s((\d+).(\d+).(\d+).(\d+))$/;
    my $ipaddrFirst = $1;
    my $ipaddrLast = $6;
    say FHW "$createAddressRange" . "$rangePrefix" . "$ipaddrFirst" . "-" . "$ipaddrLast";
    say FHW "$modifyNetworkObjects" . "$rangePrefix" . "$ipaddrFirst" . "-" . "$ipaddrLast" . " " . "$ipaddrFirstCmd" . "$ipaddrFirst";
    say FHW "$modifyNetworkObjects" . "$rangePrefix" . "$ipaddrFirst" . "-" . "$ipaddrLast" . " " . "$ipaddrLastCmd" . "$ipaddrLast";
    say FHW "$modifyNetworkObjects" . "$rangePrefix" . "$ipaddrFirst" . "-" . "$ipaddrLast" . " " . "$color";
}

# Close the filehandles
close(FHW) or die "$!\n";

say "**********************************************************************************\n";
say "Network objects TXT file: $outFile created successfully!";

my $cpUsage = <<__USAGE__;

***************************************************************************************
* # Create the actual object (of type address_range)
* create address_range addr-range
*
* # Modify the first IP address in the range
* modify network_objects addr-range ipaddr_first 10.1.1.129
*
* # Modify the last IP address in the range
* modify network_objects addr-range ipaddr_last 10.1.1.142
*
* # Add a comment to describe what the object is for (optional)
* modify network_objects addr-range comments "Created by fwadmin with dbedit"
*
* # modify network_objects Net_range_10.1.1.129-10.1.1.142 color 'forest green'
* # Color [aquamarine 1, black, blue, blue 1, burly wood 4, cyan, dark green, dark khaki,
* dark orchid, dark orange 3, dark sea green 3, deep pink, deep sky blue 1, dodger blue 3,
* firebrick, foreground, forest green, gold, gold 3, gray 83, * gray 90, green, lemon chiffon,
* light coral, light sea green, light sky blue 4, magenta, medium orchid, medium slate blue,
* medium violet red, navy blue, olive drab, orange, red, sienna, yellow, none]	
* update_all
*
* savedb
*
***************************************************************************************

__USAGE__

say $cpUsage;

