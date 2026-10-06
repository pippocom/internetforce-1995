#!/usr/bin/tcsh
mt -f /dev/rst0 rewind
gtar -czvf - /. | dd bs=220k of=/dev/nrst0
(rsh data gtar -czvf - /) | dd bs=220k of=/dev/nrst0
(rsh users gtar -czvf - /) | dd bs=220k of=/dev/nrst0
(rsh firewall gtar -czvf - /.) | dd bs=200k of=/dev/nrst0
(rsh marco tar -czvf - /.) | dd bs=200k of=/dev/nrst0

