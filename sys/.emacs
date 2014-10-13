;; (setq whitespace-space 'underline)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(font-lock-mode t t)
 '(font-use-system-font t)
 '(global-font-lock-mode t)
;; '(global-hl-line-mode f nil (hl-line))
 '(transient-mark-mode t))
 '(add-hook 'c-mode-hook 'turn-on-font-lock)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-hook 'sh-mode-hook 'turn-on-font-lock)
(add-hook 'fundamental-mode-hook 'turn-on-font-lock)
(add-hook 'java-mode-hook 'turn-on-font-lock)
(add-hook 'text-mode-hook 'turn-on-font-lock)
(add-hook 'sql-mode-hook 'turn-on-font-lock)
(font-lock-mode t)

;; tripu:
;; (add-to-list 'default-frame-alist '(font .  "Inconsolata Medium" ))
;; (set-face-attribute 'default t :font  "Inconsolata Medium" ))
;; (set-default-font "Source Code Pro 12")
(set-default-font "Inconsolata 12")
(setq whitespace-style '(face trailing tabs))
(autoload 'whitespace-mode "whitespace" "Toggle whitespace visualization." t)
;; (autoload 'whitespace-toggle-options "whitespace" "Toggle local `whitespace-mode' options." t)
;; (setq whitespace-style '(face trailing tabs newline))
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
