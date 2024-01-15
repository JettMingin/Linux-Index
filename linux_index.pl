#!/usr/bin/perl

use v5.28;
use strict;
use warnings;

#using bash alias "alias index='/[YOUR FILE PATH]/linux_index.pl'"

sub read_index{
	open INDEX, '/[YOUR FILE PATH]/indexDOC.txt';
	chomp (my @indexDOC = <INDEX>);
	
	my %index = @indexDOC;

	my @terms = sort (keys %index);

	say "*** THE INDEX ***";
	say "*reading from indexDOC.txt*\n";
	my $linecount = 1;
		
	foreach my $i (0..$#terms){
		chomp $terms[$i];
		print "$linecount" . ". $terms[$i] - $index{$terms[$i]}\n\n";
		$linecount ++;
	}
}
	
sub search_index{
	open INDEX, '/[YOUR FILE PATH]/indexDOC.txt';
	chomp (my @indexDOC = <INDEX>);
	
	my %index = @indexDOC;

	my @terms = sort (keys %index);
		
	say "***INDEX SEARCH***";
	say "Enter your desired search term:";
	chomp (my $searchterm = <STDIN>);
	print "\n";
		
	foreach my $i (0..$#terms){
		chomp $terms[$i];
		if ($terms[$i] =~ /\A$searchterm/){
			print "$terms[$i] - $index{$terms[$i]}\n\n";
		}
	}
}
	
	
sub update_index{
	my $index = '/[YOUR FILE PATH]/indexDOC.txt';
	open INDEX, ">> $index";
	print "Enter your term\n";
	my $a = <STDIN>;
	print INDEX $a;
	print "Enter your description\n";
	my $b = <STDIN>;
	print INDEX $b;
	print "$a Sucessfully added to the doc\n";
}
	
sub delete_index{
	open INDEX, '/[YOUR FILE PATH]/indexDOC.txt';
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
				open (INDEX, "</[YOUR FILE PATH]/indexDOC.txt");
				my @LINES = <INDEX>;
				close (INDEX);
				open (INDEX, ">/[YOUR FILE PATH]/indexDOC.txt");
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



	if($ARGV[0] =~ /r/i){
		read_index;
	}elsif($ARGV[0] =~ /u/i){
		update_index;
	}elsif($ARGV[0] =~ /s/i){
		search_index;
	}elsif($ARGV[0] =~ /x/i){
		delete_index;
	}else{
		say "Enter 'index r' to see index";
		say "Enter 'index u' to add a term and description";
		say "Enter 'index s' to search for terms";
		say "Enter 'index x' to delete a term";
	}
