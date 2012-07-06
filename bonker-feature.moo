;"Author:     Rob Myers <rob@robmyers.org> 2012"
;"License:    http://creativecommons.org/publicdomain/zero/1.0/"
;"-----------------------------------------------------------------------------"

@create $feature called "Bonker Feature"

@describe "Bonker Feature" as "A feature object for bonking players."
@set "Bonker Feature".help_msg to {"A feature object for bonking players."}

;"Lots of properties, for easy modification or subclassing"

@property "Bonker Feature".bonk "bonks" rc
@property "Bonker Feature".obonk "bonk" rc
@property "Bonker Feature".dbonk "bonked" rc

@property "Bonker Feature".bonk_msg "%N %[tbonk] %d!" rc
@property "Bonker Feature".bonk_omsg "You %[tobonk] %d!" rc
@property "Bonker Feature".bonk_dmsg "%N %[tdbonk] you!" rc

@property "Bonker Feature".self_bonk_msg "%N %[tbonk] %r!" rc
@property "Bonker Feature".self_bonk_dmsg "You %[tdbonk] yourself!" rc

@verb "Bonker Feature":bonk_msg none any none rxd
@program "Bonker Feature":bonk_msg
"Expand the format string for the caller";
return $string_utils:pronoun_sub(this.(verb));
.

@addalias bonk_omsg,bonk_dmsg to "Bonker Feature":bonk_msg
@addalias self_bonk_msg,self_bonk_dmsg to "Bonker Feature":bonk_msg

@verb "Bonker Feature":bonk any any any rxd
@program "Bonker Feature":bonk
"Bonk the player";
if (! valid(dobj))
  "If the direct object doesn't name anything in the player's location";
  player:tell("You can't: " + dobjstr + " isn't here.");
elseif (! is_player(dobj))
  "If the direct object isn't a player";
  player:tell($string_utils:pronoun_sub("You can't: %d isn't a player."));
elseif (dobj.location != player.location)
  "If the player is not in the same location as the other player";
    player:tell($string_utils:pronoun_sub("You can't: %d isn't here."));
elseif (dobj == player)
  "If the player is doing this to themself";
  player:tell(this:self_bonk_dmsg());
  player:announce(this:self_bonk_msg());
else
  "The player is doing this to another player";
    player:tell(this:bonk_omsg());
    player.location:announce_all_but({player, dobj}, this:bonk_msg());
    dobj:tell(this:bonk_dmsg());
endif
.

;$string_utils:match_object("Bonker Feature", me):set_feature_verbs({"bonk"})
