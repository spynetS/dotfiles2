(load (expand-file-name "c3-mode.el" doom-user-dir))

(setq treesit-language-source-alist
  '((c3 "https://github.com/c3lang/tree-sitter-c3")))


(defun find-home-file()
  (interactive)
  (consult-fd "~/")
  )

(defun insert-screenshot-path ()
  "Run the 'hyprshot -m region -o ~/Nextcloud/Photos/ScreenShots/ -f [date].png command asynchronously. and pastes the path as org link"
  (interactive)
  (let ((filename (format "%s.png" (format-time-string "%Y-%m-%d-%H-%M-%S"))))
    (let ((dir (expand-file-name "~/Nextcloud/Photos/ScreenShots/")))
	(start-process "hyprshot" "*hyprshot-process*" "hyprshot" "-m" "region" "-o" dir "-f" filename)
	(insert (format "[[file:%s%s]]" dir filename)))))

(defun edit-file-region ()
  "Print the content of the selected region to the minibuffer."
  (interactive)
  (if (use-region-p)
      (let ((region-content (buffer-substring-no-properties (region-beginning) (region-end))))
        (find-file region-content))
    (message "No region selected")))

(defun bold ()
  (interactive)
  (backward-word)
  (insert "*")
  (forward-word)
  (insert "*"))

(setq display-line-numbers-type 'relative)
(display-time)
(display-battery-mode)

(doom/set-frame-opacity 96)
(set-frame-parameter (selected-frame) 'alpha '( 88 90))
(add-to-list 'default-frame-alist '(alpha . 90))

(setq-default indent-tabs-mode t)
(setq-default tab-width 4) ; Assuming you want your tabs to be four spaces wide
(defvaralias 'c-basic-offset 'tab-width)

(setq doom-font (font-spec :family "Iosevka" :weight 'semibold :size 13 :width 'expanded)
      doom-variable-pitch-font (font-spec :family "Iosevka" :size 18))

(setq doom-theme 'gruber-darker)
(nyan-mode)

  (blink-cursor-mode 1)
  (beacon-mode 0)

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

(setq org-agenda-files (directory-files-recursively "~/org/roam" "\\.org$"))

(setq org-directory "~/org/")
(setq org-agenda-files (directory-files-recursively "~/org" "\\.org$"))

(add-to-list 'load-path ".config/doom/emacs-libvterm")
(require 'vterm)

(setq org-publish-project-alist
      '(("org roam"
         :base-directory "~/org/roam"
         :publishing-function org-html-publish-to-html
         :publishing-directory "~/Nextcloud/roam"
         :section-numbers nil
         :with-toc nil
         :html-head "<link rel=\"stylesheet\"
                    href=\"./mystyle.css\"
                    type=\"text/css\"/>")))

(setq org-publish-project-alist
      '(("org roam pdf"
         :base-directory "~/org/roam"
         :publishing-function org-latex-publish-to-pdf
         :publishing-directory "~/Nextcloud/roam-pdf"
         :section-numbers nil
         :with-toc nil)))

(setq org-format-latex-options '(:scale 2.25))

;; Somewhere in your .emacs file
(setq elfeed-feeds
      '("http://nullprogram.com/feed/"
	    "https://itsfoss.com/rss/"
        "https://planet.emacslife.com/atom.xml"))

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

(load-file "~/.config/mu4e/mu4e-config.el")

(add-to-list 'load-path "~/.config/mu4e")
(require 'mu4e-config)

(use-package mu4e-config
  :after mu4e
  :load-path "~/.config/mu4e")

(setq +mu4e-compose-org-msg-toggle-next t)

 (require 'org-msg)
 (setq  org-msg-greeting-fmt "\nHej%s,\n\n"
	org-msg-recipient-names '(("alfred@stensatter.se" . "Alfred"))
	org-msg-greeting-name-limit 3
	org-msg-convert-citation t
	org-msg-signature "

 Med vänliga hälsningar,

 #+begin_signature
 --
 *Alfred Roos*
 #+end_signature")
 (org-msg-mode)

(setq org-msg-style
      '((default . (:foreground "black" :background "#f9f9f9" :font-family "Arial"))
        (quote . (:foreground "gray" :slant italic))
        (bold . (:weight bold :foreground "darkgray"))
        (italic . (:slant italic :foreground "gray"))
        (underline . (:underline t))))

(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file
  )

(evil-define-key 'normal dired-mode-map
  (kbd ".") 'dired-hide-dotfiles-mode
  )

        ;; (map! "S-<iso-lefttab>" #'+vertico/switch-workspace-buffer)

(map! :n "C-SPC" #'consult-fd)


(map! "M-s RET" #'spawn-term-down)
(map! "M-t RET" #'spawn-term-tab)
(map! "M-RET" #'eshell)

(map! "C-c C-c" #'git-com)
(map! "C-c t" #'tab-close)
(map! "M-f" #'my-toggle-maximize-buffer)
(map! "M-e" #'dired-jump)
(map! "M-E" #'dired-jump-other-window)
;; (map! "SPC->" (lambda () (interactive) (dired "~/")))

(map! "M-h" #'windmove-left
      "M-k" #'windmove-up
      "M-l" #'windmove-right
      "M-j" #'windmove-down)

(with-eval-after-load 'treemacs
  (define-key treemacs-mode-map (kbd "M-h") nil)
  (define-key treemacs-mode-map (kbd "M-l") nil)
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
