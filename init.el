;;; -*- lexical-binding: t -*-

(setq backup-directory-alist '(("" . "~/.emacs.d/emacs-backup")))

;; ----------------------------------------------
;; PACKAGE MANAGEMENT
;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;; Install use package.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; From use-package readme.
(eval-when-compile
  (require 'use-package))

(add-to-list 'load-path "~/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; ----------------------------------------------
;; HELM MODE
;;

(use-package helm
  :ensure t)

(require 'helm-config)

;;(helm-mode t)

(when (package-installed-p 'helm)
  ;; change default prefix key
  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-unset-key (kbd "C-x c"))

  ;; helm-M-x
  (setq helm-M-x-fuzzy-match t)
  (global-set-key (kbd "M-x") 'helm-M-x)

  ;; helm-kill-ring
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)

  ;; helm-mini
  (global-set-key (kbd "C-x b") 'helm-mini)
  (setq helm-buffers-fuzzy-matching t
       helm-recentf-fuzzy-match t)

  ;; helm-find-files
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  )

(setq helm-exit-idle-delay 0)

;; Run this if we can't find a package that we should.
;; (package-refresh-contents)

;; Bug Mode
   (use-package "bug-mode"
      :bind  (("C-x g g" . bug-goto)
              ("C-x g d" . bug-describe-change)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(indent-tabs-mode nil)
 '(package-selected-packages
   (quote
    (helm doom-modeline doom-themes docker-tramp magit use-package auctex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Set for Global TODO list.
(setq org-agenda-files (list "~/emacs.d/task.org"))

;; ----------------------------------------------
;; MAGIT
;;
(use-package magit
  :ensure t)

(defun magit-push-to-gerrit ()
  (interactive)
  (magit-git-command-topdir "git push origin HEAD:refs/for/master"))

(magit-define-popup-action 'magit-push-popup
  ?m
  "push to gerrit"
  'magit-push-to-gerrit)

(use-package docker-tramp
  :ensure t)

;; ----------------------------------------------
;; DOOM THEMES
;;
(use-package doom-themes
  :ensure t)

(require 'doom-themes)
;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
(load-theme 'doom-one t)

(set-face-attribute 'font-lock-builtin-face nil :foreground "#BA30FA")
(set-face-attribute 'font-lock-function-name-face nil :foreground "#BA30FA")
(set-face-attribute 'font-lock-variable-name-face nil :foreground "#BA30FA")

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)
;; Enable custom neotree theme (all-the-icons must be installed!)
(doom-themes-neotree-config)
;; or for treemacs users
(doom-themes-treemacs-config)
;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

(use-package doom-modeline
  :ensure t)
(require 'doom-modeline)
(doom-modeline-init)

;; ----------------------------------------------
;; ESHELL PROMPT
;;

;; Only show maximum three directories.
(defun pretty-pwd (path)
    (let ((num-dirs (seq-count (lambda (elt) (char-equal elt ?/)) path)))
       (cond ((< num-dirs 3) path)
             (t
               (pretty-pwd (seq-subseq path (+ 1 (seq-position path ?/))))
              ))))

;; Example prompt:
;;
;; jsambasiv@us188.sjc.aristanetworks.com ── 15:50 ── ArCloud/SpidAr/Dashboard
;;  $

(setq eshell-prompt-function
(lambda ()
  (let ((blue "#51afef")
        (green "#98be65")
        (magenta "#c678dd")
        (cyan "#46D9FF")
        (yellow "#ECBE7B")
        (red "#ff6c6b"))
  (concat
(propertize "\n" 'face `(:foreground ,blue))
(propertize (user-login-name) 'face `(:foreground ,blue))
(propertize "@" 'face `(:foreground ,yellow))
(propertize (system-name) 'face `(:foreground ,green))
(propertize " ── " 'face `(:foreground ,blue))
(propertize (format-time-string "%H:%M" (current-time)) 'face `(:foreground ,yellow))
(propertize " ── " 'face `(:foreground ,blue))
(propertize (pretty-pwd (eshell/pwd)) 'face `(:foreground ,magenta))
(propertize "\n" 'face `(:foreground ,blue))
(propertize (if (= (user-uid) 0) " # " " $ ") 'face `(:foreground ,blue))
))))

(setq eshell-history-size 512)

(display-time)

;; For use when editing a file to start eshell
;; in the directory of the file.
;; Kills another eshell buffer if it existed.
;; Only issue with that is that history doesn't
;; seem to be synced.
(defun eshell-here ()
  (when (get-buffer "*eshell*") (kill-buffer "*eshell*"))
  (interactive)
  (let ((currbuf (buffer-name)))
    (when (not (equal currbuf "*eshell*"))
      (eshell "new")
      (other-window 1)
      (switch-to-buffer currbuf)
      (other-window 1)
    )
  )
  )

(global-set-key (kbd "M-H") 'eshell-here)

(setq inhibit-startup-screen t)

(defun smash ()
  (shell-command "/mnt/c/Users/Jugeeya/Documents/Games/cemu_1.11.0/cemu_1.11.0/Cemu.exe -g \"C:\\Users\\Jugeeya\\Documents\\Games\\SMASH4CEMUTESTING\\SM4SH\\code\\cross_f.rpx\"")
  )

;; MSC Syntax Highlight

(load-file "~/.emacs.d/msc.el")

(eshell)
