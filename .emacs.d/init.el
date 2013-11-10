;; -*- mode: emacs-lisp -*-
;; Simple .emacs configuration

;; ---------------------
;; -- Global Settings --
;; ---------------------
(add-to-list 'load-path "~/.emacs.d/")
(require 'cl)
(require 'ido)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)
(require 'linum)
(require 'smooth-scrolling)
(require 'whitespace)
(require 'dired-x)
(require 'compile)
(ido-mode t)
(menu-bar-mode -1)
(normal-erase-is-backspace-mode 1)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq column-number-mode t)
(setq inhibit-startup-message t)
(setq save-abbrevs nil)
(setq show-trailing-whitespace t)
(setq suggest-key-bindings t)
(setq vc-follow-symlinks t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit autoface-default :strike-through nil :underline nil :slant normal :weight normal :height 120 :width normal :family "monaco"))))
 '(column-marker-1 ((t (:background "red"))))
 '(diff-added ((t (:foreground "cyan"))))
 '(flymake-errline ((((class color) (background light)) (:background "Red"))))
 '(font-lock-comment-face ((((class color) (min-colors 8) (background light)) (:foreground "red"))))
 '(fundamental-mode-default ((t (:inherit default))))
 '(highlight ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
 '(isearch ((((class color) (min-colors 8)) (:background "yellow" :foreground "black"))))
 '(linum ((t (:foreground "black" :weight bold))))
 '(region ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
 '(secondary-selection ((((class color) (min-colors 8)) (:background "gray" :foreground "cyan"))))
 '(show-paren-match ((((class color) (background light)) (:background "black"))))
 '(vertical-border ((t nil)))
)

;; ------------
;; -- Macros --
;; ------------
(load "defuns-config.el")
(fset 'align-equals "\C-[xalign-regex\C-m=\C-m")
(global-set-key "\M-=" 'align-equals)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c;" 'comment-or-uncomment-region)
(global-set-key "\M-n" 'next5)
(global-set-key "\M-p" 'prev5)
(global-set-key "\M-o" 'other-window)
(global-set-key "\M-i" 'back-window)
(global-set-key "\C-z" 'zap-to-char)
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\M-d" 'delete-word)
(global-set-key "\M-h" 'backward-delete-word)
(global-set-key "\M-u" 'zap-to-char)

;; ---------------------------
;; -- Basic configuration --
;; --                     --
;; -- some of it based on: https://github.com/AndreaCrotti/minimal-emacs-configuration/blob/master/init.el
;; ---------------------------

(require 'package)

;; MELPA and marmelade repos added
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

;; init installed packages
(package-initialize)

;; automatically install required packages if not installed already
(defun install-if-needed (package)
  (unless (package-installed-p package)
    (package-install package)))

(setq to-install
      '(js3-mode yasnippet jedi auto-complete autopair find-file-in-repository))

(mapc 'install-if-needed to-install)

;; require some necessary packages
(require 'auto-complete-config)
(require 'autopair)
(require 'yasnippet)

(global-set-key [f7] 'find-file-in-repository)
(ac-config-default)
(yas-global-mode 1)
(electric-pair-mode 1)

;; ---------------------------
;; -- JS Mode configuration --
;; ---------------------------
(require 'js3-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
(add-hook 'js3-mode-hook
          (lambda ()
            (load "js-config.el")
	    (add-to-list 'load-path "~/.emacs.d/jade-mode") ;; github.com/brianc/jade-mode	    
	    (require 'sws-mode)
	    (require 'jade-mode)    
	    (add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
	    (add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
))

;; --------------------------- 
;; -- Python Mode configuration --
;; install newest from: https://launchpad.net/python-mode
;; --------------------------- 
(setq py-install-directory "~/.emacs.d/elpa/python-mode.el-6.1.2")
(add-to-list 'load-path py-install-directory)
;(setq py-shell-name "ipython")

(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(setq py-electric-colon-active t)
(add-hook 'python-mode-hook 'autopair-mode)
(add-hook 'python-mode-hook 'yas-minor-mode)

;; Jedi settings
(require 'jedi)
;; It's also required to run "pip install --user jedi" and "pip
;; install --user epc" to get the Python side of the library work
;; correctly.
;; With the same interpreter you're using.

;; if you need to change your python intepreter, if you want to change it
;; (setq jedi:server-command
;;       '("python2" "/home/andrea/.emacs.d/elpa/jedi-0.1.2/jediepcserver.py"))

(add-hook 'python-mode-hook
          (lambda ()
            (jedi:setup)
            (jedi:ac-setup)
            (local-set-key "\C-cd" 'jedi:show-doc)
            (local-set-key "\C-cl" 'jedi:complete)
            (local-set-key (kbd "M-.") 'jedi:goto-definition)
    	    (electric-pair-mode f)))

(add-hook 'python-mode-hook 'auto-complete-mode)

;(require 'ipython)
