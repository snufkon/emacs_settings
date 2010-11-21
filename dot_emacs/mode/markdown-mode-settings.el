;; mark-downモードを追加
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\\.text" . markdown-mode) auto-mode-alist))
;; markdown-modeで利用するコマンド
(setq markdown-command "/usr/bin/markdown")

