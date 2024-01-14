#!/usr/bin/perl

use v5.28;
use strict;
use warnings;


	sub read_index{
		open INDEX, '/home/jettmingin/bash_learning/nottxt/indexDOC.txt';
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
		open INDEX, '/home/jettmingin/bash_learning/nottxt/indexDOC.txt';
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
		my $index = '/home/jettmingin/bash_learning/nottxt/indexDOC.txt';
		open INDEX, ">> $index";
		print "Enter your term\n";
		my $a = <STDIN>;
		print INDEX $a;
		print "Enter your description\n";
		my $b = <STDIN>;
		print INDEX $b;
	}


	if($ARGV[0] =~ /c/i){
		print 'success';
	}elsif($ARGV[0] =~ /r/i){
		read_index;
	}elsif($ARGV[0] =~ /u/i){
		update_index;
	}elsif($ARGV[0] =~ /s/i){
		search_index;
	}else{
		say "Enter 'index r' to see index";
		say "Enter 'index u' to add a term and description";
		say "Enter 'index s' to search for terms";
	}
