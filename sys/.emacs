(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(column-number-mode t)
 '(global-font-lock-mode t)
 '(font-lock-mode t)
 '(global-hl-line-mode f nil (hl-line))
 '(transient-mark-mode t))
 '(add-hook 'c-mode-hook 'turn-on-font-lock)
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )
(add-hook 'sh-mode-hook 'turn-on-font-lock)
(add-hook 'fundamental-mode-hook 'turn-on-font-lock)
(add-hook 'java-mode-hook 'turn-on-font-lock)
(add-hook 'text-mode-hook 'turn-on-font-lock)
(add-hook 'sql-mode-hook 'turn-on-font-lock)
(font-lock-mode t)
