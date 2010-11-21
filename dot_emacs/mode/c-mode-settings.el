;;; c-mode ----------------------------------------------------------------
(setq c-default-style "k&r")
;; BackSpace キーを「賢く」し，インデント幅は4桁，タブはスペースに展開
(add-hook 'c-mode-common-hook
            '(lambda ()
             (progn
               (c-toggle-hungry-state 1)
               (setq c-basic-offset 4 indent-tabs-mode nil))))
