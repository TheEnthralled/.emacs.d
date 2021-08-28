
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(setq visible-bell 1)

;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))



;; Show line numbers.
(global-display-line-numbers-mode)

;; Disable blinking cursor.
(blink-cursor-mode 0)

;; Highlight current line
(global-hl-line-mode +1)

;; Remove tool-bar.
(tool-bar-mode -1)

;; Remove scroll-bar
(scroll-bar-mode -1)


;; Themes.
(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))
(load-theme 'nord t)


;; Evil mode.
(use-package evil)
(evil-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company yasnippet eglot use-package nord-theme evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;; Eglot config.
(use-package eglot
  :ensure t
  



  )

(add-hook 'c++-mode 'eglot-ensure)

;; Company config.
(use-package company
  :ensure t
  :config
  (global-company-mode)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-dabbrev-downcase nil)
  (setq company-selection-wrap-around t)
  )

)


;; Go-mode config.
(use-package go-mode
  :ensure t
  :commands go-mode
  

)

(require 'project)

(defun project-find-go-module (dir)
  (when-let ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))

(cl-defmethod project-root ((project (head go-module)))
  (cdr project))

(add-hook 'project-find-functions #'project-find-go-module)
(require 'go-mode)
(require 'eglot)
(add-hook 'go-mode-hook 'eglot-ensure)
