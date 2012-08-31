package Acme::DrunkenCockroach::VideoRoom;

use common::sense;

use Moose;
use PDL;
use PDL::IO::Pic;

extends 'Acme::DrunkenCockroach::Room';

sub BUILD {
	my ($self) = @_;
	$self->{_room_history} = [];
}

after 'touched' => sub { 
	my ($self, $position) = @_;
	push @{$self->{_room_history}}, $position;
};

after 'finish' => sub {
	my ($self) = @_;
	my $frames = $self->{_room_history};
	my $frame_count = @$frames;
	my $x = $self->m;
	my $y = $self->n;
	my $images = zeroes byte, 3, $x, $y, $frame_count;
	my $new_pixel = pdl byte, 255, 0, 0;
	for (my $i = 0; $i < $frame_count; $i++) {
		my $this = $frames->[$i];
		my $px = $this->{x};
		my $py = $this->{y};
		$images->slice("0:2,($px),($py),($i)") .= $new_pixel;
	}
	
	unlink('output.gif');
	$images->wmpeg("output.gif");
};

1;