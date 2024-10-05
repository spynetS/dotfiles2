;; Load the custom C3 mode
(load (expand-file-name "c3-mode.el" doom-user-dir))

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq display-line-numbers-type 'relative)

(doom/set-frame-opacity 96)
(set-frame-parameter (selected-frame) 'alpha '( 88 90))
(add-to-list 'default-frame-alist '(alpha . 90))

(setq-default indent-tabs-mode t)
(setq-default tab-width 4) ; Assuming you want your tabs to be four spaces wide
(defvaralias 'c-basic-offset 'tab-width)

(setq doom-font (font-spec :family "Iosevka" :size 16 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 13 :weight 'semi-light))

(setq doom-theme 'gruber-darker)
(nyan-mode)

  (blink-cursor-mode 1)
  (beacon-mode 1)

(use-package! doom-modeline
  :config
  (setq doom-modeline-height 25) ; Adjust height if necessary
  (setq doom-modeline-format
        '((:eval
           (doom-modeline-segment--workspace-name))
          " "
          (:eval
           (doom-modeline-segment--buffer-info))
          " "
          (:eval
           (doom-modeline-segment--major-mode))
          " "
          (:eval
           (doom-modeline-segment--process))
          " "
          (:eval
           (doom-modeline-segment--flycheck))
          " "
          (:eval
           (doom-modeline-segment--media-info))
          " "
          (:eval
           (doom-modeline-segment--misc-info))
          " "
          ;; Add clock segment
          (:eval
           (propertize (format-time-string "%H:%M") 'face 'doom-modeline-info))
          " "
          (:eval
           (doom-modeline-segment--buffer-position))
          " "
          (:eval
           (doom-modeline-segment--hud))
          " "
          (:eval
           (doom-modeline-segment--debug))
          " "
          (:eval
           (doom-modeline-segment--misc-info))
          ))
)

(use-package prettier
  :hook ((typescript-mode . prettier-mode)
         (js-mode . prettier-mode)
         (json-mode . prettier-mode)
         (yaml-mode . prettier-mode)
         (ruby-mode . prettier-mode)))

(setq org-hide-emphasis-markers t)

;; (use-package org-bullets
;;   :config
;;   (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
;; let* ((variable-tuple
;;       (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
;;             ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
;;             ((x-list-fonts "Verdana")         '(:font "Verdana"))
;;             ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
;;             (nil (warn "Cannot find a suitable Sans Serif Font. Please install Source Sans Pro or another listed font."))))
;;      (base-font-color     (face-foreground 'default nil 'default))
;;      (headline           `(:inherit default :weight bold :foreground ,base-font-color)))
;;
;;  (custom-theme-set-faces
;;   'user
;;   `(org-level-8 ((t (,@headline ,@variable-tuple))))
;;   `(org-level-7 ((t (,@headline ,@variable-tuple))))
;;   `(org-level-6 ((t (,@headline ,@variable-tuple))))
;;   `(org-level-5 ((t (,@headline ,@variable-tuple))))
;;   `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
;;   `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
;;   `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
;;   `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))
;;   `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))

(setq org-directory "~/org/")
(add-to-list 'load-path ".config/doom/emacs-libvterm")

(remove-hook 'doom-first-input-hook #'evil-snipe-mode)
;; toggle it off
;; (evil-snipe-mode)

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

(defun my/split-window-right-and-locate ()
  "Create a vertical split and open locate."
  (interactive)
  (+evil/window-vsplit-and-follow)
  (call-interactively 'find-file))

;; Bind the custom function to 'SPC s v'
(map! :leader
      :desc "Vertical split and locate"
      "s v" #'my/split-window-right-and-locate)

(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file
  )

(evil-define-key 'normal dired-mode-map
  (kbd ".") 'dired-hide-dotfiles-mode
  )

        (map! "S-<iso-lefttab>" #'+vertico/switch-workspace-buffer)

(map! "M-s RET" #'spawn-term-down)
(map! "M-t RET" #'spawn-term-tab)
(map! "M-RET" #'eshell)

(map! "C-c C-c" #'git-com)
(map! "C-c t" #'tab-close)
(map! "M-f" #'my-toggle-maximize-buffer)
(map! "M-e" #'dired-jump)
(map! "M-E" #'dired-jump-other-window)
(map! "SPC->" (lambda () (interactive) (dired "~/")))

(map! "M-h" #'windmove-left
      "M-k" #'windmove-up
      "M-l" #'windmove-right
      "M-j" #'windmove-down)

(with-eval-after-load 'treemacs
  (define-key treemacs-mode-map (kbd "M-h") nil)
  (def  ine-key treemacs-mode-map (kbd "M-l") nil)
  (define-key treemacs-mode-map (kbd "M-k") nil)
  (define-key treemacs-mode-map (kbd "M-j") nil))

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
