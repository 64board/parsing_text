#!/usr/bin/perl

use strict;
use warnings;

sub get_long_short {
   my ($number, $spaces1, $spaces2) = @_;
   my ($long, $short) = ('', '');

   if (length($spaces1) > length($spaces2))
   {
      $short = $number;
   } else {
      $long = $number;
   }

   return ($long, $short);
}

while (<DATA>) {

   chomp();

   if (my ($b1, $n1, $n2, $b2, $s) = /
      ^(\s*)            # First spaces ($b1)
      ([\d,.]+)         # First number always exists ($n1)
      (?:               # Don't want to capture spaces
      \s+               # in front
      ([\d,.]+)         # Second number ($n2)
      )?                # Second number is optional
      (\s+)             # Space always exists ($b2)
      (\w{2,3})$        # Two or three letters symbol ($s)
      /x)
   {
      my ($long, $short);

      if (defined($n2)) {
         $long = $n1;
         $short = $n2;
      } else {
         ($long, $short) = get_long_short($n1, $b1, $b2);
      }

      $long =~ s/,//g;
      $short =~ s/,//g;

      print("$long|$short|$s\n");

   } else {
      print("NOT MATCHED: $_\n");
   }
}

__END__
long short symbol
12 3  NG
1,234 1,222 CL
1,333       PL
123.4 9,088     HNG
123.4 9,088     BBBB
       90.65 HO
   1   RB
    2  RB
     3 RB
4      RB
  100,000.00     CL
  CL
