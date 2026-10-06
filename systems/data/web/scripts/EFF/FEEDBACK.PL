#!/usr/local/bin/perl

###########################################################################
#                              feedback.pl                                #
#                                                                         #
# This script was written by Selena Sol (selena@eff.org                   #
# http://www.eff.org/~erict) having been inspired by countless other      #
# perl authors.  Feel free to copy, cite, reference, sample, borrow or    #
# plagiarize the contents.  However, please let me know where it goes so  #
# that I can at least watch and take part in the development of the       #
# memes. Information wants to be free, support public domain freware.     #
#                                                                         #
###########################################################################


# Set a server-specific variables.  You'll need to change this path for 
# your own setup.  Also, remember to setchmod and chown stuff for your setup.

    $tempfile = "/home/selena/public_html/cgi-bin/Data/feedback.temp";

# If the server used the POST method to send the form data however, use the 
# CONTENT_LENGTH variable instead.  However, make sure that there isn't 
# an unlimited amount of data in the CONTENT_LENGTH variable (due to any 
# <TEXTAREA> tags to foul # things up.
# This form parsing routine was adapted from a script by Robert John
# Mudry which was published by the Coriolis Group as freeware in "Serving
# The Web".  This is an excellent book which I recommend to any cgi
# programmer.


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
       
# Find unique Name

    $NUM = "0";
    while ($MYDATA{$NAME} ne "") 
      {
      $NUM++;
      $NAME =~ s/\.([0-9]+$)|$/\.$NUM/;
      }
          
# Store NAME=VAUE pair

      $MYDATA{$NAME} = $VALUE;
    }
   
# Write out all the gathered information to a temporary file.

  open (NOTE, ">$tempfile");
  print NOTE "        FEEDBACK FORM TEMPLATE \n";
  print NOTE "        ----------------------- \n\n";  
  print NOTE "BASIC INFORMATION\n\n";
  print NOTE "    Name: $MYDATA{'name.info'} \n";
  print NOTE "    E-Mail: $MYDATA{'email.info'} \n\n";
  print NOTE "COMMENTS \n\n";
  print NOTE "    $MYDATA{'COMMENTS'} \n";
  print NOTE "\n";
  close (NOTE);

# Okay, now that we've built the form.temp file, let's send one copy to 
# the "membership coordinator" and one to the person who filed out the form 
# so they'll have a copy.  Then we'll remove the temporary file so we 
# don't clutter up the server.

  system ("mail -s test selena\@gaea.nchgr.nih.gov < $tempfile");
  system ("rm $tempfile");

# Finally, let's send back a thank you note to the user!

  print "Content-type: text/html\n\n";
  print "<HTML><HEAD><TITLE>Feedback Response</TITLE></HEAD><BODY> \n";
  print "<H1><CENTER>Thanks for your feedback.</H1></CENTER>  Your comments 
         are very 
         important to us.  If your comments require reply, 
         someone will get back to you ASAP</CENTER></H1> \n";
  print "</BODY></HTML> \n";
