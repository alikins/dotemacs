; cheat sheet
; ctrl-space start a block
; ctrl-w kill
; alt-w copy
; ctrl-y paste/yank
;  alt-y cycle through yank ring
;
; ctrl-h b show all key commands
; alt-; comment-dwim (comment/uncomment)
; ctrl-tab dabrev/completion
; alt-g goto line
; alt-cursor move tabs
;
; git-blame-mode

; local path
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

(setq-default user-mail-address "alikins@redhat.com")

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default python-guess-indent t)
(setq-default py-indent-offset 4)

; load tabbar mode
(require 'tabbar)
(tabbar-mode)

; https://github.com/philjackson/magit
(require 'magit)

(require 'mwheel)


; anything http://www.emacswiki.org/cgi-bin/wiki/Anything
(require 'anything-config)

; c-x B to search buffers
; c-X c-F to do the interesting bits
; http://www.emacswiki.org/emacs/InteractivelyDoThings
(require 'ido)
(ido-mode t)

;http://www.emacswiki.org/emacs/DynamicAbbreviations
(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
(define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

; and set alt-left/right move though tags in current group
; and alt-up/down move though groups
(global-set-key [(meta right)]   'tabbar-forward-tab)
(global-set-key [(meta left)]   'tabbar-backward-tab)
(global-set-key [(meta up)]   'tabbar-forward-group)
(global-set-key [(meta down)]   'tabbar-backward-group)

; both of the below from emacs-fu
; y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

; make links clickable
(add-hook 'find-file-hooks 'goto-address-prog-mode)

; http://emacs-fu.blogspot.com/2011/05/toward-balanced-and-colorful-delimiters.html
(require 'rainbow-delimiters)
;(setq-default frame-background-mode 'dark)

; uh, yeah, put the scroll bars on the right like every
; other app in the universe
(set-scroll-bar-mode 'right)

; bind alt-g to goto-line
(global-set-key [(meta ?g)]    'goto-line)

(setq minibuffer-max-depth nil)

;; set the line numebr in the mode line
(setq line-number-mode t)
(setq column-number-mode t)


;; for font-lock (syntax highlighting
(setq font-lock-use-default-fonts nil)
(setq font-lock-use-default-colors t)
(require 'font-lock)

(require 'desktop)
;; save desktop:
(desktop-save-mode 1)

;; keeps track of window layours and lets you
;; cycle through them
(require 'winner)

;; show which function in the mode bar
;;(require 'which-function-mode)

;; use aspell for spelling
(setq ispell-program-name "aspell")

;; pymacs http://pymacs.progiciels-bpi.ca/pymacs.html#installation
;; why? to try to get rope/autocomplete better
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))

;; http://www.emacswiki.org/emacs/auto-complete.el
(require 'auto-complete)
(global-auto-complete-mode t)


(autoload 'rpm-spec-mode "rpm-spec-mode.el" "RPM spec mode." t)
(setq auto-mode-alist (append '(("\\.spec" . rpm-spec-mode))
                              auto-mode-alist))

; sets up rope, pyemacs, flymake with pycheckers, etc
; kind of a hodgepodge of:
; http://www.saltycrane.com/blog/2010/05/my-emacs-python-environment/
; http://hide1713.wordpress.com/2009/01/30/setup-perfect-python-environment-in-emacs/
; http://stackoverflow.com/questions/1259873/how-can-i-use-emacs-flymake-mode-for-python-with-pyflakes-and-pylint-checking-cod
; http://www.emacswiki.org/emacs/?action=browse;oldid=PythonMode;id=PythonProgrammingInEmacs
(require 'init_python)

(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)


; http://code.google.com/p/js2-mode
; use js2 mode for javascript/json
; js2 needs to be byte compile, see the module code
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))

;http://www.emacswiki.org/emacs/WhiteSpace
(require 'whitespace)
(autoload 'global-whitespace-mode           "whitespace" "Toggle whitespace visualization."        t)
(autoload 'global-whitespace-toggle-options "whitespace" "Toggle local `whitespace-mode' options." t)
;; turn on whitespace highlighintg
;;(setq global-whitespace-mode t)
(setq whitespace-style (quote (face tabs trailing space-before-tab newline empty space-after-tab )))

; use less name buffer names when we have multiple of the same fileanme
(require 'uniquify)

; make ctrl-z do the normal thing
(global-set-key (kbd "C-z") 'undo)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(ecb-source-path (quote (("/" "/") ("/home/adrian/src/candlepin" "candlepin") ("/home/adrian/src/candlepin" "candlepin"))))
 '(global-font-lock-mode t nil (font-lock))
 '(ispell-program-name "aspell")
 '(query-user-mail-address nil)
 '(show-paren-mode t nil (paren))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(vc-follow-symlinks nil))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:size "12pt" :foreground "grey90" :background "black" :bold t))))
 '(cscope-line-face ((((class color) (background light)) (:foreground "white"))))
 '(font-lock-builtin-face ((((class color) (background dark)) (:foreground "red"))))
 '(font-lock-comment-face ((t (:foreground "blue"))))
 '(font-lock-doc-face ((t (:inherit font-lock-string-face :foreground "green4"))))
 '(font-lock-doc-string-face ((((class color) (background light)) (:foreground "green4" :bold t))))
 '(font-lock-function-name-face ((((class color) (background light)) (:foreground "lightblue" :bold t))))
 '(font-lock-keyword-face ((t (:foreground "yellow"))))
 '(font-lock-preprocessor-face ((((class color) (background light)) (:foreground "blue3" :bold t))))
 '(font-lock-reference-face ((((class color) (background light)) (:foreground "red3" :bold t))))
 '(font-lock-string-face ((t (:foreground "green4"))))
 '(font-lock-type-face ((t (:foreground "steel blue"))))
 '(font-lock-variable-name-face ((((class color) (background light)) (:foreground "magenta4" :bold t))))
 '(font-lock-warning-face ((((class color) (background light)) (:foreground "Red" :bold t))))
 '(link ((((class color) (min-colors 88) (background dark)) (:foreground "deep sky blue" :underline t)))))
