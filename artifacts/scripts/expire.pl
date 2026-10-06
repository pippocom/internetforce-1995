#!/usr/local/bin/perl

require "../typedefs.pl";
require "userlock.pl";

$UserDel = '/usr/export/sd1c/admin/deluser';


&OpenDBFiles;

while (($key, $value) = each %regusers) {

    next if (!$key);
    next if (!defined $regusers{$key});
    &SplitToCurrentUser($regusers{$key});

    if ($cur{'expiry'} < time()) {
        # this could be optimized by creating a list of all
	# accounts to be locked, and having only 1 pass over
	# /etc/passwd.

	$expired = int((time - $cur{'expiry'}) / (60*60*24));
	if ($expired < 30) {
#	    print "Account '" . $key . "' expired $expire days ago, locked.\n";
	    &set_userlock($key,1);
	} else {
#	    print "Account '" . $key . "' expired $expire days ago, erased.\n";

	    delete $regusers{$key};
	    open(DELUSER, "$DelUser " . $input{'eraseuser'} . " |");
	    while (<DELUSER>) {
		print;
	    }
	    close(DELUSER);
	}
    }
}

&CloseDBFiles;
	


