;"Author:     Rob Myers <rob@robmyers.org> 2012"
;"License:    http://creativecommons.org/publicdomain/zero/1.0/"
;"Many thanks to Dreyannah"
;"-----------------------------------------------------------------------------"

@verb me:lick this none none
@program me:lick
if (this.location != player.location)
  lickfail = "You must be in the same location as %t to lick %[dpo].";
  player:tell($string_utils:pronoun_sub(lickfail));
elseif (this == player)
  lick = "You lick yourself. Mmm! You taste just like raisins.";
  player:tell($string_utils:pronoun_sub(lick));
  licks = "%N %<licks> %r. Mmm! %[dpsc] %<d:tastes> just like raisins.";
  player.location:announce_all_but({player}, $string_utils:pronoun_sub(licks));
else
  lick = "You lick %t. Mmm! %[dpsc] %<d:tastes> just like raisins.";
  player:tell($string_utils:pronoun_sub(lick));
  licks = "%N %<licks> %t. Mmm! %[dpsc] %<d:tastes> just like raisins.";
  but = {this, player};
  player.location:announce_all_but(but, $string_utils:pronoun_sub(licks));
  licked = "%N %<licks> you. Mmm! You taste just like raisins.";
  this:tell($string_utils:pronoun_sub(licked));
endif
.
