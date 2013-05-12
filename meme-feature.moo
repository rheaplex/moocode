;"Author:     Rob Myers <rob@robmyers.org> 2012"
;"License:    http://creativecommons.org/publicdomain/zero/1.0/"
;"-----------------------------------------------------------------------------"

@create $feature called "Meme Feature"

@describe "Meme Feature" as "A feature object for memeing."
@notedit "Meme Feature".help_msg
delete
enter
2010s culture for 1990s technology.
You can say or directed say the following:
ac*ccepted, all*yourbase, er*magherd, fu*ckyea, if*youknow, laz*er, ni*nethousand, now*ai, ny*an, oha*i, om*nomnom, or*ly, sp*arta, wat*chout, yar*ly
e.g.
nyan
or yarrel
And you can say or directed say the following:
mo*ds, mo-*, yu*no, yu-*
e.g.
yu-yarrel not set help
.
save
done

;"Meme verb property names are 2 characters and are unique on this object"
;"We use longer verb alieases where they would clash with the Carpal Tunnel FO"
;"If we could get the specific verb name matched by the parser we'd use that..."

@property "Meme Feature".ac "Challenge Accepted" r
@property "Meme Feature".al "All your base are belong to us." r
@property "Meme Feature".er "Ermahgerd!" r
@property "Meme Feature".fu "FUCK YEA." r
@property "Meme Feature".if "If you know what I mean." r
@property "Meme Feature".la "I'M A' FIRIN' MAH LAZER!!" r
@property "Meme Feature".me "ME GUSTA" r
@property "Meme Feature".ni "IT'S OVER NINE THOUSAAAAAAAAAAAND!" r
@property "Meme Feature".no "NO WAI!!!" r
@property "Meme Feature".ny "Nyanyanyanyanyanyanya!" r
@property "Meme Feature".oh "OH HAI" r
@property "Meme Feature".om "OM NOM NOM NOM" r
@property "Meme Feature".or "O RLY?" r
@property "Meme Feature".sp "THIS IS SPARTA!" r
@property "Meme Feature".wa "Watch out guys, we're dealing with a badass over here." r
@property "Meme Feature".ya "YA RLY" r

;"Verbs that take a string"

@property "Meme Feature".yu "Y U NO" r
@property "Meme Feature".mo "Mods are asleep, post" r

@verb "Meme Feature":sp*arta any any any rxd
@program "Meme Feature":sp*arta
meme_name = verb[1..2];
meme = this.(meme_name);
if (dobj != $nothing)
  "If it's directed to someone make it look like a directed say.";
  if (! $command_utils:object_match_failed(dobj, args[1]))
    player.location:announce_all(player.name, " [to ", dobj.name, "]: ", meme);
  endif
else
  "Otherwise make it look like a say";
  player.location:say(argstr=meme);
endif
.

@verb "Meme Feature":"yu*no yu-*" any any any rxd
@program "Meme Feature":"yu*no"
if (! argstr)
  player:tell("You should specify something additional to say.");
  return;
endif
meme_name = verb[1..2];
meme = this.(meme_name);
if(strcmp($string_utils:uppercase(meme[$]), meme[$]) == 0)
  "If the meme is all uppercase, uppercase the user-provided text";
  meme = meme + " " + $string_utils:uppercase(argstr);
else
  meme = meme + " " + argstr;
endif
if (length(verb) > 2 && verb[3] == "-")
  "If it's directed to someone make it look like a directed say.";
  name = verb[4..$];
  who = player.location:match_object(name);
  if (! $command_utils:object_match_failed(who, name))
    player.location:announce_all(player.name, " [to ", who.name, "]: ", meme);
  endif
else
  "Otherwise make it look like a say";
  player.location:say(argstr=meme);
endif
.

;"Aliases are two or three letters as required to avoid clashes with the CT FO."

@addalias ac*ccepted, all*yourbase, er*magherd, fu*ckyea, if*youknow, laz*er, ni*nethousand, now*ai, ny*an, oha*i, om*nomnom, or*ly, wat*chout, yar*ly to "Meme Feature":sparta

@addalias mo*ds, mo-* to "Meme Feature":yuno

;$string_utils:match_object("Meme Feature", me):set_feature_verbs({})
