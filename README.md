# Linux-Index
A Perl program I made to display, update, and search a document containing notes I've taken while learning Linux.

Creates a hash from the lines in the doc, using odd-numbered lines as keys and their following lines as their respective values. With this hash I can format and display the doc entirely, search for specific terms within the doc, add new terms/descriptions to the doc, and delete existing terms.

Using a bash alias: "alias index='/[YOUR FILE PATH]/linux_index.pl'" to access it from anywhere within the command line

Arguments:
"r" to display the entire doc, sorted alphabetically.
"s" to search for specific terms.
"u" to add a new term and description to the doc.
"x" to delete an existing term and description from the doc.

Also includes a second program acting as a flashcard/study-guide game, randomly selecting descriptions of terms and prompting the user to enter the correct term.
