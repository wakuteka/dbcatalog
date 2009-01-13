#!/usr/bin/env perl
use warnings;
use strict;
my $filename = "RASV_list_all.txt";
my @array;

if (-e $filename) {
	print "\tfind $filename\n";
} else {
	print "\tfile doesn't exist!\n";
	print "\tfetching $filename ...\n";
	system("wget http://jbirc.jbic.or.jp/h-dbas/download/$filename");
	print "\tfetch OK\n";
}

open(OUT, "$filename");
while(<OUT>) {
push(@array,substr($_,0,10)."\n");
}
close(OUT);

# delete same lines.
my %count;
@array = grep(!$count{$_}++, @array);

print @array;
print "print newfile...\n";

open(NEWFILE, ">new_rasv.txt");
foreach my $list (@array){
print NEWFILE "seed: 1.0|http://jbirc.jbic.or.jp/h-dbas/locusOverview.do?db=all&hix=".$list;
}
close(NEWFILE);

print "\tcompleted!\n";
# Ex. http://jbirc.jbic.or.jp/h-dbas/locusOverview.do?db=all&hix=HIX0093752
