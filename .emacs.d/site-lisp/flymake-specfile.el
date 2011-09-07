(setq flymake-specfile-err-line-patterns
       (cons '(("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3))
            flymake-err-line-patterns))
(when (load "flymake" t)
  (defun flymake-specfile-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "rpmlint" (list local-file))))
  ;;      (list "pyflakes" (list local-file))))
  (set (make-local-variable 'flymake-err-line-patterns) flymake-specfile-err-line-patterns)
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.spec\\'" flymake-specfile-init)))
(add-hook 'find-file-hook 'flymake-find-file-hook)

(provide 'flymake-specfile)