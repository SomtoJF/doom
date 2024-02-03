;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Francis Somtochukwu"
      user-mail-address "somtofrancis5@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Iosevka" :size: 20 :weight 'normal)
   doom-variable-pitch-font (font-spec :family "Iosevka" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-outrun-electric)
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;;Install and use neotree icons
(use-package all-the-icons
  :ensure t)
;;
(use-package neotree
  :ensure t
  :init
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
;;
;;
;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
;;

(with-eval-after-load 'all-the-icons
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
;;
(message "graphics: " (display-graphic-p))

(when (require 'all-the-icons-dired nil 'noerror)
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(defun my/neotree-icons ()
  (setq-local all-the-icons-dired-monochrome nil)
  (setq-local neo-theme (if (display-graphic-p) 'icons 'arrow)))

(add-hook 'neotree-mode-hook 'my/neotree-icons)

;; Add project folders
(setq projectile-project-search-path '("~/Desktop/Code/JSTS"))
;;
;; Bottom of the start page text
(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Whereas disregard and contempt for human rights have resulted...")))
;;
;;
;;Window title

(setq frame-title-format
      '(""
        (:eval
         (if (s-contains-p org-roam-directory (or buffer-file-name ""))
             (replace-regexp-in-string
              ".*/[0-9]*-?" "☰ "
              (subst-char-in-string ?_ ?  buffer-file-name))
           "%b"))
        (:eval
         (let ((project-name (projectile-project-name)))
           (unless (string= "-" project-name)
             (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))
;;
;; It's nice to know how much battery you have left

(unless (string-match-p "^Power N/A" (battery))
(display-battery-mode 1))
;;
;; Change splash Image
;; (setq fancy-splash-image (concat doom-user-dir "Backgrounds/cute-demon.png"))

 (let ((alternatives '("cute-demon.png"
                      "trancendent-gnu.png"
                      "doom-emacs-green.svg"
                      "I-am-doom.png")))
  (setq fancy-splash-image
        (concat doom-user-dir "Backgrounds/"
               (nth (random (length alternatives)) alternatives))))
;;
;; Enable autosave
(setq auto-save-default t
      make-backup-files t)

;; Enable LSP for Java
(after! java-mode
  (add-hook 'java-mode-hook #'lsp-deferred))

;; in ~/.doom.d/config.el
(after! org
  (add-to-list 'org-export-backends 'latex))

;; Enable company mode for autocompletion
(after! lsp-java
  (add-hook 'java-mode-local-vars-hook #'company-mode))
;;
(setq doom-modeline-support-imenu t)
;;
(setq doom-modeline-env-version t)
;;
;; Enable format on save
(add-hook 'prog-mode-hook 'format-all-mode)
;;
;; Install wakatime
(use-package wakatime-mode
  :ensure t)
;;
;; use user-specified labels for file captions in org mode
(setq org-latex-prefer-user-labels t)
;; Fix for org mode not generating table of content
(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
;; enable wakatime in all buffers
;; (global-wakatime-mode)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

;; if you use typescript-mode
(add-hook 'typescript-mode-hook #'setup-tide-mode)
;; if you use treesitter based typescript-ts-mode (emacs 29+)
(add-hook 'typescript-ts-mode-hook #'setup-tide-mode)
