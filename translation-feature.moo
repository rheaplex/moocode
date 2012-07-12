;"Author:     Rob Myers <rob@robmyers.org> 2012"
;"License:    http://creativecommons.org/publicdomain/zero/1.0/"
;"-----------------------------------------------------------------------------"

@create $feature called "Translation Feature"

@describe "Translation Feature" as "A feature object for translating says."
@notedit "Translation Feature".help_msg
delete
enter
A feature object for translating text and saying it out loud.
Not every verb can translate every character, untranslatable characters are simply kept unchanged.
binary <text> => say the text in ASCII binary
leet <text> => say the text in 1337
morse <text> => say the text in Morse code
nato <text> => say the text in the NATO phonetic alphabet
pig <text> => say the text in Pig Latin.
rsay <text> => say the text in reverse
rwsay <text> => say each word of the text in reverse
.
save

;"one below space in ASCII"
@property "Translation Feature".trans_above 31 rc
;" one above tilde in ASCII"
@property "Translation Feature".trans_below 127 rc

@property "Translation Feature".leet {" ", "!", "\"", "#", "$", "%", "&", "'", "(", ")", "*", "+", ",", "-", ".", "/", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ":", ";", "<", "=", ">", "?", "@", "@", "13", "<", "[)", "&", "]=", "9", "#", "|", "_/", "|X", "|_", "/\\/\\", "/\\/", "()", "|o", "0,", "2", "$", "+", "(_)", "\\'", "vv", "><", "`//", "~/_", "[", "\\", "]", "^", "_", "`",  "4", "8", "(", "|)", "3", "|=", "6", "|-|", "!", "]", "|<", "1", "44", "|\|", "0", "|*", "0_", "|2", "5", "7", "|_|", "\\/", "\\/\\/", "%", "J", "2", "{", "|", "}", "~"}

@property "Translation Feature".morse {" ", "-.-.--", ".-..-.", "#", "...-..-", "%", ".-..", ".----.", "-.--.", "-.--.-", "*", ".-.-.", "--..--", "-....-", ".-.-.-", "-..-.", "-----", ".----", "..---", "...--", "....-", ".....", "-....", "--...", "---..", "----.", "---...", "-.-.-.", "<", "-...-", ">", "..--..", ".--.-.", ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.--", ".-.", "...", "-", "..-", "...-", ".--", "--..--", "-.--", "--..", "[", "\\", "]", "^", "..--.-", "`", ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.--", ".-.", "...", "-", "..-", "...-", ".--", "--..--", "-.--", "--..", "{", "|", "}", "~"}

@property "Translation Feature".nato {"  ", "!", "\"", "#", "$", "%", "&", "'", "(", ")", "*", "+", ",", "DASH ", "Stop ", "/", "Zero ", "One ", "Two ", "Three ", "Four ", "Five ", "Six ", "Seven ", "Eight ", "Nine", ":", ";", "<", "=", ">", "?", "@", "ALFA ", "BRAVO ", "CHARLIE ", "DELTA ", "ECHO ", "FOXTROT ", "GOLF ", "HOTEL ", "INDIA ", "JULIETT ", "KILO ", "LIMA ", "MIKE ", "NOVEMBER ", "OSCAR ", "PAPA ", "QUEBEC ", "ROMEO ", "SIERRA ", "TANGO ", "UNIFORM ", "VICTOR ", "WHISKEY ", "X-RAY ", "YANKEE ", "ZULU ", "[", "\\", "]", "^", "_", "`", "alfa ", "bravo ", "charlie ", "delta ", "echo ", "foxtrot ", "golf ", "hotel ", "india ", "juliett ", "kilo ", "lima ", "mike ", "november ", "oscar ", "papa ", "quebec ", "romeo ", "sierra ", "tango ", "uniform ", "victor ", "whiskey ", "x-ray ", "yankee ", "zulu ", "{", "|", "}", "~"}

;"This is mostly for people to derive from"
@property "Translation Feature".identity {" ", "!", "\"", "#", "$", "%", "&", "'", "(", ")", "*", "+", ",", "-", ".", "/", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ":", ";", "<", "=", ">", "?", "@", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "[", "\\", "]", "^", "_", "`", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "{", "|", "}", "~"}

@verb "Translation Feature":translate tnt rxd
@program "Translation Feature":translate
"Translate characters from string arg 1 through list arg 2";
text = args[1];
lookup = args[2];
output = {};
"Use a for loop rather than map_verb to avoid lots of verb calls";
for index in [1..length(argstr)]
  char = argstr[index];
  "Work out if the character is in the translation lookup table";
  charnum = $string_utils:to_ASCII(char) - this.trans_above;
  if (charnum > 0 && charnum < this.trans_below)
    output = {@output, lookup[charnum]};
  else
    output = {@output, char};
  endif
endfor
translated = $string_utils:from_list(output, "");
return translated;
.

@verb "Translation Feature":announce tnt rxd
@program "Translation Feature":announce
"Announce the message to the player and the player's location.";
message =  "\"" + args[1]  + "\"";
player:tell("You say, " + message);
player.location:announce($string_utils:pronoun_sub("%N says, ") + message);
.

@verb "Translation Feature":leet any any any rxd
@program "Translation Feature":leet
lookup = this.(verb);
translated = this:translate(argstr, lookup);
this:announce(translated);
.

@verb "Translation Feature":nato any any any rxd
@program "Translation Feature":nato
lookup = this.(verb);
translated = this:translate(argstr, lookup);
"Trim trailing whitespace from translated output before announcing";
this:announce($string_utils:trimr(translated));
.

@verb "Translation Feature":binary any any any rxd
@program "Translation Feature":binary
output = {};
"Use a for loop rather than map_verb to avoid lots of verb calls";
for index in [1..length(argstr)]
  char = argstr[index];
  charnum = $string_utils:to_ASCII(char);
  output = {@output, $math_utils:BlFromInt(charnum)[25..32]};
endfor
translated = $string_utils:from_list($list_utils:flatten(output), "");
this:announce(translated);
.

@verb "Translation Feature":pig any any any rxd
@program "Translation Feature":pig
words = $string_utils:words(argstr);
output = {};
for word in (words)
  if (word[1] in {"a", "e", "i", "o", "u"})
    output = {@output, word + "way"};
  else
    "I am *far* too complex. Pls simplify me";
    leading_consonants = "";
    rest = "";
    leading = 1;
    for index in [1..length(word)]
      char = word[index];
      if (char in {"a", "e", "i", "o", "u"})
	leading = 0;
      endif
      if (leading)
	leading_consonants = leading_consonants + char;
      else
	rest = rest + char;
      endif
    endfor
    output = {@output, rest + leading_consonants + "ay"};
  endif
endfor
translated = $string_utils:from_list(output, " ");
this:announce(translated);
.

@verb "Translation Feature":rsay any any any rxd
@program "Translation Feature":rsay
translated = $string_utils:reverse(argstr);
this:announce(translated);
.

@verb "Translation Feature":rwsay any any any rxd
@program "Translation Feature":rwsay
words = $string_utils:words(argstr);
output = $list_utils:map_arg($string_utils, "reverse", words);
translated = $string_utils:from_list(output, " ");
this:announce(translated);
.

@addalias morse,identity to "Translation Feature":leet

;$string_utils:match_object("Translation Feature", me):set_feature_verbs({})
