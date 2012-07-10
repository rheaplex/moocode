;;; dev-moocode-mode.el - Code to generate regular expressions for moocode-mode
;;
;; Copyright (C) 2012 Rob Myers <rob@robmyers.org>
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Syntax highlighting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Types

(concat "\\<"
	(regexp-opt '("ERR" "FLOAT" "INT" "LIST" "NUM" "OBJ" "STR")) 
	"\\>")

;; keywords

(concat "^\\s-*\\("
	(regexp-opt '("break" "continue" "else" "elseif" "endif" "endfor"
		      "endfork" "endwhile" "for" "fork" "if" "return" "while"))
	;; FIXME: \\s-+.+; is for return without () .
	;;        return should be a separate case...
	"\\)\\s-*\\([.+]\\|(.+)\\|;\\|\\s-+.+;\\)?\\s-*$")

;; Variables
;; FIXME: handle this.(prop) properly (dot isn't colored at the moment)

(concat "\\<"
	(regexp-opt '("args" "argstr" "caller" "dobj" "dobjstr" "iobj"
		      "iobjstr" "player" "prepstr" "this" "verb"))
	"\\>")

;; Builtins

(concat "\\<\\(" 
	(regexp-opt '("abs" "acos" "add_property" "add_verb" "asin" "atan" "binary_hash" "boot_player" "buffered_output_length" "caller_perms" "callers" "call_function" "ceil" "children" "chparent" "clear_property" "connected_players" "connected_seconds" "connection_name" "connection_option" "connection_options" "cos" "cosh" "create" "crypt" "ctime" "db_disk_size" "decode_binary" "delete_property" "delete_verb" "disassemble" "dump_database" "encode_binary" "equal" "eval" "exp" "floatstr" "floor" "flush_input" "force_input" "function_info" "idle_seconds" "index" "is_clear_property" "is_member" "is_player" "kill_task" "length" "listappend" "listdelete" "listen" "listeners" "listinsert" "listset" "log" "log10" "match" "max" "max_object" "memory_usage" "min" "move" "notify" "object_bytes" "open_network_connection" "output_delimiters" "parent" "pass" "players" "properties" "property_info" "queued_tasks" "queue_info" "raise" "random" "read" "recycle" "renumber" "reset_max_object" "resume" "rindex" "rmatch" "seconds_left" "server_log" "server_version" "setadd" "set_connection_option" "set_player_flag" "set_property_info" "setremove" "set_task_perms" "set_verb_args" "set_verb_code" "set_verb_info" "shutdown" "sin" "sinh" "sqrt" "strcmp" "string_hash" "strsub" "substitute" "suspend" "tan" "tanh" "task_id" "task_stack" "ticks_left" "time" "tofloat" "toint" "toliteral" "tonum" "toobj" "tostr" "trunc" "typeof" "unlisten" "valid" "value_bytes" "value_hash" "verb_args" "verb_code" "verb_info" "verbs"))
	"\\)\\s-*(")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Indentation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Increment indent

;; regexp-opt requires plain strings, so we have to jump through some hoops
(concat "\\s-*" 
	;; Replace space with whitespace regexp
	(replace-regexp-in-string
	 " " "\\\\s-*"
	 ;; Rely just on space after all except for while
	 ;; otherwise this gets complex to create
	 (regexp-opt '("else" "elseif " "for " "fork " "if " "while ("))))

;; Decrement indent

(concat "\\s-*" (regexp-opt '("endif" "endfor" "endfork" "endwhile")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Semicolon checking
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Things that *don't* need semicolons after them
;; return does need a semicolon, so we use our own copy of the list

;; Start of the line, then alternatives
(concat "^\\("
	;; Blank lines
	"^\\s-*$\\|"
	;; @create, @addalias, @verb etc.
	"^\\s-*\\<@\\w+\\>\\|"
	;; .
	"^.$\\|"
	;; Evals
	"^\\s-*;\\|"
	;; Editor commands, just words on their own on a line
	"^\\w+$\\|"
	;; Return needs a semicolon, so don't include it in this copy
	"\\s-*\\<"
	(regexp-opt '("break" "continue" "else" "elseif" "endif" "endfor"
		      "endfork" "endwhile" "for" "fork" "if" "while"))
	"\\>"
	;; End of alternatives
	"\\)")

;; Things that should cause scanning to skip until "."

(concat "^\\s-*\\("
	;; Anything invoking the note editor
	(regexp-opt '("@answer" "@notedit" "@send"))
	;; Anything misusing edit to edit properties
	"\\|@edit\\s-+\\w+\\.\\w+"
	"\\)")
