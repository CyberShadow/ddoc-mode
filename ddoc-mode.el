;;; ddoc-mode.el --- Major mode for DDoc files.

;; Version: 0.1.0
;; Author: Vladimir Panteleev
;; Url: https://github.com/CyberShadow/ddoc-mode
;; Keywords: languages
;; Package-Requires: ((emacs "24.3"))

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; A Major Emacs mode for editing DDoc (D documentation) files, as
;; accepted by D compilers.

;; More information about DDoc can be found here:
;; http://dlang.org/spec/ddoc.html

;;; Code:

(defgroup ddoc-mode nil
  "Major mode for editing DDoc files."
  :link '(url-link "http://dlang.org/spec/ddoc.html")
  :group 'languages)

;; (defface ddoc-mode-comment-face
;;   '((t :inherit font-lock-comment-face))
;;   "Font for comments."
;;   :group 'ddoc-mode)

(defface ddoc-mode-directive-face
  '((t :inherit font-lock-keyword-face))
  "Font for DDoc directives."
  :group 'ddoc-mode)

;; (defface ddoc-mode-keyword-face
;;   '((t :inherit font-lock-keyword-face))
;;   "Font for ddoc keywords."
;;   :group 'ddoc-mode)

;; (defface ddoc-mode-type-face
;;   '((t :inherit font-lock-type-face))
;;   "Font for ActionScript built-in types."
;;   :group 'ddoc-mode)

;; (defface ddoc-mode-mnemonic-face
;;   '((t :inherit font-lock-builtin-face))
;;   "Font for ActionScript Virtual Machine opcode mnemonics."
;;   :group 'ddoc-mode)

;; (defconst ddoc-mode-directive-keywords
;;   '("#call" "#get" "#include" "#mixin" "#privatens" "#set" "#unset"
;;     "#version"))

;; (defconst ddoc-mode-keyword-keywords
;;   '("body" "cinit" "class" "code" "const" "dispid" "end" "extends"
;;     "flag" "from" "function" "getter" "iinit" "implements"
;;     "initscopedepth" "instance" "item" "localcount" "majorversion"
;;     "maxscopedepth" "maxstack" "metadata" "method" "minorversion"
;;     "name" "null" "optional" "param" "paramname" "program"
;;     "protectedns" "refid" "returns" "script" "setter" "sinit"
;;     "slot" "slotid" "target" "to" "trait" "try" "type" "value"))

;; (defconst ddoc-mode-type-keywords
;;   '("Void" "Utf8" "Decimal" "Integer" "UInteger"
;;     "PrivateNamespace" "Double" "QName" "Namespace" "Multiname"
;;     "False" "True" "Null" "QNameA" "MultinameA" "RTQName" "RTQNameA"
;;     "RTQNameL" "RTQNameLA" "Namespace_Set" "PackageNamespace"
;;     "PackageInternalNs" "ProtectedNamespace" "ExplicitNamespace"
;;     "StaticProtectedNs" "MultinameL" "MultinameLA" "TypeName"))

;; (defconst ddoc-mode-mnemonic-keywords
;;   '("bkpt" "nop" "throw" "getsuper" "setsuper" "dxns" "dxnslate"
;;     "kill" "label" "ifnlt" "ifnle" "ifngt" "ifnge" "jump" "iftrue"
;;     "iffalse" "ifeq" "ifne" "iflt" "ifle" "ifgt" "ifge"
;;     "ifstricteq" "ifstrictne" "lookupswitch" "pushwith" "popscope"
;;     "nextname" "hasnext" "pushnull" "pushundefined"
;;     "pushuninitialized" "nextvalue" "pushbyte" "pushshort"
;;     "pushtrue" "pushfalse" "pushnan" "pop" "dup" "swap"
;;     "pushstring" "pushint" "pushuint" "pushdouble" "pushscope"
;;     "pushnamespace" "hasnext2" "pushdecimal" "pushdnan" "li8"
;;     "li16" "li32" "lf32" "lf64" "si8" "si16" "si32" "sf32" "sf64"
;;     "newfunction" "call" "construct" "callmethod" "callstatic"
;;     "callsuper" "callproperty" "returnvoid" "returnvalue"
;;     "constructsuper" "constructprop" "callsuperid" "callproplex"
;;     "callinterface" "callsupervoid" "callpropvoid" "sxi1" "sxi8"
;;     "sxi16" "applytype" "newobject" "newarray" "newactivation"
;;     "newclass" "getdescendants" "newcatch" "deldescendants"
;;     "findpropstrict" "findproperty" "finddef" "getlex"
;;     "setproperty" "getlocal" "setlocal" "getglobalscope"
;;     "getscopeobject" "getproperty" "getpropertylate" "initproperty"
;;     "setpropertylate" "deleteproperty" "deletepropertylate"
;;     "getslot" "setslot" "getglobalslot" "setglobalslot" "convert_s"
;;     "esc_xelem" "esc_xattr" "convert_i" "convert_u" "convert_d"
;;     "convert_b" "convert_o" "checkfilter" "convert_m" "convert_m_p"
;;     "coerce" "coerce_b" "coerce_a" "coerce_i" "coerce_d" "coerce_s"
;;     "astype" "astypelate" "coerce_u" "coerce_o" "negate_p" "negate"
;;     "increment" "inclocal" "decrement" "declocal" "typeof" "not"
;;     "bitnot" "concat" "add_d" "increment_p" "inclocal_p"
;;     "decrement_p" "declocal_p" "add" "subtract" "multiply" "divide"
;;     "modulo" "lshift" "rshift" "urshift" "bitand" "bitor" "bitxor"
;;     "equals" "strictequals" "lessthan" "lessequals" "greaterthan"
;;     "greaterequals" "instanceof" "istype" "istypelate" "in" "add_p"
;;     "subtract_p" "multiply_p" "divide_p" "modulo_p" "increment_i"
;;     "decrement_i" "inclocal_i" "declocal_i" "negate_i" "add_i"
;;     "subtract_i" "multiply_i" "getlocal0" "getlocal1" "getlocal2"
;;     "getlocal3" "setlocal0" "setlocal1" "setlocal2" "setlocal3"
;;     "debug" "debugline" "debugfile" "bkptline" "timestamp"))

(defvar ddoc-mode-font-lock-keywords)
(setq ddoc-mode-font-lock-keywords
      `(
	;; Comments
	;; (";.*$" . 'ddoc-mode-comment-face)

	;; Keywords
	;; (,(regexp-opt ddoc-mode-directive-keywords) . 'ddoc-mode-directive-face)
	;; (,(regexp-opt ddoc-mode-keyword-keywords) . 'ddoc-mode-keyword-face)
	;; (,(regexp-opt ddoc-mode-type-keywords) . 'ddoc-mode-type-face)
	;; (,(regexp-opt ddoc-mode-mnemonic-keywords) . 'ddoc-mode-mnemonic-face)

	("\\$(\\([A-Z0-9_]+\\>\\)"
	 (1 'ddoc-mode-directive-face)
	 )
	
	))

;;;###autoload
(define-derived-mode ddoc-mode prog-mode "ddoc"
  "Major mode for editing ActionScript assembly files."

  :group 'ddoc-mode

  ;; Settings
  ;; (setq-local imenu-generic-expression
  ;;             '(("refid" "\\<refid\\> \"\\(.*\\)\"$" 1)))

  ;; Comments
  ;; (setq-local comment-start "; ")
  ;; (setq-local comment-end   "")

  ;; Syntax
  (setq-local font-lock-defaults '(ddoc-mode-font-lock-keywords
                                   nil nil nil nil)))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.dd\\'" . ddoc-mode))

(provide 'ddoc-mode)
;;; ddoc-mode.el ends here
