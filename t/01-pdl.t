use common::sense;

use PDL;

my $data = pdl 42;
my $definitely_a_pdl = topdl($data);
my $block = sequence(2, 3);
my $ones = ones(3, 2);
my $vector = pdl(2,2,2,4,0,-1,6,6);

# Some operations
print sequence(2, 3) x ones(3, 2);
print sequence(2, 3) + ones(2, 3);
print sin(sequence(2, 3));
print uniq(pdl(2,2,2,4,0,-1,6,6));

# Fiddling with values
print $block->slice("1,2");
$block->slice("1,2") .= 99;
$block->slice("1,:") .= sqrt($block->slice("1,:"));

my ($mean,$prms,$median,$min,$max,$adev,$rms) = stats($vector);

# Some more intriguing stuff
print fibonacci(10);
print sumover(fibonacci(10));
print prodover(sequence(10) + 1);
xvals(100, 100)->wpic('out.gif');
(xvals(100, 100) + yvals(100,100))->wpic('out2.gif');

1;