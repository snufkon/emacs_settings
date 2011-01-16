;;; rst.el ---------------------------------------------------------------------
;;; 参考 
;;; - http://d.hatena.ne.jp/ymotongpoo/20101106/1289007403
;;; - http://d.hatena.ne.jp/LaclefYoshi/20100922/1285125722

(autoload 'rst-mode "rst-mode" "mode for editing reStructuredText documents" t)
(require 'rst)  
(setq auto-mode-alist
      (append '(("\\.rst$" . rst-mode)
		("\\.rest$" . rst-mode)) auto-mode-alist))
;(setq frame-background-mode 'dark)
;; スペースでインデント
(add-hook 'rst-mode-hook '(lambda() (setq indent-tabs-mode nil)))
;(add-hook 'text-mode-hook 'rst-text-mode-bindings)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(rst-level-1-face ((t (:foreground "LightSkyBlue"))) t)
 '(rst-level-2-face ((t (:foreground "LightGoldenrod"))) t)
 '(rst-level-3-face ((t (:foreground "Cyan1"))) t)
 '(rst-level-4-face ((t (:foreground "chocolate1"))) t)
 '(rst-level-5-face ((t (:foreground "PaleGreen"))) t)
 '(rst-level-6-face ((t (:foreground "Aquamarine"))) t))
 ;; (rst-level-7-face ((t (:foreground "LightSteelBlue"))) t)  ;; メモ
 ;; (rst-level-8-face ((t (:foreground "LightSalmon"))) t)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(rst-level-face-base-light 20))


