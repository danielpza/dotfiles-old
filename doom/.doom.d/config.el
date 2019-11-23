;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(defun align-doom-map (b e)
  (interactive "r")
  (align-regexp b e "\\( *\\)\".*\"" 1 1 nil)
  (align-regexp b e "\" . *\"\\( *\\)\".*\"" 1 1 nil)
  (align-regexp b e "\\( *\\)#'" 1 1 nil)
  )

(defun remove-c-comments ()
  (interactive)
  (evil-ex "%s/\\/\\*.*\\*\\/")
  (evil-ex "%s/\\/\\/.*$")
  )


(defun npm-mode-run-test ()
  (interactive)
  (npm-mode--exec-process "npm run test"))

;; https://dougie.io/emacs/open-directory-in-terminal-app/
(defun open-terminal-in-workdir ()
  (interactive)
  (let ((workdir (if (projectile-project-root)
                     (projectile-project-root)
                   default-directory)))
    (call-process-shell-command
     (concat "( cd " workdir " && "(getenv "TERMINAL") ")") nil 0)))

(defun compile-ts-to-clipboard ()
  (interactive)
  (kill-new (shell-command-to-string (concat "tsc --outFile /dev/stdout '" buffer-file-name "'"))))

(map! :leader
      :desc "Comment"              ";"     #'evilnc-comment-operator
      :desc "Find file in project" "pf"    #'+ivy/projectile-find-file
      :desc "M-x"                  "SPC"   #'execute-extended-command
      :desc "Sort Lines"           "cl"    #'sort-lines
      :desc "Revert buffer"        "br"  #'revert-buffer
      :desc "Quickrun interactive" "cE"    #'quickrun-shell
      :desc "Next Error"           "en"    #'flycheck-next-error
      :desc "Previous Error"       "ep"    #'flycheck-previous-error
      :desc "Delete buffer"        "bd"    #'kill-this-buffer
      :desc "Format"               "j="    #'+format/region-or-buffer
      :desc "Go Back"              "jb"    #'dumb-jump-back
      :desc "Soft Wrap"            "tw"    #'visual-line-mode
      :desc "Hard Wrap"            "tW"    #'auto-fill-mode
      :desc "Fold in {"            "z"     #'fold-operator
      :desc "Compile ts to clipboard" "oj" #'compile-ts-to-clipboard
      :desc "Evil Quit"            "wd"    #'evil-quit
      :desc "Open Terminal"        "ot"    #'open-terminal-in-workdir
      )

(map! :localleader
      :map emacs-lisp-mode-map
      :desc "Align Doom Map"       "a"   #'align-doom-map
      )


(map! :map  tide-references-mode-map
      "C-j" #'tide-find-next-reference
      "C-k" #'tide-find-previous-reference
      )

(map! :localleader
      :map tide-mode-map
      :desc "Fix"                  "f"   #'tide-fix
      :desc "Fix"                  "rf"   #'tide-fix
      )

(add-to-list 'auto-mode-alist '("\\.js\\'"    . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'"    . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'"    . typescript-mode))
(add-to-list 'interpreter-mode-alist '("node" . typescript-mode))

(after! magit
  (setq magit-display-buffer-function #'magit-display-buffer-fullcolumn-most-v1))

(after! treemacs
  (setq doom-themes-treemacs-theme "doom-colors")
  (setq treemacs-follow-mode t))

(after! format
  (setq +format-on-save-enabled-modes '(not js2-mode typescript-mode emacs-lisp-mode)))

(set-eval-handler! 'typescript-mode
  '((:command     . "ts-node")
    (:exec        . "%c -T %s")
    (:description . "Run Typescript Script with ts-node -T")))

(map! :after npm-mode
      :localleader
      :map npm-mode-keymap
      :prefix "n"
      "t" #'npm-mode-run-test
      )

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-banner)

(evil-define-operator fold-operator (beg end type)
  "Evil operator: fold"
  :move-point nil
  (interactive "<R>")
  (bookmark-set "-fold-in-region")
  (narrow-to-region beg end)
  (call-interactively 'evil-close-folds)
  (call-interactively 'widen)
  (bookmark-jump "-fold-in-region"))

(custom-set-faces
 '(magit-branch-current ((t (:foreground "spring green")))))
