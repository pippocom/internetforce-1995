#!/usr/local/bin/perl

###########################################################################
#                               eff_form.pl                               #
#                                                                         #
# This script was written by Selena Sol (selena@eff.org                   #
# http://www.eff.org/~erict) having been inspired by countless other      #
# perl authors.  Feel free to copy, cite, reference, sample, borrow or    #
# plagiarize the contents.  However, please let me know where it goes so  #
# that I can at least watch and take part in the development of the       #
# memes. Information wants to be free, support public domain freware.     #
#                                                                         #
###########################################################################


# Find out if the server used the GET method to send the form 
# data to this script by checking the REQUEST_METHOD environmnet 
# variable.  If it did send with GET, save the contents of the 
# QUERY_STRING environmnet variable as $FORM_DATA to be used later.
# This line is not actually necessary for this script, since the form 
# that calls it is Post.  However, I included it in case I, or anyone else, 
# wanted to use Get at some point.  
# This form parsing routine was adapted from a script by Robert John
# Mudry which was published by the Coriolis Group as freeware in "Serving
# The Web".  This is an excellent book which I recommend to any cgi
# programmer.

  if ($ENV{'REQUEST_METHOD'} eq "GET") 
    {
    $FORM_DATA = $ENV{'QUERY_STRING'};
    } 

# If the server used the POST method to send the form data however, use the 
# CONTENT_LENGTH variable instead.  However, make sure that there isn't 
# an unlimited amount of data in the CONTENT_LENGTH variable (due to any 
# <TEXTAREA> tags to foul # things up.

    else 
      {
      $LENGTH = $ENV{'CONTENT_LENGTH'};
      if ($LENGTH > "32768") 
        {
        die "major network spam, stopped";
        }

# Dump the the information from the browser into variable $C for 
# filtration.  If the charcter coming in is an "=", we 
# know a value is starting .  If the character is an "&", we know that its 
# the end of a value.  Use the $START variable to watch the size of the 
# input.  So long as it is small enough, things are finem and $FORM_DATA 
# should be appended.  If not, disregard the long string.  The reason 
# that the limit above was 32768, when here it is  8192 is because we don't 
# want a legitimate blabbermouth to get cut off.
  
      while ($LENGTH--) 
        {
        $C = getc(STDIN);
        if ($C eq "=" || $C eq "&") 
          {
          $START = "0";
          } 
        else 
          {
          $START++;
          }
        if ($START <= "8192") 
          {
          $FORM_DATA .=$C;
          }
        }
     }

# So first, split up $FORM_DATA into $NAME and $VALUE.  Now store $VALUE 
# in $MYDATA{$NAME} provided that $NAME is not already in use.  If it is, a 
# temporary number stored in $NUM is incremented and a new the $VALUE is 
# saved as the new variable.

  foreach (split(/&/, $FORM_DATA)) 
    {
    ($NAME, $VALUE) = split(/=/, $_);
    $NAME =~ s/\+/ /g;
    $NAME =~ s/%([0-9|A-F]{2})/pack(C,hex($1))/eg;
    $VALUE =~ s/\+/ /g;
    $VALUE =~ s/%([0-9|A-F]{2})/pack(C,hex($1))/eg;
       
# Find unique Variable Name for every variable coming in from the form input

    $NUM = "0";
    while ($MYDATA{$NAME} ne "") 
      {
      $NUM++;
      $NAME =~ s/\.([0-9]+$)|$/\.$NUM/;
      }
          
# Store Variable NAME=Variable VAUE pair

      $MYDATA{$NAME} = $VALUE;
    }

# Write out all the gathered information to a temporary file.

  open (NOTE, ">/home/selena/public_html/cgi-bin/Data/form.temp");
  print NOTE "        HERE ARE THE RESULTS FROM THE EFF ONLINE MEMBERSHIP FORM \n";
  print NOTE "        -------------------------------------------------------- \n\n";  
  print NOTE "BASIC INFORMATION \n";
  print NOTE "\n";
  print NOTE "    Name: $MYDATA{'name.info'} \n";
  print NOTE "    Organization: $MYDATA{'organization.info'} \n";
  print NOTE "    Address: $MYDATA{'street.info'} \n";
  print NOTE "             $MYDATA{'citystatezip.info'} \n";
  print NOTE "    Email: $MYDATA{'email.info'} \n";
  print NOTE "    Alternate Email: $MYDATA{'email1.info'} \n";
  print NOTE "    Phone Number: $MYDATA{'phone.info'} \n";
  print NOTE "    Fax Number: $MYDATA{'fax.info'} \n";
  print NOTE "    Membership Pledge: $MYDATA{'pledge.info'} \n";
  print NOTE "    Special Contribution: \$$MYDATA{'specialcontribution.info'} \n";
  print NOTE "\n";
  print NOTE "OTHER INFORMATION \n";
  print NOTE "\n";

# Though we continue to build form.temp, we only want to add the 
# pertinent information from the checkboxes.  The following "if" statemetns 
# do that.  Note, the checkmark tag sends back "on" if its been checked 
# and the null string if not.  We don't need an alse cause we don't care 
# if they haven't checked the box.

  if ($MYDATA{'shirt.info'} eq "on")
    {
    print NOTE "    Plese send me $MYDATA{'numshirt.info'} for \$10 each \n";
    }
  if (($MYDATA{'freeshirt.info'} eq "on"))
    { 
    print NOTE "    I'm renewing, please send me my free shirt! \n";
    }
  if (($MYDATA{'effector.info'} eq "on"))
    {
    print NOTE "    Please send me EFFector \n";
    }  
  if (($MYDATA{'online.info'} eq "on"))
    {
    print NOTE "    Please send me Online Bulletins \n";
    }
  if (($MYDATA{'mailinglist.info'} eq "on"))
    {
    print NOTE "    I grant EFF permission to share my info with other 
    similar organizations \n";
    }
  print NOTE "\n";
  print NOTE "COMMENTS \n\n";
  print NOTE "    $MYDATA{'COMMENTS'} \n";
  close (NOTE);
  chmod (0664, "/home/selena/public_html/cgi-bin/Data/form.temp");

# Okay, now that we've built the form.temp file, let's send one copy to 
# the "membership coordinator" and one to the person who filed out the form 
# so they'll have a copy.  Then we'll remove the temporary file so we 
# don't clutter up the server.

  system ("mail -s test selena\@gaea.nchgr.nih.gov $MYDATA{'email.info'} < /home/selena/public_html/cgi-bin/Data/form.temp");
  system ("rm /home/selena/public_html/cgi-bin/Data/form.temp");

# Now let's append the log file which includes all the info from all 
# the filled out forms

  open (NOTE, ">>/home/selena/public_html/cgi-bin/Data/eff_form.output");
  print NOTE "        ANOTHER MEMBERSHIP APPLICATION \n";
  print NOTE "        ----- ------------------------ \n\n";
  print NOTE "BASIC INFORMATION \n";
  print NOTE "\n";
  print NOTE "    Name: $MYDATA{'name.info'} \n";
  print NOTE "    Organization: $MYDATA{'organization.info'} \n";
  print NOTE "    Address: $MYDATA{'street.info'} \n";
  print NOTE "             $MYDATA{'citystatezip.info'} \n";
  print NOTE "    Email: $MYDATA{'email.info'} \n";
  print NOTE "    Alternate Email: $MYDATA{'email1.info'} \n";
  print NOTE "    Phone Number: $MYDATA{'phone.info'} \n";
  print NOTE "    Fax Number: $MYDATA{'fax.info'} \n";
  print NOTE "    Membership Pledge: $MYDATA{'pledge.info'} \n";
  print NOTE "    Special Contribution: \$$MYDATA{'specialcontribution.info'} \n";
  print NOTE "\n";
  print NOTE "OTHER INFORMATION \n";
  print NOTE "\n";
  if ($MYDATA{'shirt.info'} eq "on")
    {
    print NOTE "    Plese send me $MYDATA{'numshirt.info'} for \$10 each \n";
    }
  if (($MYDATA{'freeshirt.info'} eq "on"))
    {
    print NOTE "    I'm renewing, please send me my free shirt! \n";
    }
  if (($MYDATA{'effector.info'} eq "on"))
    {
    print NOTE "    Please send me EFFector \n";
    }
  if (($MYDATA{'online.info'} eq "on"))
    {
    print NOTE "    Please send me Online Bulletins \n";
    }
  if (($MYDATA{'mailinglist.info'} eq "on"))
    {
    print NOTE "    I grant EFF permission to share my info with other
    similar organizations \n";
    }
  print NOTE "\n";
  print NOTE "COMMENTS \n\n";
  print NOTE "    $MYDATA{'COMMENTS'} \n";
  close (NOTE);

# Finally, let's send back a thank you note to the user!

  print "Content-type: text/html\n\n";
  print "<HTML><HEAD><TITLE>Thanks for your input</TITLE></HEAD><BODY> \n";
  print "<H1><CENTER>Thanks for your interest in the EFF!</CENTER></H1> \n";
  print "Unfortunately, we don't have a server capable of handling secure 
  communications.  In other words, it is not safe for you to send us your 
  credit card numbers over the net.  We'll have this capability 
  in a few months...but on the bright side, at this point, you are 
  basically done!  Simply print up this page, fill out the last couple 
  of entries, and send it to \n";
  print "<BLOCKQUOTE>Electronic frontier Foundation (Membership)<BR>P.O. 
  Box 170190<BR>San Francisco, CA 94117 </BLOCKQUOTE>\n";

  print "<CENTER><H2>APPLICATION FOR EFF MEMBERSHIP</H2></CENTER><BR><P> \n";
  print "<B>BASIC INFORMATION</B><P> \n";
  print "<BLOCKQUOTE>Name: $MYDATA{'name.info'} <BR>\n";
  print "Organization: $MYDATA{'organization.info'} <BR>\n";
  print "Address: $MYDATA{'street.info'} <BR>\n";
  print "$MYDATA{'citystatezip.info'} <BR>\n";
  print "Email: $MYDATA{'email.info'} <BR>\n";
  print "Alternate Email: $MYDATA{'email1.info'} <BR>\n";
  print "Phone Number: $MYDATA{'phone.info'} <BR>\n";
  print "Fax Number: $MYDATA{'fax.info'} <BR>\n";
  print "Membership Pledge: $MYDATA{'pledge.info'}<BR> \n";
  print "Special Contribution: \$$MYDATA{'specialcontribution.info'} <P> \n";
  print "</BLOCKQUOTE>\n";
  print "<B>OTHER INFORMATION</B><P> \n";
  print "<BLOCKQUOTE> \n";
  if ($MYDATA{'shirt.info'} eq "on")
    {
    print "Plese send me $MYDATA{'numshirt.info'} for \$10 each<BR> \n";
    }
  if (($MYDATA{'freeshirt.info'} eq "on"))
    {
    print "I'm renewing, please send me my free shirt! <BR> \n";
    }
  if (($MYDATA{'effector.info'} eq "on"))
    {
    print "Please send me EFFector <BR>\n";
    }
  if (($MYDATA{'online.info'} eq "on"))
    {
    print "Please send me Online Bulletins <BR> \n";
    }
  if (($MYDATA{'mailinglist.info'} eq "on"))
    {
    print "I grant EFF permission to share my info with other
    similar organizations <BR>\n";
    }
  print"</BLOCKQUOTE> \n";
  print "<B>PAYMENT METHOD</B> \n";
  print "<BLOCKQUOTE> \n";
  print "___ Enclosed is a check or money order payable to the Electronic 
  Frontier Foundation. US Funds only please.<P> \n";
  print " ___ Please charge my:<BR><DL> \n";
  print "<DT><DD>___ MasterCard</DT><DT><DD>___ Visa</DT><DT><DD>___ American Express</DL><BR> \n";
  print "Card Number: _________________________________________<BR> \n";
  print "Expiration Date: ___________________________________________<P> \n";
  print "Signature: __________________________________________________<P> \n";
  print "<B><I>NOTE:  We do not recommend sending credit card information
  via Internet email, unless it is encrypted!  You can use </I></B>\n";
  print "<A HREF=\"/pub/EFF/pgpkey.eff\">EFF's PGP public encryption key</A> for this purpose<P> \n";
  print "</BLOCKQUOTE> \n";
  print "<B>COMMENTS</B> \n\n";
  print "<BLOCKQUOTE>$MYDATA{'COMMENTS'} </BLOCKQUOTE> \n"; 
  print "</BODY></HTML> \n";
done
