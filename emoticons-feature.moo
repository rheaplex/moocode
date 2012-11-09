;"Author:     Rob Myers <rob@robmyers.org> 2012"
;"License:    http://creativecommons.org/publicdomain/zero/1.0/"
;"Notes:      ems -> EMote Smiley, etc."
;"            $feature -> Generic Feature Object on LambdaMOO"
;"-----------------------------------------------------------------------------"

@create $feature called "Emoticons Feature"

@describe "Emoticons Feature" as "A feature object for emoting emoticons."
@notedit "Emoticons Feature".help_msg
delete
enter
A feature that simplifies emoting emoticons.
It provides the following commands that print the following emoticons:
ems => :-)
emf => :-(
emg => :-D
emm => :-/
emw => ;-)
.
save
done

@property "Emoticons Feature".ems ":-)" rc
@property "Emoticons Feature".emf ":-(" rc
@property "Emoticons Feature".emg ":-D" rc
@property "Emoticons Feature".emm ":-/" rc
@property "Emoticons Feature".emw ";-)" rc

@verb "Emoticons Feature":ems any any any rxd
@program "Emoticons Feature":ems
player.location:announce_all($string_utils:pronoun_sub("%N " + this.(verb)));
.

@addalias emf,emg,emm,emw to "Emoticons Feature":ems

;$string_utils:match_object("Emoticons Feature", me):set_feature_verbs({})
