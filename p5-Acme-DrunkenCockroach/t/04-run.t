use common::sense;

use Acme::DrunkenCockroach::VideoRoom;
use Acme::DrunkenCockroach::Cockroach;

my $room = Acme::DrunkenCockroach::VideoRoom->new(
	{m => 16, n => 16}
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
$room->finish();

say "Done in $count steps";

1;