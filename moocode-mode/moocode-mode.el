;;; moocode-mode.el - Major mode for editing MOO code files
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

;;; Installation
;;
;; To install, add this file to your Emacs load path.
;; You can then load is' using M-x moocode-mode
;; Alternatively you can have Emacs load it automatically for files with
;; a .moo extension by adding the following to your .emacs file:
;; 
;;    (require 'moocode-mode)
;;    (add-to-list 'auto-mode-alist '("\\.moo$" . moocode-mode))

;;; TODO:
;;
;; comments
;; strings as object descriptors in declarations

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Customization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defcustom moocode-indent 2
  "How much to indent each block. Defaults to LambdaMOO's formatting (2)"
  :type '(integer)
  :group 'moocode-mode)

(defcustom moocode-tab-indent t
  "*Non-nil means TAB in MOO code mode calls `moocode-indent-line'"
  :type 'boolean
  :group 'python-mode)

(defcustom moocode-mode-hook nil
  "Hook run when entering MOO code mode"
  :type 'hook
  :group 'moocode-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Syntax highlighting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst moocode-font-lock-keywords
  '(;; @commands: @create @edit etc, although see below for @verb and @prop
    ("^\\s-*\\<@\\w+\\>"
     . font-lock-warning-face)
    ;; Types
    ("\\<\\(ERR\\|FLOAT\\|INT\\|LIST\\|NUM\\|OBJ\\|STR\\)\\>"
     . font-lock-constant-face)
    ;; Keywords
    ("\\<\\(?:break\\|continue\\|e\\(?:lse\\(?:if\\)?\\|nd\\(?:fork?\\|if\\|while\\)\\)\\|fork?\\|if\\|while\\)\\>"
     . font-lock-keyword-face)
    ;; Verb declarations
    ("@verb\\s-+\\(\\w+:\\w+\\)\\(.*\\)"
     ;; the verb name
     (1 font-lock-function-name-face)
     ;; The verb spec and permissions
     (2 font-lock-constant-face))
    ;; Property declarations
    ("@\\(prop\\|property\\)\\s-+\\(\\w+\\.\\w+\\)\\(.+\\s-+\\([rwc]+\\)\\)?"
     ;; The property name
     (2 font-lock-variable-name-face)
     ;; The property permission flags
     (4 font-lock-constant-face))
    ;; Automatically provided variables
    ;; .? to correctly handle this.(verb)
    ;; Only that doesn't work :-/
    ("\\<\\(args\\|argstr\\|caller\.?\\|dobj\.?\\|dobjstr\\|iobj\.?\\|iobjstr\\|player\.?\\|prepstr\\|this\\.?\\|verb\\)\\>"
     . font-lock-variable-name-face)
    ;; Built-in functions
    ("\\<\\(?:a\\(?:bs\\|cos\\|dd_\\(?:property\\|verb\\)\\|\\(?:si\\|ta\\)n\\)\\|b\\(?:inary_hash\\|oot_player\\|uffered_output_length\\)\\|c\\(?:all\\(?:_function\\|er\\(?:\\(?:_perm\\)?s\\)\\)\\|eil\\|h\\(?:ildren\\|parent\\)\\|lear_property\\|o\\(?:nnect\\(?:ed_\\(?:\\(?:player\\|second\\)s\\)\\|ion_\\(?:name\\|options?\\)\\)\\|sh?\\)\\|r\\(?:eate\\|ypt\\)\\|time\\)\\|d\\(?:b_disk_size\\|e\\(?:code_binary\\|lete_\\(?:property\\|verb\\)\\)\\|\\(?:isassembl\\|ump_databas\\)e\\)\\|e\\(?:ncode_binary\\|qual\\|val\\|xp\\)\\|f\\(?:l\\(?:o\\(?:\\(?:atst\\|o\\)r\\)\\|ush_input\\)\\|orce_input\\|unction_info\\)\\|i\\(?:dle_seconds\\|ndex\\|s_\\(?:clear_property\\|\\(?:memb\\|play\\)er\\)\\)\\|kill_task\\|l\\(?:ength\\|ist\\(?:append\\|delete\\|en\\(?:ers\\)?\\|\\(?:inser\\|se\\)t\\)\\|og\\(?:10\\)?\\)\\|m\\(?:a\\(?:tch\\|x\\(?:_object\\)?\\)\\|emory_usage\\|in\\|ove\\)\\|notify\\|o\\(?:bject_bytes\\|pen_network_connection\\|utput_delimiters\\)\\|p\\(?:a\\(?:rent\\|ss\\)\\|layers\\|ropert\\(?:ies\\|y_info\\)\\)\\|queue\\(?:_info\\|d_tasks\\)\\|r\\(?:a\\(?:ise\\|ndom\\)\\|e\\(?:ad\\|cycle\\|number\\|s\\(?:et_max_object\\|ume\\)\\)\\|index\\|match\\)\\|s\\(?:e\\(?:conds_left\\|rver_\\(?:log\\|version\\)\\|t\\(?:_\\(?:connection_option\\|p\\(?:layer_flag\\|roperty_info\\)\\|task_perms\\|verb_\\(?:args\\|code\\|info\\)\\)\\|add\\|remove\\)\\)\\|hutdown\\|inh?\\|qrt\\|tr\\(?:cmp\\|ing_hash\\|sub\\)\\|u\\(?:bstitute\\|spend\\)\\)\\|t\\(?:a\\(?:nh?\\|sk_\\(?:id\\|stack\\)\\)\\|i\\(?:cks_left\\|me\\)\\|o\\(?:float\\|int\\|literal\\|num\\|obj\\|str\\)\\|runc\\|ypeof\\)\\|unlisten\\|v\\(?:al\\(?:id\\|ue_\\(?:bytes\\|hash\\)\\)\\|erb\\(?:_\\(?:args\\|code\\|info\\)\\|s\\)\\)\\)\\>"
     . font-lock-builtin-face))
  "Highlighting for MOO code mode")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Indentation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun moocode-indent-incp ()
  (looking-at "\\s-*\\(?:else\\(?:if\\s-*\\)?\\|for\\(?:k?\\s-*\\)\\|if\\s-*\\|while\\s-*(\\)"))

(defun moocode-indent-decp ()
  (looking-at "\\s-*\\(?:e\\(?:lse\\(?:if\\)?\\|nd\\(?:fork?\\|if\\|while\\)\\)\\)"))

(defun moocode-skip-blank-lines ()
  (while (and (not (bobp))
	      (looking-at "^\\s-*$"))
    (forward-line -1)))

(defun moocode-indent-current-line ()
  (beginning-of-line)
  (delete-horizontal-space)
   (let ((indent 0))
     (if (moocode-indent-decp)
	 (decf indent moocode-indent))
     (save-excursion
       (if (not (eq (forward-line -1) -1))
	   (progn
	     (moocode-skip-blank-lines)
	     (back-to-indentation)
	     (if (moocode-indent-incp)
		 (incf indent moocode-indent))
	     (incf indent (current-indentation)))
	 ;; Otherwise
	 (setf indent 0)))
     (indent-to indent)))

(defun moocode-indent-line ()
  "Indent the current line as MOO code"
  (interactive)
  (if moocode-tab-indent
      (moocode-indent-current-line)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Define the mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Here so we can customize the variables it defines (e.g. the keymap)

;;;###autoload
(define-derived-mode moocode-mode fundamental-mode "MOO"
  "Major mode for editing LambdaMOO programming language files"
  :syntax-table moocode-mode-syntax-table
  :group 'moocode-mode
  (set (make-local-variable 'font-lock-defaults) '(moocode-font-lock-keywords))
  ;;(set (make-local-variable 'indent-line-function) 'wpdl-indent-line)
    (setq comment-start "\"")
    (setq comment-end "\";")
    (run-mode-hooks))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Syntax table
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar moocode-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?_ "w" st)
    (modify-syntax-entry ?@ "w" st)
    (modify-syntax-entry ?$ "w" st)
    (modify-syntax-entry ?\[ "(]")
    (modify-syntax-entry ?\] ")[")
    st)
  "Syntax table for MOO code mode")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keymap
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar moocode-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-j" #'newline-and-indent)
    (define-key map (kbd "TAB") #'moocode-indent-line)
    map)
  "Keymap for MOO code major mode")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Provide the mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'moocode-mode)
