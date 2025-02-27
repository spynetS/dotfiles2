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

(setq fancy-splash-image "~/.config/doom/dashboard.jpg")

(setq treesit-language-source-alist
  '((c3 "https://github.com/c3lang/tree-sitter-c3")))

(add-to-list 'load-path "~/.config/doom/c3-ts-mode")
(require 'c3-ts-mode)

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
(with-eval-after-load 'org (global-org-modern-mode))

(setq org-directory "~/org/")
(setq org-agenda-files
      (append (directory-files-recursively "~/org" "\\.org$")
              (directory-files-recursively "~/Nextcloud/skola" "\\.org$")))


(add-to-list 'load-path ".config/doom/emacs-libvterm")
(require 'vterm)

(setq org-publish-project-alist
      '(("org roam pdf"
         :base-directory "~/org/roam"
         :publishing-function org-latex-publish-to-pdf
         :publishing-directory "~/Nextcloud/roam-pdf"
         :section-numbers nil
         :with-toc nil)

	("digitalteknik"
	 :base-directory "~/Nextcloud/skola/digitalteknik"
         :publishing-function org-html-publish-to-html
         :publishing-directory "~/Nextcloud/skola/published/digitalteknik"
         :section-numbers nil
         :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"https://gongzhitaao.org/orgcss/org.css\"/>"

	 )
))

(setq org-format-latex-options '(:scale 2.25))

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

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c n w") 'mc/mark-next-like-this-word)

(map! "C-<tab>" #'+vertico/switch-workspace-buffer)
(map! "M-s RET" #'spawn-term-down)
(map! "M-t RET" #'spawn-term-tab)

(map! "C-c t" #'tab-close)

;; (map! "M-H" #'windmove-left
;;       "M-L" #'windmove-right
;;       "M-K" #'windmove-up
;;       "M-J" #'windmove-down)

(map! "M-c" #'calc)
(map! "M-C" #'full-calc)
