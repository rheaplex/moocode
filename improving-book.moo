;"Author:     Rob Myers <rob@robmyers.org> 2012"
;"License:    http://creativecommons.org/publicdomain/zero/1.0/"
;"Notes:      @book <player> -> Give player an improving book."
;"            Requested by Vixy and Ebony_Guest."
;"            Book suggestions from crouton."
;"-----------------------------------------------------------------------------"

@create $feature called "improving_books"

@describe improving_books as "A feature object for handing improving books to people."

@notedit improving_books.help_msg
delete
enter
A feature that allows you to hand people improving books.
It provides the following commands:
  @book <player> => Hand <player> an improving book.
.
save


@property improving_books.books {"The Bible", "The Talmud", "The Koran", "Mrs Beeton's Book of Household Management", "Atlas Shrugged", "The Singularity Is Near", "Free Software, Free Society", "Das Kapital", "Yib's Guide To MOOing", "Leviathan", "The Complete Works Of Shakespeare", "Ulysses", "Zen And The Art Of Motorcycle Maintenance", "The Wealth Of Nations", "Green Eggs And Ham", "One Fish, Two Fish, Red Fish, Blue Fish", "The Singularity Is Near", "My Tiny Life", "Where The Wild Things Are"} rc

@property improving_books.book_msg "You give %D an improving book. Ooh! It's %[tcurrent_book]." rc

@property improving_books.book_omsg "%N gives %D an improving book. Ooh! It's %[tcurrent_book]." rc

@property improving_books.current_book "" rc


@verb improving_books:@improve any any any rxd
@program improving_books:@improve
"Hand someone an improving book.";
this.current_book = this.books[random($)];
if (! valid(dobj))
  "If the direct object doesn't name anything in the player's location";
  player:tell("You can't: " + dobjstr + " isn't here.");
elseif (! is_player(dobj))
  "If the direct object isn't a player";
  player:tell($string_utils:pronoun_sub("You can't: %d isn't a player."));
elseif (dobj.location != player.location)
  "If the player is not in the same location as the other player";
    player:tell($string_utils:pronoun_sub("You can't: %d isn't here."));
else
  player:tell($string_utils:pronoun_sub(this.book_msg));
  player.location:announce($string_utils:pronoun_sub(this.book_omsg));
endif
.


;$string_utils:match_object("improving_books", me):set_feature_verbs({"@improve"})
