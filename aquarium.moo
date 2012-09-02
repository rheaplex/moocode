;"Author:     Rob Myers <rob@robmyers.org> 2012"
;"License:    http://creativecommons.org/publicdomain/zero/1.0/"
;"-----------------------------------------------------------------------------"

@create $thing called "Aquarium"
@addalias fish, fishes, tank to "Aquarium"

@describe Aquarium as "The fish in the aquarium."
@notedit Aquarium.help_msg
delete
enter
The fish in the aquarium.
You can look at them or feed them.
Don't tap the tank though.
.
save


;"-----------------------------------------------------------------------------"
;"Description constants"

@property Aquarium.quantities {"A", "A pair of", "A few", "Some", "A shoal of"} rc

@property Aquarium.personalities {"careless", "cheeky", "cheerful", "nervous", "playful", "snooty", "over-enthusiastic", "calm", "serene", "friendly", "fast-moving", "slow-moving"} rc

@property Aquarium.shapes {"tiny", "spindly", "streamlined", "plump", "spiky", "toothsome", "big-eyed", "flat", "scaly", "smooth", "nondescript", "cute", "small", "round", "triangular"} rc

@property Aquarium.qualities {"iridescent", "sparkling", "mottled", "dull", "shiny", "striped", "spotty", "plain", "matt", "soft"} rc

@property Aquarium.hues {"red", "orange", "yellow", "green", "blue", "purple", "pink", "silver", "gold", "black", "white", "brown", "turquoise", "cyan", "magenta"} rc

@property Aquarium.actions {"%<blows> bubbles at you from the aquarium.", "%<swims> lazily around the aquarium.", "%<swims> betwen the plants in the aquarium.", "%<floats> close to the glass at the front of the aquarium.", "%<swims> around the aquarium.", "%<bobs> up and down near the surface of the water in the aquarium.", "%<swims> around the edges of the aquarium.", "%<swims> toward the front of the aquarium", "%<swims> away from the front of the aquarium", "%<nibbles> at the plants in the aquarium."} rc


@property Aquarium.events {"A trail of bubbles snakes up through the water of the aquarium.", "The plants in the aquarium sway gently.", "The fish in the aquarium seem to all change the direction they are swimming in at once.", "Light from the aquarium dances on the floor.", "You notice that all the fish in the aquarium seem to have vanished, although when you look closer they are just hiding behind the rocks and plants.", "A single large bubble works its way up through the water of the aquarium.", "There is a sudden flurry of motion in the aquarium.", "The fish in the aquarium swim to and fro."} rc

@property Aquarium.tap_messages {"Don't do that.", "The fish flee from the tapping.", "The fish ignore the tapping.", "A particularly dangerous looking fish swims over and looks hungrily at some tasty-looking fingers.", "Some of the fish closest to the glass flee the tapping.", "One of the fish blows bubbles at you."} rc

@property Aquarium.feed_messages {"Omnomnom...", "There is a brief feeding frenzy.", "Some fish swim up to the food and nibble.", "The fish feed happily.", "Fishy foody time!", "Nomnomnom.", "The larger fish push to the surface to feed, the smaller fish pick off the scraps that float down into the water.", "The fish quickly remove any trace of food from the water."} rc

@property Aquarium.fed_messages {"They don't need any more just now."} rc


@property Aquarium.response_delay 30 rc
@property Aquarium.feed_time_delay 120 rc
@property Aquarium.action_odds 5 rc


;"-----------------------------------------------------------------------------"
;"State variables"

@property Aquarium.current_fish "" rc
;"We set this so we can pronoun_sub for plurality easily and hackily."
;"Set it to neuter or plural then set who=this in pronoun_sub."
@property Aquarium.gender "neuter" rc
@property Aquarium.last_fed_at 0 rc


;"-----------------------------------------------------------------------------"
;"Verbs for generating descriptions"

@verb Aquarium:generate_current_fish tnt rxd
@program Aquarium:generate_current_fish
quantity_index = random(length(this.quantities));
"Set this so we can use pronoun_sub to pluralise for us.";
if (quantity_index == 1)
  this.gender = "neuter";
else
  this.gender = "plural";
endif
quantity = this.quantities[quantity_index];
personality = this.personalities[random($)];
shape = this.shapes[random($)];
quality = this.qualities[random($)];
hue = this.hues[random($)];
this.current_fish = $string_utils:from_list({quantity, personality, shape, quality, hue, "fish"}, " ");
.

@verb Aquarium:generate_fish_action tnt rxd
@program Aquarium:generate_fish_action
this:generate_current_fish();
action = this.current_fish + " " + this.actions[random($)];
return $string_utils:pronoun_sub(action, who=this);
.

@verb Aquarium:generate_event tnt rxd
@program Aquarium:generate_event
return this.events[random($)];
.


;"-----------------------------------------------------------------------------"
;"Verbs for interacting with the aquarium"

;"Only post messages when something is happening in the room."

@verb Aquarium:tell tnt rxd
@program Aquarium:tell
"Filter out messages from this object";
if (!(this in $list_utils:slice(callers())) && random(this.action_odds) == 1)
  action = random(2);
 if (action == 1)
   message = this:generate_fish_action();
 elseif (action == 2)
   message = this:generate_event();
 endif
 fork (random(this.response_delay))
   this.location:announce_all_but({this}, message);
 endfork
endif
.

@verb Aquarium:tap any any any rxd
@program Aquarium:tap
player.location:announce($string_utils:pronoun_sub("%N %<taps> the glass of the aquarium."));
player:tell("You tap the glass of the aquarium.");
player:tell(this.tap_messages[random($)]);
.

@verb Aquarium:feed any any any rxd
@program Aquarium:feed
now = time();
delta = now - this.last_fed_at;
if(delta > this.feed_time_delay)
  player.location:announce($string_utils:pronoun_sub("%N %<feeds> the fish in the aquarium."));
  player:tell("You feed the fish in the aquarium.");
  player.location:announce_all(this.feed_messages[random($)]);
  this.last_fed_at = now;
else
  player:tell(this.fed_messages[random($)]);
endif
.