;;; javascript-mode ------------------------------------------------------------
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook
          '(lambda ()
             (setq js2-basic-offset 4)))
