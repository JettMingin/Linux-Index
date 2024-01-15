#!/usr/bin/perl

use v5.28;
use strict;

#using bash alias "alias index='/[YOUR FILE PATH]/linux_index.pl'"

my $indexDOC = '/[YOUR FILE PATH]/indexDOC.txt'; #Declare your file path to the indexDOC here

sub read_index{
	open INDEX, "$_[0]";
	chomp (my @indexDOC = <INDEX>);
	close (INDEX);
	
	my %index = @indexDOC;
	my @terms = sort (keys %index);

	printf "%42s", "*** THE INDEX ***\n";
	say "*reading from $_[0]*\n";
	my $linecount = 1;
		
	foreach my $i (0..$#terms){
		chomp $terms[$i];
		print "$linecount" . ". $terms[$i] - $index{$terms[$i]}\n\n";
		$linecount ++;
	}
}
	
sub search_index{
	open INDEX, "$_[0]";
	chomp (my @indexDOC = <INDEX>);
	close (INDEX);
	
	my %index = @indexDOC;
	my @terms = sort (keys %index);
	my $termchecker = -1;
		
	printf "%24s", "***INDEX SEARCH***\n";
	print "Enter your desired search term: ";
	chomp (my $searchterm = <STDIN>);
	print "\n";
		
	foreach my $i (0..$#terms){
		chomp $terms[$i];
		if ($terms[$i] =~ /\A$searchterm/i){
			print "$terms[$i] - $index{$terms[$i]}\n\n";
		}else{
			$termchecker ++;
			}
	}
	if ($termchecker == $#terms){
		say "Sorry, I couldnt find that term in the index.";
	}
}
	
sub update_index{
	open INDEX, ">> $_[0]";
	print "Enter your term\n";
	my $a = <STDIN>;
	print INDEX $a;
	print "Enter your description\n";
	my $b = <STDIN>;
	print INDEX $b;
	close INDEX;
	chomp $a;
	print "$a Sucessfully added to the doc\n";
}
	
sub delete_index{
	open INDEX, "$_[0]";
	chomp (my @indexDOC = <INDEX>);
	close INDEX;
		
	my %index = @indexDOC;
	my @terms = sort (keys %index);
	my $termchecker = -1;
		
	say "***TERM DELETER***";
	print "Enter the exact term you wish to delete: ";
	
	chomp (my $deleteterm = <STDIN>);
	print "\n";
		
	foreach my $i (0..$#terms){
		chomp $terms[$i];
		if ($terms[$i] =~ /\A($deleteterm)\Z/){
			print "$terms[$i] - $index{$terms[$i]}\n\n";
			my $TERM = $terms[$i];
			my $DESCRIPTION = $index{$terms[$i]};
				
			print "Are you sure you wish to delete this term? (y/n): ";
			my $delete_check = <STDIN>;
			if ($delete_check =~ /\Ay\Z/){
				open (INDEX, "<$_[0]");
				my @LINES = <INDEX>;
				close (INDEX);
				open (INDEX, ">$_[0]");
				foreach my $LINE (@LINES){
					print INDEX $LINE unless ($LINE =~ m/\A($TERM)|($DESCRIPTION)\Z/);
				}
				close (INDEX);
				print "\n$TERM Sucessfully deleted\n";
			}else{
				say "\nDeletion Terminated";
				last;
			}
		}else{
			$termchecker ++;
		}
	}
	if ($termchecker == $#terms){
		say "Sorry, I couldnt find that term. Try searching the index with the argument 's'";
	}

}


if($ARGV[0] =~ /\Ar\Z/i){
	read_index ($indexDOC);
}elsif($ARGV[0] =~ /\Au\Z/i){
	update_index ($indexDOC);
}elsif($ARGV[0] =~ /\As\Z/i){
	search_index ($indexDOC);
}elsif($ARGV[0] =~ /\Ax\Z/i){
	delete_index ($indexDOC);
}else{
	say "Enter 'index r' to see the entire index";
	say "Enter 'index u' to add a term and description";
	say "Enter 'index s' to search for terms";
	say "Enter 'index x' to delete a term";
}
