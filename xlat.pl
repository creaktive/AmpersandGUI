#!/usr/bin/perl -w

#	This file is part of Ampersand.
#
#	Ampersand is free software: you can redistribute it and/or modify
#	it under the terms of the GNU Lesser General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	(at your option) any later version.
#
#	Ampersand is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU Lesser General Public License for more details.
#
#	You should have received a copy of the GNU Lesser General Public License
#	along with Ampersand.  If not, see <http://www.gnu.org/licenses/>.

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
			printf("cmd=%s id=%d x=%f y=%f vx=%f vy=%f a=%f\n", @set);
		}

		$out->send($pkt);
	}
}
