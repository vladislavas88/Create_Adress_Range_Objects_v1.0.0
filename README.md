 
Using the script for create address range objects for Check Point dbedit
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
