#!/usr/bin/perl

use v5.28;
use strict;
use warnings;

open INDEX, '/[YOUR FILE PATH]/indexDOC.txt';
chomp (my @indexDOC = <INDEX>);
close (INDEX);
my %index = @indexDOC;
my @terms = sort (keys %index);

printf "%43s\n", "***INDEX FLASHCARDS***";
say "*Enter the term associated with the prompt. Enter q/quit to quit*";
say "(If your answer is a punctuation mark, enter it in 'single quotes')";

sub game{
	say "\n$_[0]";
	my $answer = 0;
	my @hints = split //, $_[1];
	my $hintCount = $_[2]; 
	
	until ($answer eq $_[1]){
		
		print "Answer: ";
		chomp ($answer = <STDIN>);
		
		if ($answer =~ /\Aq(uit)*\Z/i){
			return $answer;
		}elsif ($answer =~ /\Ah(elp|int)*\Z/i){
			if ($hintCount > $#hints){
				say "Sorry, you asked for too many hints!";
			}else{
				print "You asked for a hint! - ";
				foreach my $i (0..$hintCount){
					print "$hints[$i]";
				}
				$hintCount ++;
				print "\n";
			}
			
		}elsif ($answer !~ $_[1]){
			say "Incorrect, enter 'h' for a hint!";
		}
	}
}


while (1){
	my $termselecter = int(rand($#terms));
	
	my $quitter = game ($index{$terms[$termselecter]}, $terms[$termselecter], 0);

	last if ($quitter =~ /\Aq(uit)*\Z/i);
}
