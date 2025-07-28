;; init.el - Minimal, clean Emacs configuration

;; Disable UI clutter
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(setq visible-bell t)

;; Disable auto-save and backup files
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)

;; Use UTF-8 encoding
(prefer-coding-system 'utf-8)

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Line numbers and column numbers
(global-display-line-numbers-mode 1)
(column-number-mode 1)

;; Better yes/no prompt
(fset 'yes-or-no-p 'y-or-n-p)

;; Show matching parentheses
(show-paren-mode 1)

;; Disable startup message
(setq initial-scratch-message "")
(setq inhibit-startup-message t)

;; Save command history
(savehist-mode 1)

;; Delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Package management setup (if needed)
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Load custom file separately (optional)
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
