;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; File name: ` ~/.emacs '
;;; ---------------------
;;;
;;; If you need your own personal ~/.emacs
;;; please make a copy of this file
;;; an placein your changes and/or extension.
;;;
;;; Copyright (c) 1997-2002 SuSE Gmbh Nuernberg, Germany.
;;;
;;; Author: Werner Fink, <feedback@suse.de> 1997,98,99,2002
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Test of Emacs derivates
;;; -----------------------
(if (string-match "XEmacs\\|Lucid" emacs-version)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;; XEmacs
  ;;; ------
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (progn
     (if (file-readable-p "~/.xemacs/init.el")
        (load "~/.xemacs/init.el" nil t))
  )
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;; GNU-Emacs
  ;;; ---------
  ;;; load ~/.gnu-emacs or, if not exists /etc/skel/.gnu-emacs
  ;;; For a description and the settings see /etc/skel/.gnu-emacs
  ;;;   ... for your private ~/.gnu-emacs your are on your one.
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (if (file-readable-p "~/.gnu-emacs")
      (load "~/.gnu-emacs" nil t)
    (if (file-readable-p "/etc/skel/.gnu-emacs")
	(load "/etc/skel/.gnu-emacs" nil t)))

  ;; Custum Settings
  ;; ===============
  ;; To avoid any trouble with the customization system of GNU emacs
  ;; we set the default file ~/.gnu-emacs-custom
  (setq custom-file "~/.gnu-emacs-custom")
  (load "~/.gnu-emacs-custom" t t)
;;;
)
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my customizations

;; default directory
(setq default-directory "~/")

;; windmove binds window shifting to the shift-arrow keys by default
(windmove-default-keybindings)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))


;; for Org
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
     (global-set-key "\C-cl" 'org-store-link)
     (global-set-key "\C-ca" 'org-agenda)
     (global-set-key "\C-cb" 'org-iswitchb)

(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only
(setq org-hide-leading-stars 'hidestars)  ; just one star used
(add-hook 'org-mode-hook 'turn-on-auto-fill) ; autofill is nice

;; lose menus, toolbars, and scrollbars
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; mouse avoidance
(mouse-avoidance-mode 'animate)

;; text zoom
(global-set-key (kbd "M-+") 'text-scale-adjust)
(global-set-key (kbd "M--") 'text-scale-adjust)
(global-set-key (kbd "M-0") 'text-scale-adjust)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; load w3m
;;(require 'w3m-load)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; set up newsreader
(setq gnus-select-method '(nntp "netnews.insightbb.com"))

;; eliminate splash screen
(setq inhibit-splash-screen t)

;; no backups
(setq make-backup-files nil)

;; nxhtml
(load "~/.emacs.d/nxhtml/autostart.el")

;; make sure *.h files are considered to by c++ not c
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; set default TAGS table to my epsimulator tree
(setq tags-table-list '("~/dev/git/epsimulator"))

;; set up RMAIL

(setenv "MAILHOST" "epstudiossoftware.com")
(setq rmail-primary-inbox-list
      '("po:mannd") rmail-pop-password-required t)
(setq user-mail-address "mannd@epstudiossoftware.com")
(setq user-full-name "David Mann")
(setq rmail-preserve-inbox t)

;; show column number
(column-number-mode t)

;; set up Markdown mode
(autoload 'markdown-mode "~/.emacs.d/markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\\.markdown" . markdown-mode) auto-mode-alist))

;; c++ indentation
(defun my-c-mode-common-hook ()
  (setq c-basic-offset 4)
  (setq c-indent-level 4)
  ;; avoid namespace indentation
  (c-set-offset 'innamespace 0)
)
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
 
;; avoid ansi codes in shell mode
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; color-theme
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(when (require 'color-theme nil 'noerror)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (load "~/.emacs.d/zenburn.el")
     (load "~/.emacs.d/color-theme-twilight.el")
     (color-theme-twilight))))

;; weblogger
(when (require 'weblogger nil 'noerror))

;; icicles - turn on with M-x icy-mode RET
(add-to-list 'load-path "~/icicles/")
(when (require 'icicles nil 'noerror))

;; size
(setq initial-frame-alist '((width . 80) (height . 55)))
;(setq default-frame-alist '((width . 70) (height . 80)))

;; save minibuffer history
(savehist-mode 1)


