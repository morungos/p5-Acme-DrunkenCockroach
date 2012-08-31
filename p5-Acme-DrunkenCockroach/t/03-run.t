 use common::sense;

use Acme::DrunkenCockroach::Room;
use Acme::DrunkenCockroach::Cockroach;

my $room = Acme::DrunkenCockroach::Room->new(
	{m => 10, n => 10}
);
my $cockroach = Acme::DrunkenCockroach::Cockroach->new(
	{room => $room, name => "Stuart"}
);

$cockroach->move_to({x => 0, y => 0});

my $count = 0;
while(! $room->done()) {
	$cockroach->take_step();
	$count++;
}

say "Done in $count steps";

1;