;"Author:     Rob Myers <rob@robmyers.org> 2012"
;"License:   http://creativecommons.org/publicdomain/zero/1.0/"
;"           ASCII art from: http://www.asciiworld.com/-Geometry-.html"
;"           No idea of the license on that."
;"           Feel free to add more and send a merge request. :-)" 
;"-----------------------------------------------------------------------------"

@create $feature called "ASCII Art Feature"

@describe "ASCII Art Feature" as "A feature object for emoting ASCII art."

@edit "ASCII Art Feature".help_msg
delete
enter
Each verb emotes the described ASCII art to everyone in the room.
.
save

@verb "ASCII Art Feature":asciiheart any any any rxd
@program "ASCII Art Feature":asciiheart
"A heart";
player.location:announce_all("        @@@@@@           @@@@@@");
player.location:announce_all("      @@@@@@@@@@       @@@@@@@@@@");
player.location:announce_all("    @@@@@@@@@@@@@@   @@@@@@@@@@@@@@");
player.location:announce_all("  @@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@@");
player.location:announce_all(" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
player.location:announce_all("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
player.location:announce_all("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
player.location:announce_all("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
player.location:announce_all(" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
player.location:announce_all("  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
player.location:announce_all("   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
player.location:announce_all("    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
player.location:announce_all("      @@@@@@@@@@@@@@@@@@@@@@@@@@@");
player.location:announce_all("        @@@@@@@@@@@@@@@@@@@@@@@");
player.location:announce_all("          @@@@@@@@@@@@@@@@@@@");
player.location:announce_all("            @@@@@@@@@@@@@@@");
player.location:announce_all("              @@@@@@@@@@@");
player.location:announce_all("                @@@@@@@");
player.location:announce_all("                  @@@");
player.location:announce_all("                   @");
.

@verb "ASCII Art Feature":asciiknot any any any rxd
@program "ASCII Art Feature":asciiknot
"A knot";
player.location:announce_all("                                ,_-=(!7(7/zs_.");
player.location:announce_all("                             .='  ' .`/,/!(=)Zm.");
player.location:announce_all("               .._,,._..  ,-`- `,\ ` -` -`\\7//WW.");
player.location:announce_all("          ,v=~/.-,-\- -!|V-s.)iT-|s|\-.'   `///mK%.");
player.location:announce_all("        v!`i!-.e]-g`bT/i(/[=.Z/m)K(YNYi..   /-]i44M.");
player.location:announce_all("      v`/,`|v]-DvLcfZ/eV/iDLN\D/ZK@%8W[Z..   `/d!Z8m");
player.location:announce_all("     //,c\(2(X/NYNY8]ZZ/bZd\()/\7WY%WKKW)   -'|(][%4.");
player.location:announce_all("   ,\\i\c(e)WX@WKKZKDKWMZ8(b5/ZK8]Z7%ffVM,   -.Y!bNMi");
player.location:announce_all("   /-iit5N)KWG%%8%%%%W8%ZWM(8YZvD)XN(@.  [   \]!/GXW[");
player.location:announce_all("  / ))G8\NMN%W%%%%%%%%%%8KK@WZKYK*ZG5KMi,-   vi[NZGM[");
player.location:announce_all(" i\!(44Y8K%8%%%**~YZYZ@%%%%%4KWZ/PKN)ZDZ7   c=//WZK%!");
player.location:announce_all(",\v\YtMZW8W%%f`,`.t/bNZZK%%W%%ZXb*K(K5DZ   -c\\/KM48");
player.location:announce_all("-|c5PbM4DDW%f  v./c\[tMY8W%PMW%D@KW)Gbf   -/(=ZZKM8[");
player.location:announce_all("2(N8YXWK85@K   -'c|K4/KKK%@  V%@@WD8e~  .//ct)8ZK%8`");
player.location:announce_all("=)b%]Nd)@KM[  !'\cG!iWYK%%|   !M@KZf    -c\))ZDKW%`");
player.location:announce_all("YYKWZGNM4/Pb  '-VscP4]b@W%     'Mf`   -L\///KM(%W!");
player.location:announce_all("!KKW4ZK/W7)Z. '/cttbY)DKW%     -`  .',\v)K(5KW%%f");
player.location:announce_all("'W)KWKZZg)Z2/,!/L(-DYYb54%  ,,`, -\-/v(((KK5WW%f");
player.location:announce_all(" \M4NDDKZZ(e!/\7vNTtZd)8\Mi!\-,-/i-v((tKNGN%W%%");
player.location:announce_all(" 'M8M88(Zd))///((|D\tDY\\KK-`/-i(=)KtNNN@W%%%@%[");
player.location:announce_all("  !8%@KW5KKN4///s(\Pd!ROBY8/=2(/4ZdzKD%K%%%M8@%%");
player.location:announce_all("   '%%%W%dGNtPK(c\/2\[Z(ttNYZ2NZW8W8K%%%%YKM%M%%.");
player.location:announce_all("     *%%W%GW5@/%!e]_tZdY()v)ZXMZW%W%%%*5Y]K%ZK%8[");
player.location:announce_all("      '*%%%%8%8WK\)[/ZmZ/Zi]!/M%%%%@f\ \Y/NNMK%%!");
player.location:announce_all("        'VM%%%%W%WN5Z/Gt5/b)((cV@f`  - |cZbMKW%%|");
player.location:announce_all("           'V*M%%%WZ/ZG\t5((+)L'-,,/  -)X(NWW%%");
player.location:announce_all("                `~`MZ/DZGNZG5(((\,    ,t\\Z)KW%@");
player.location:announce_all("                   'M8K%8GN8\5(5///]i!v\K)85W%%f");
player.location:announce_all("                     YWWKKKKWZ8G54X/GGMeK@WM8%@");
player.location:announce_all("                      !M8%8%48WG@KWYbW%WWW%%%@");
player.location:announce_all("                        VM%WKWK%8K%%8WWWW%%%@`");
player.location:announce_all("                          ~*%%%%%%W%%%%%%%@~");
player.location:announce_all("                             ~*MM%%%%%%@f`");
player.location:announce_all("                                 '''''");
.

@verb "ASCII Art Feature":asciispi*ral any any any rxd
@program "ASCII Art Feature":asciispi*ral
"A spiral";
player.location:announce_all("             __,aaPPPPPPPPaa,__");
player.location:announce_all("         ,adP\"\"\"'          `\"\"Yb,_");
player.location:announce_all("      ,adP'                     `\"Yb,");
player.location:announce_all("    ,dP'     ,aadPP\"\"\"\"\"YYba,_     `\"Y,");
player.location:announce_all("   ,P'    ,aP\"'            `\"\"Ya,     \"Y,");
player.location:announce_all("  ,P'    aP'     _________     `\"Ya    `Yb,");
player.location:announce_all(" ,P'    d\"    ,adP\"\"\"\"\"\"\"\"Yba,    `Y,    \"Y,");
player.location:announce_all(",d'   ,d'   ,dP\"            `Yb,   `Y,    `Y,");
player.location:announce_all("d'   ,d'   ,d'    ,dP\"\"Yb,    `Y,   `Y,    `b");
player.location:announce_all("8    d'    d'   ,d\"      \"b,   `Y,   `8,    Y,");
player.location:announce_all("8    8     8    d'    _   `Y,   `8    `8    `b");
player.location:announce_all("8    8     8    8     8    `8    8     8     8");
player.location:announce_all("8    Y,    Y,   `b, ,aP     P    8    ,P     8");
player.location:announce_all("I,   `Y,   `Ya    \"\"\"\"     d'   ,P    d\"    ,P");
player.location:announce_all("`Y,   `8,    `Ya         ,8\"   ,P'   ,P'    d'");
player.location:announce_all(" `Y,   `Ya,    `Ya,,__,,d\"'   ,P'   ,P\"    ,P");
player.location:announce_all("  `Y,    `Ya,     `\"\"\"\"'     ,P'   ,d\"    ,P'");
player.location:announce_all("   `Yb,    `\"Ya,_          ,d\"    ,P'    ,P'");
player.location:announce_all("     `Yb,      \"\"YbaaaaaadP\"     ,P'    ,P'");
player.location:announce_all("       `Yba,                   ,d'    ,dP'");
player.location:announce_all("          `\"Yba,__       __,adP\"     dP\"");
player.location:announce_all("              `\"\"\"\"\"\"\"\"\"\"\"\"\"'");
.

@verb "ASCII Art Feature":asciitri*angle any any any rxd
@program "ASCII Art Feature":asciitri*angle
"A penrose tirangle";
player.location:announce_all("                 ______");
player.location:announce_all("                /     /\\");
player.location:announce_all("               /     /##\\");
player.location:announce_all("              /     /####\\");
player.location:announce_all("             /     /######\\");
player.location:announce_all("            /     /########\\");
player.location:announce_all("           /     /##########\\");
player.location:announce_all("          /     /#####/\\#####\\");
player.location:announce_all("         /     /#####/++\\#####\\");
player.location:announce_all("        /     /#####/++++\\#####\\");
player.location:announce_all("       /     /#####/\\+++++\\#####\\");
player.location:announce_all("      /     /#####/  \\+++++\\#####\\");
player.location:announce_all("     /     /#####/    \\+++++\\#####\\");
player.location:announce_all("    /     /#####/      \\+++++\\#####\\");
player.location:announce_all("   /     /#####/        \\+++++\\#####\\");
player.location:announce_all("  /     /#####/__________\\+++++\\#####\\");
player.location:announce_all(" /                        \\+++++\\#####\\");
player.location:announce_all("/__________________________\\+++++\\####/");
player.location:announce_all("\\+++++++++++++++++++++++++++++++++\\##/");
player.location:announce_all(" \\+++++++++++++++++++++++++++++++++\\/");
player.location:announce_all("  ``````````````````````````````````");
.

;$string_utils:match_object("ASCII ART Feature", me):set_feature_verbs({"asciiheart", "asciiknot", "asciispiral", "asciitriangle"})
