package Acme::DrunkenCockroach::Cockroach;

use common::sense;

use Acme::DrunkenCockroach::Room;

use Moose;

has 'name'     => (is => 'rw');
has 'position' => (is => 'rw');
has 'history'  => (is => 'ro', 
                   isa => 'ArrayRef', 
                   default => sub { [] });
has 'room'	   => (is => 'ro', 
                   isa => 'Acme::DrunkenCockroach::Room');

my $all_possible_directions = 
	[{x => -1, y => -1}, 
	 {x => -1, y => 0},
	 {x => -1, y => 1},
	 {x => 0, y => -1},
	 {x => 0, y => 1},
	 {x => 1, y => -1},
	 {x => 1, y => 0},
	 {x => 1, y => 1}];

sub possible_directions {
	my ($self) = @_;
	return grep { 
		$self->room->position_inside(
			$self->apply_direction_to_position($_)
		)
	} @$all_possible_directions;
}

sub choose_direction {
	my ($self) = @_;
	my @directions = $self->possible_directions;
	return $directions[int(rand(@directions))];
}

sub apply_direction_to_position {
	my ($self, $direction) = @_;
	my $position = $self->position;
	return {x => $position->{x} + $direction->{x},
	        y => $position->{y} + $direction->{y}};
}

sub move_to {
	my ($self, $position) = @_;
	push @{$self->history}, $position;
	$self->position($position);
	$self->room->touched($position);
	say "Cockroach '${\$self->name}' now at ".
	    "${\$self->position->{x}}, ${\$self->position->{y}}";
}

sub take_step {
	my ($self) = @_;
	my $direction = $self->choose_direction;
	$self->move_to($self->apply_direction_to_position($direction));
}

1;