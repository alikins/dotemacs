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
; alt-g goto lin
; alt-cursor move tabs
;
; http://www.emacswiki.org/emacs/Registers
;  ctrl-x r m (set register/booknark)
;  ctrl-x r b (jump to register/bookmar)
;  ctrl-x r w (set window config)
;  ctrl-x r j N (just to register)
;
;
; git-blame-mode
;
; python debugging
;   http://jones.ling.indiana.edu/wiki/Debug_Python_in_Emacs
;
; useful modes:
; follow-mode   (makes windows continue side-by-side)
; follow-delete-other-windows-and-split   (make current buffer followed onto full screen)
; whitespace-mode  (show's unneeded whitespace)
; linum-mode (shows linums in the "tray", also need for pycov)
; pycov2 mode (parse python .coverage files and show lines not covered)
; compile-mode (run's make, show's errors)
; find-grep (recursive grep, show's in compile style buffer)
; artist-mode (ascii art)
; ack-mode (show ack output, n/p for next/previous)
; cd (changes default dir for find/find-grep/compile/etc)
;
;; some of this from
;; https://twiki.cern.ch/twiki/bin/view/CDS/EmacsTips
;; http://www.emacswiki.com
;;
;;
;; setup
;;   Pymacs  http://pymacs.progiciels-bpi.ca/pymacs.html
;;   rope/ropemacs http://rope.sourceforge.net/ropemacs.html
;;
;; http://www.math.uh.edu/~bgb/emacs_keys.html

(require 'cl)


;local path
(add-to-list 'load-path "~/.emacs.d/site-lisp/")
;(add-to-list 'load-path "~/.emacs.d/site-lisp/icicles")

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))


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
;(require 'anything-config)

; c-x B to search buffers
; c-X c-F to do the interesting bits
; http://www.emacswiki.org/emacs/InteractivelyDoThings
(require 'ido)
(ido-mode t)
(setq ido-max-directory-size 100000)

;http://www.emacswiki.org/emacs/DynamicAbbreviations
(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
(define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

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

;; https://github.com/tlh/workgroups.el
;(require 'workgroups)
;(workgroups-mode 1)
;(wg-load "~/.emacs.d/workgroups")
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

; turn on spell checking in comments/strings for programming modes
; http://www.lrde.epita.fr/cgi-bin/twiki/view/Projects/EmacsTricks
(add-hook 'text-mode-hook 'turn-on-flyspell)
(add-hook 'python-mode-hook 'flyspell-prog-mode)
(add-hook          'c-mode-hook 'flyspell-prog-mode)
(add-hook         'sh-mode-hook 'flyspell-prog-mode)
(add-hook        'c++-mode-hook 'flyspell-prog-mode)
(add-hook       'ruby-mode-hook 'flyspell-prog-mode)
(add-hook      'cperl-mode-hook 'flyspell-prog-mode)
(add-hook     'python-mode-hook 'flyspell-prog-mode)
(add-hook   'autoconf-mode-hook 'flyspell-prog-mode)
(add-hook   'autotest-mode-hook 'flyspell-prog-mode)
(add-hook   'makefile-mode-hook 'flyspell-prog-mode)
(add-hook 'emacs-lisp-mode-hook 'flyspell-prog-mode)

;; flymake highlight for ruby
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; flymake highlighting for rpm specfiles based
;; on rpmlint
;;(require 'flymake-specfile)

; flymkae for java script using rhink and jslint
;;(require 'flymake-jslint)

; flyamke for bash
;(require 'flymake-shell)
;(add-hook 'sh-mode-hook 'flymake-shell-load)

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

;; http://www.emacswiki.org/cgi-bin/wiki/menu-bar+.el
(eval-after-load "menu-bar" '(require 'menu-bar+))

;; show test coverage for python
;;https://github.com/mattharrison/pycoverage.el/
(load-file "~/.emacs.d/site-lisp/pycov2.el")
(require 'linum)
(require 'pycov2)

;; ;; http://code.google.com/p/yasnippet/
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")
(yas/load-directory "~/.emacs.d/plugins/yasnippets-more")
(yas/load-directory "~/.emacs.d/plugins/yasnippets-local")

;;  http://nschum.de/src/emacs/full-ack/
(add-to-list 'load-path "/path/to/full-ack")
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

;; https://bitbucket.org/durin42/nosemacs
(require 'nose)

;;http://www.emacswiki.org/emacs/SrSpeedbar
;(require 'sr-speedbar)

;;https://chrome.google.com/webstore/detail/ljobjlafonikaiipfkggjbhkghgicgoh#
;;https://github.com/stsquad/emacs_chrome
 (if (and (daemonp) (locate-library "edit-server"))
     (progn
       (require 'edit-server)
       (edit-server-start)))

;http://www.damtp.cam.ac.uk/user/sje30/emacs/fm.el
; tries to automatically show buffers from compile output
(require 'fm)

; from http://www.mygooglest.com/fni/dot-emacs.html
; http://www.emacswiki.org/emacs/mic-paren.el
; shows completion of brackets in mode-line when off screen
(require 'mic-paren)
(paren-activate)

;http://www.emacswiki.org/emacs/RevertBuffer
(defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive) (revert-buffer t t))

; keybindings

; make F5 revet
(global-set-key [f5] 'revert-buffer-no-confirm)

; make F3 find-tag
(global-set-key [f3] 'find-tag)

; make ctrl-z do the normal thing
(global-set-key (kbd "C-z") 'undo)

; and set alt-left/right move though tags in current group
; and alt-up/down move though groups
(global-set-key [(meta right)]   'tabbar-forward-tab)
(global-set-key [(meta left)]   'tabbar-backward-tab)
(global-set-key [(meta up)]   'tabbar-forward-group)
(global-set-key [(meta down)]   'tabbar-backward-group)

; bind alt-g to goto-line
(global-set-key [(meta ?g)]    'goto-line)

; recent file list
(recentf-mode 1)

; turn off back and autosave files
(setq make-backup-files nil)
(setq auto-save-default nil)

; turn off the tool bar
(tool-bar-mode 0)

(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands) ;; This is your old M-x.
;;(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; http://www.emacswiki.org/cgi-bin/wiki/TabCompletion#toc2
;; https://github.com/haxney/smart-tab
;; tab completion stuff
(require 'smart-tab)
(global-smart-tab-mode 1)

(setq temporary-file-directory "~/.emacs.d/tmp/")

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(desktop-load-locked-desktop t)
 '(desktop-save t)
 '(ecb-source-path (quote (("/" "/") ("/home/adrian/src/candlepin" "candlepin") ("/home/adrian/src/candlepin" "candlepin"))))
 '(flymake-gui-warnings-enabled nil)
 '(flymake-run-in-place nil)
 '(flymake-number-of-errors-to-display nil)
 '(global-font-lock-mode t nil (font-lock))
 '(ispell-program-name "aspell")
 '(js2-highlight-level 3)
 '(js2-mirror-mode nil)
 '(js2-missing-semi-one-line-override t)
 '(js2-mode-escape-quotes nil)
 '(js2-mode-show-parse-errors t)
 '(js2-move-point-on-right-click nil)
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
