;;; .emacs --- GNU Emacs 19.28+ startup file

;; Copyright (C) 1996, 1997, 1999, 2000, 2001, 2008, 2013 by Raymond Penners.

;; Author: Raymond Penners <raymondp@stack.urc.tue.nl>
;; Time-stamp: <2013-06-16 18:20:15 kees-jan>

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Definitions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Returns t if this version of Emacs is at least MAJOR.MINOR, nil otherwise.
(defun my-emacs-version-ge (major minor) ""
  (or (> emacs-major-version major)
      (and (= emacs-major-version major)
	     (>= emacs-minor-version minor))))

;;; Same as REQUIRE, but returns t/nil on success/failure
(defun my-require (feature &optional file-name)
  (progn
    (if (not (featurep feature))
        (load (or file-name
                  (symbol-name feature)) t))
    (featurep feature)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Processes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Shell
(if (eq system-type 'windows-nt)
    (progn
      (setq exec-path (cons "C:/cygwin/bin" exec-path))
      (setenv "PATH" (concat "C:\\cygwin\\bin;" (getenv "PATH")))
      (setq my-win32-shell "bash")
      (setq process-coding-system-alist '(("bash" . undecided-unix)))
      (setq w32-quote-process-args ?\")
      (setenv "SHELL" my-win32-shell)
      (setq shell-file-name my-win32-shell)
      (setq explicit-shell-file-name my-win32-shell)))

(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)
(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; PBV Kit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(if (getenv "PBVKITDIR")
    (progn
      (load "~/.emacs-pbv" t)
      (load "~/.emacs-my-pbv" t))
  (message "Environment variable PBVKITDIR not set. Pbv kit not loaded."))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Programming
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; C/C++
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(setq compilation-read-command t)
(add-hook 'c-mode-common-hook
	  (function (lambda ()
		      (define-key c-mode-map "\C-m" 'newline-and-indent)
                      (make-local-variable 'dabbrev-case-fold-search)
                      (setq dabbrev-case-fold-search nil)
                      (c-set-offset 'substatement-open 0)
                      )))


;;; Perl
(add-hook 'perl-mode-hook
	  (function (lambda ()
		      ;; GNU style
		      (setq perl-indent-level 2
			    perl-continued-statement-offset 2
			    perl-continued-brace-offset 0
			    perl-brace-offset 0
			    perl-brace-imaginary-offset 0
			    perl-label-offset -2))))

;;; Java
(add-hook 'java-mode-hook 
  (function
   (lambda ()
             (setq case-fold-search nil)
             (setq c-basic-offset 2)
             (setq tab-width 2 indent-tabs-mode nil)
;;             (c-set-offset 'inline-open 2)
             (c-set-offset 'substatement-open 0)
             )))


;;; Miscellaneous
(setq imenu-auto-rescan t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Word processing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; TeX
(setq tex-dvi-view-command
      (if (eq window-system 'x) "xdvi" "dvi2tty * | cat -s"))

;;; AUC TeX
(if (my-require 'tex-site)
    (progn
      (setq TeX-auto-save t)
      (setq TeX-parse-self t)
      (setq-default TeX-master t)
      (add-hook 'LaTeX-mode-hook 
		(function (lambda () (outline-minor-mode 1))))))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Display
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Font-locking

;; turns on font-locking, if available
(if (not (fboundp 'turn-on-font-lock))
    (defun turn-on-font-lock ()
      (if (or (eq window-system 'x)
	      (eq window-system 'win32)
	      (eq window-system 'w32))
	  (font-lock-mode t))))

;; Look flashy...
(setq search-highlight t)
(setq font-lock-maximum-decoration t)
(require 'paren)
(show-paren-mode)

;; Turn on font-locking for supported modes
(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode t)
  (progn
    (message "Huh - no global-font-lock-mode?")
    (add-hook 'c++-mode-hook 'turn-on-font-lock)
    (add-hook 'c-mode-hook 'turn-on-font-lock)
    (add-hook 'dired-mode-hook 'turn-on-font-lock)
    (add-hook 'emacs-lisp-mode-hook 'turn-on-font-lock)
    (add-hook 'help-mode-hook 'turn-on-font-lock)
    (add-hook 'lisp-mode-hook 'turn-on-font-lock)
    (add-hook 'makefile-mode-hook 'turn-on-font-lock)
    (add-hook 'pascal-mode-hook 'turn-on-font-lock)
    (add-hook 'perl-mode-hook 'turn-on-font-lock)
    (add-hook 'latex-mode-hook 'turn-on-font-lock)
    (add-hook 'LaTeX-mode-hook 'turn-on-font-lock)
    (add-hook 'rmail-show-message-hook 'turn-on-font-lock)
    (add-hook 'rmail-summary-mode-hook 'turn-on-font-lock)
    (add-hook 'sh-set-shell-hook 'turn-on-font-lock)
    (add-hook 'shell-script-mode-hook 'turn-on-font-lock)))

;; Java mode ignores global-font-lock-mode, so force font-locking. (19.34)
(add-hook 'java-mode-hook 'turn-on-font-lock)


;;; Miscellaneous

;; Knäkkebrøt
;(standard-display-european t)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Miscellaneous
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Auto insert
(if (fboundp 'auto-insert)
    (progn
      ;; Note: Trailing '/' seems necessary!
      (setq auto-insert-directory "~/emacs/insert/")
      (add-hook 'find-file-hooks 'auto-insert)))


;;; Key bindings
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\C-cg" 'goto-line)
(global-set-key [f7] 'compile)
(global-set-key "\C-cc" 'compile)
(global-set-key "\C-ci" 'imenu)

;;; dired mode
(add-hook 'dired-load-hook
	  (function (lambda ()
		      (setq dired-x-hands-off-my-keys nil)
		      (load "dired-x"))))
(add-hook 'dired-mode-hook
	  (function (lambda ()
		      (setq dired-omit-files-p nil)
		      (setq truncate-lines t))))


;;; Minibuffer
(load "complete" t)
;(resize-minibuffer-mode 1) 
(setq enable-recursive-minibuffers t)


;;; Avoid "C:\T> ren foo.bar foo.bar~" bug on Weirdos'95
;; (if (eq system-type 'windows-nt) (setq backup-inhibited t))


;;; Read/write hooks
(if (fboundp 'time-stamp)
    (add-hook 'write-file-hooks 'time-stamp))
(if (fboundp 'copyright-update)
    (add-hook 'write-file-hooks 'copyright-update))
(if (fboundp 'auto-compression-mode)
    (auto-compression-mode 1))

;;; Server
(if (and (not (eq system-type 'windows-nt))
         (fboundp 'server-start))
    (server-start))

;;; Miscellaneous
(if (fboundp 'auto-show-mode)
    (auto-show-mode 1))
(setq visible-bell nil)
(line-number-mode 1)
(setq ps-paper-type 'ps-a4)
(setq next-line-add-newlines nil)
(setq garbage-collection-messages t)
(setq find-file-visit-truename t)
(setq bookmark-default-file "~/emacs/bookmarks")
(setq-default indent-tabs-mode nil)
(load "desktop")
;; (setq truncate-lines t)
;(hscroll-global-mode 1)

;;; Automatically added by Emacs
(put 'eval-expression 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;;; .emacs ends here
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(c-echo-syntactic-information-p t)
 '(else-kill-proceed-to-next-placeholder t)
 '(else-move-and-execute t)
 '(else-prompt-time 3)
 '(else-set-lineno t)
 '(inhibit-startup-screen t)
 '(large-file-warning-threshold 104857600))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; nXML
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-after-load 'rng-loc
  '(add-to-list 'rng-schema-locating-files "~/.schema/schemas.xml"))