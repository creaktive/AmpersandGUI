#!/usr/bin/perl -w
use strict;
use Data::Dumper;
use IO::Socket::INET;

my $in	= new IO::Socket::INET(
	LocalPort	=> 3334,
	Proto		=> 'udp',
);
my $out	= new IO::Socket::INET(
	PeerAddr	=>'localhost',
	PeerPort	=> 3333,
	Proto		=> 'udp',
);

for(;;) {
	my $pkt;
	if (defined $in->recv($pkt, 10240)) {
		my $p = -1;
		while (($p = index($pkt, 'set', $p + 1)) >= 0) {
			my $bin = substr($pkt, $p, 32);
			my @set = unpack('Z* i> f>*', $bin);
			($set[2], $set[3]) = ($set[3], 1.0 - $set[2]);
			($set[4], $set[5]) = ($set[5], 1.0 - $set[4]);
			substr($pkt, $p, 32) = pack('Z* i> f>*', @set);
			#printf("cmd=%s id=%d x=%f y=%f vx=%f vy=%f a=%f\n", @set);
		}

		$out->send($pkt);
	}
}
