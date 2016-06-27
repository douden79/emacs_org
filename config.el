
(use-package monokai-theme
:ensure t
:config
(setq monokai-use-variable-pitch nil))

(use-package darkokai-theme
:ensure t
:config (load-theme 'darkokai t)
(setq darkokai-mode-line-padding 1))

(use-package hlinum
:ensure t
:config
(global-linum-mode t)
(defun linum-update-window-scale-fix (win)
"fix linum for scaled text"
(set-window-margins win
(ceiling (* (if (boundp 'text-scale-mode-step)
(expt text-scale-mode-step
text-scale-mode-amount) 1)
(if (car (window-margins))
(car (window-margins)) 1)))))
(advice-add #'linum-update-window :after #'linum-update-window-scale-fix))

(use-package linum
:ensure t
:config
(global-hl-line-mode +1)
(setq linum-format "%-4d"))

(set-cursor-color "SkyBlue2")

(use-package highlight-symbol
:ensure t
:config
(global-set-key (kbd "<f3>") 'highlight-symbol-at-point)
(global-set-key (kbd "<f4>") 'highlight-symbol-remove-all))

(use-package tabbar-ruler
:ensure t
:init (tabbar-mode 1)
(setq tabbar-buffer-groups-function nil)

;; dolist button
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
               (set btn (cons (cons "" nil)
                             (cons "" nil))))

;; separator
(setq tabbar-separator '(2.2))

;; tabbar attribute color and ui
(set-face-attribute
 'tabbar-default nil
 :family "Envy Code R VS"
 :background "#34495E"
 :foreground "#EEEEEE"
 :height 0.95
 )
(set-face-attribute
 'tabbar-unselected nil
 :background "#34495E"
 :foreground "#EEEEEE"
 :box nil
)
(set-face-attribute
 'tabbar-modified nil
 :background "#E67E22"
 :foreground "#EEEEEE"
 :box nil
)
(set-face-attribute
 'tabbar-selected nil
 :background "#E74C3C"
 :foreground "#EEEEEE"
 :box nil)
(set-face-attribute
 'tabbar-button nil
 :box nil)
(set-face-attribute
 'tabbar-separator nil
 :height 1.5)

;; tabbar display buffers-menu-buffer-name-length
(defvar tabbar-displayed-buffers
  '("*scratch*" "*Messages*" "*Backtrace*" "*Colors*" "*Faces*" "*vc-")
  "*Regexps matches buffer names always included tabs.")

;; tabbar displayed buffers
(defvar tabbar-displayed-buffers
  '("*scratch*" "*Messages*" "*Backtrace*" "*Colors*" "*Faces*" "*vc-")
  "*Regexps matches buffer names always included tabs.")

(defun tabbar-buffer-list ()
  "Return the list of buffers to show in tabs.
Exclude buffers whose name starts with a space or an asterisk.
The current buffer and buffers matches `tabbar-displayed-buffers'
are always included."
  (let* ((hides (list ?\  ?\*))
         (re (regexp-opt tabbar-displayed-buffers))
         (cur-buf (current-buffer))
         (tabs (delq nil
                     (mapcar (lambda (buf)
                               (let ((name (buffer-name buf)))
                                 (when (or (string-match re name)
                                           (not (memq (aref name 0) hides)))
                                   buf)))
                             (buffer-list)))))
    ;; Always include the current buffer.
    (if (memq cur-buf tabs)
        tabs
      (cons cur-buf tabs))))

(setq tabbar-buffer-list-function 'tabbar-buffer-list)

;; Ctrl-Tab, Ctrl-Shift-Tab 
(dolist (func '(tabbar-mode tabbar-forward-tab tabbar-forward-group tabbar-backward-tab tabbar-backward-group))
  (autoload func "tabbar" "Tabs at the top of buffers and easy control-tab navigation"))
(defmacro defun-prefix-alt (name on-no-prefix on-prefix &optional do-always)
  `(defun ,name (arg)
     (interactive "P")
     ,do-always
     (if (equal nil arg)
         ,on-no-prefix
       ,on-prefix))))

(use-package powerline-evil
:ensure t
:init (setq powerline-evil-vim-theme t))

(use-package smex
:if (not (featurep 'helm-mode))
:ensure t
:bind ("M-x" . smex))

(use-package sublimity
:ensure t
:config
(setq sumlimity-scroll-weight 2
sublimity-scroll-drift-length 2)
(setq sublimity-attractive-centering-width 110))

(use-package auto-complete
:ensure t
:init (ac-config-default)
(global-auto-complete-mode t))

(use-package yasnippet
:ensure t
:defer t
:diminish yas-minor-mode
:config (setq yas-snippet-dirs (concat user-emacs-directory "snippets"))
(yas-global-mode)
(add-hook 'term-mode-hook (lambda() setq yas-dont-activate t)))

(use-package multiple-cursors
:ensure t
:bind (("C-l" . mc/edit-lines)
("C-;" . mc/mark-all-words-like-this)
("C->" . mc/mark-next-like-this)
("C-<" . mc/mark-previous-like-this)
("C-c C-<" . mc/mark-all-like-this)
("C-!" . mc/mark-next-symbol-like-this)
("s-d" . mc/mark-all-dwim)))

(use-package projectile
:ensure t
:diminish projectile-mode
:commands projectile-mode
:config
(progn
(projectile-global-mode t)
(setq projectile-enable-caching t)
(use-package ag
:command ag
:ensure t)))

(use-package function-args
:ensure t
:config (fa-config-default)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-mode))
(set-default 'semantic-case-fold t))

(use-package vlf
:ensure t
:config (custom-set-variables '(vlf-application 'dont-ask)))

(use-package dokuwiki-mode
:ensure t)

(use-package bm
:ensure t
:bind (("C-1" . bm-toggle)
("C-2" . bm-next)
("C-3" . bm-previous)))

(defun linux-c-mode()
"C mode with adjusted defaults for use with the Linux kernel."
(interactive)
(c-mode)
(c-set-style "K&R")
(setq tab-width 8)
(setq indent-tabs-mode t)
(setq c-basic-offset 8))
(add-hook 'c-mode-hook 'linux-c-mode)

(use-package dired+
:ensure t
:init (setq dired-dwim-target t))

(use-package company
:ensure t
:defer t
:init (add-hook 'after-init-hook 'global-company-mode))

(use-package org-bullets
:ensure t
:init (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package magit
:ensure t
:bind   (("C-c l" . magit-log-all)
        ("C-x c" . magit-commit)
        ("C-x p" . magit-pull)))

(use-package helm-config
  :init
  (custom-set-variables '(helm-command-prefix-key "C-;"))
  :config
  (bind-keys :map helm-command-map
             ("a" . helm-ag)
             ("o" . helm-occur)
             ("y" . yas-insert-snippet)))

(use-package helm
  :ensure t
  :init (progn
          (require 'helm-config)
          (setq helm-yank-symbol-first t
                helm-idle-delay 0.0
                helm-input-idle-delay 0.01
                helm-quick-update t
                helm-M-x-requires-pattern nil
                helm-ff-skip-boring-files t))
:bind (("C-x b" . helm-mini)
         ("C-f" . helm-semantic-or-imenu)
         ("C-x 8 <RET>" . helm-ucs)
         ("C-<f1>" . helm-apropos)))

(use-package helm-buffers
  :ensure helm
  :commands helm-buffers-list
  :config (setq helm-buffers-fuzzy-matching t))

(use-package helm-elisp
  :bind ("C-h a" . helm-apropos))

(use-package helm-git-grep
  :ensure t
  :commands helm-git-grep
  :config (setq helm-git-grep-candidate-number-limit nil))

(use-package helm-gtags
  :ensure t
  :commands (helm-gtags-mode helm-gtags-dwim)
  :diminish "HGt"
  :bind (("M-t" . helm-gtags-pop-stack)
        ("M-]" . helm-gtags-find-tags)
        ("M-[" . helm-gtags-find-rtags)
        ("M-." . helm-gtags-dwim)
        ("M-," . helm-gtags-tags-in-this-function)
        ("C-j" . helm-gtags-select)
        ("M-g M-p" . helm-gtags-parse-file)))

;; Enable helm-gtags-mode in code
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

(use-package helm-swoop
  :ensure t
  :bind (("C-c o" . helm-swoop)
         ("C-c O" . helm-multi-swoop)))

(use-package helm-descbinds
  :ensure t
  :bind (("C-h b" . helm-descbinds)
         ("C-h h" . helm-descbinds)))

(set-fontset-font "fontset-default" '(#x1100 . #xffdc)
                   '("Gulim" . "iso10646-1"))
(set-fontset-font "fontset-default" '(#xe0bc . #xf66e)
                   '("Gulim" . "iso10646-1"))

(setq face-font-rescale-alist
       '((".*hiragino.*" . 1.0)
         (".*Gulim.*" . 1.0)))
(set-language-environment "Korean")

(fset 'yes-or-no-p 'y-or-n-p)
