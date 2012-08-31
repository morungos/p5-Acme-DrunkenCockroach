package Acme::DrunkenCockroach::Room;

use common::sense;

use Moose;

has 'm'     => (is => 'ro');
has 'n'     => (is => 'ro');

sub BUILD {
	my ($self) = @_;
	$self->{_coverage} = {};
	$self->{_covered} = 0;
}

sub position_inside {
	my ($self, $position) = @_;
	my $room_m = $self->m;
	my $room_n = $self->n;
	return $position->{x} >= 0 &&
		$position->{y} >= 0 &&
		$position->{x} < $room_m &&
		$position->{y} < $room_n;
}

sub touched {
	my ($self, $position) = @_;
	my $x = $position->{x};
	my $y = $position->{y};
	if (! exists($self->{_coverage}->{$x}->{$y})) {
		$self->{_coverage}->{$x}->{$y} = 1;
		$self->{_covered}++;
	} 
}

sub done {
	my ($self) = @_;
	return $self->{_covered} == ($self->m * $self->n);
}

sub finish {
	my ($self) = @_;
}

1;