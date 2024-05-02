;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq display-line-numbers-type 'relative)

(doom/set-frame-opacity 96)
(set-frame-parameter (selected-frame) 'alpha '( 88 80))
(add-to-list 'default-frame-alist '(alpha 88 80))

(setq doom-font (font-spec :family "Iosevka" :size 16 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 13 :weight 'semi-light))

(setq doom-theme 'doom-city-lights)

  (blink-cursor-mode 1)
  (beacon-mode 1)

(setq org-hide-emphasis-markers t)

;; (use-package org-bullets
;;   :config
;;   (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
(let* ((variable-tuple
        (cond ((x-list-fonts "ETBembo")         '(:font "ETBembo"))
              ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
              ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
              ((x-list-fonts "Verdana")         '(:font "Verdana"))
              ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
              (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
       (base-font-color     (face-foreground 'default nil 'default))
       (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

  (custom-theme-set-faces
   'user
   `(org-level-8 ((t (,@headline ,@variable-tuple))))
   `(org-level-7 ((t (,@headline ,@variable-tuple))))
   `(org-level-6 ((t (,@headline ,@variable-tuple))))
   `(org-level-5 ((t (,@headline ,@variable-tuple))))
   `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
   `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
   `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
   `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))
   `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))

(setq org-directory "~/org/")
(add-to-list 'load-path ".config/doom/emacs-libvterm")

(remove-hook 'doom-first-input-hook #'evil-snipe-mode)
;; toggle it off
(evil-snipe-mode)

(setq kill-whole-line t)

(defvar my-maximize-buffer-flag nil
  "Flag to track whether the buffer is maximized or not.")

(defun my-toggle-maximize-buffer ()
  "Toggle between maximizing the buffer and undoing the window configuration."
  (interactive)
  (if my-maximize-buffer-flag
      (progn
        (winner-undo)
        (setq my-maximize-buffer-flag nil))
    (progn
      (maximize-window)
      (setq my-maximize-buffer-flag t))))

(defun spawn-term-down()
  (interactive)
  (+evil/window-split-and-follow)
  (evil-window-set-height 10)
  (eshell)
  )

(defun spawn-term-tab()
  (interactive)
  (tab-new)
  (eshell)
  )

(defun open-in-browser()
  (interactive)
  (shell-command (concat "brave " buffer-file-name)))

(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file
  )

(evil-define-key 'normal dired-mode-map
  (kbd ".") 'dired-hide-dotfiles-mode
  )

(map! "M-s RET" #'spawn-term-down)
(map! "M-t RET" #'spawn-term-tab)
(map! "M-RET" #'eshell)

(map! "C-c C-c" #'git-com)
(map! "C-c t" #'tab-close)
(map! "M-f" #'my-toggle-maximize-buffer)
(map! "M-e" #'dired-jump)
(map! "M-E" #'dired-jump-other-window)

(map! "M-h" #'windmove-left
      "M-l" #'windmove-right
      "M-k" #'windmove-up
      "M-j" #'windmove-down)

(map! "M-H" #'+evil/window-move-left
      "M-L" #'+evil/window-move-right
      "M-K" #'+evil/window-move-up
      "M-J" #'+evil/window-move-down)

(map! "M-C-h" #'(lambda () (interactive) (evil-window-decrease-width  3))
      "M-C-l" #'(lambda () (interactive) (evil-window-increase-width  3))
      "M-C-j" #'(lambda () (interactive) (evil-window-decrease-height 2))
      "M-C-k" #'(lambda () (interactive) (evil-window-increase-height 2)))

(map! "M-c" #'calc)
(map! "M-C" #'full-calc)
