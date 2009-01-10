#!/usr/bin/env perl
use strict;
use warnings;
=pod
ToDo:
1.add options offset, length, maxgenes from command line
2.if execution is aborted , save each roops 
=cut
use SOAP::Lite;

my $wsdl = 'http://soap.genome.jp/KEGG.wsdl';

my $serv = SOAP::Lite -> service($wsdl);

my $filename = 'organisms.txt';

# file check
if (-e $filename) {
	print "\tfind $filename\n";
} else {
	print "\tfile doesn't exist!\n";
	print "\tfetching $filename ...\n";
	system("curl -l -s ftp://ftp.genome.jp/pub/kegg/genes/organisms/ | sort > organisms.txt");
	print "\tfetch OK\n";
}

# file open
open(FILE, $filename) or die;
chomp(my @orgs = <FILE>);
close FILE;

my $orgnum = scalar(@orgs);
# $orgnum = 2;
print "Number of organisms : ".$orgnum."\n";
# if print @orgs, then all lines are listed.
# create newfile
open(NEWFILE, ">genes.txt");
# note: @orgs[$orgnum-1] is the last organism
for(my $i = 0; $i < $orgnum; $i++) {
	my $maxgenes = $serv->get_number_of_genes_by_organism("$orgs[$i]");
	printf "%03d/%d\t",$i+1,$orgnum;
	print "Number of $orgs[$i]'s genes : $maxgenes\n";

	my $list = $serv->get_genes_by_organism("$orgs[$i]", 1, 2);
	
	foreach my $hit (@{$list}) {
		my @array = split(/:/,$hit);
		print NEWFILE 'http://www.genome.jp/dbget-bin/www_bget?'.join('+', @array)."\n";
	}
}
close(NEWFILE); 
