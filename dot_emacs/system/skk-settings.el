;;; SKKの設定
;; (require 'skk-autoloads)
;; (global-set-key "\C-x\C-j" 'skk-mode)
;; (global-set-key "\C-xj" 'skk-auto-fill-mode)
;; ;(global-set-key "\C-xt" 'skk-tutorial)
;; ;; Specify dictionary location
;; (setq skk-large-jisyo "~/share/skk/SKK-JISYO.L")
;; ;; Specify tutorial location
;; (setq skk-tut-file "~/share/skk/SKK.tut")

;; (add-hook 'skk-mode-hook
;; 	  (lambda ()
;; 	    (setq auto-fill-mode 0)))
;; (add-hook 'skk-auto-fill-mode
;; 	  (lambda ()
;; 	    (setq auto-fill-mode 0)))

;; (add-hook 'isearch-mode-hook
;; 	  (function (lambda ()
;; 		      (and (boundp 'skk-mode) skk-mode
;; 			   (skk-isearch-mode-setup)))))
;; (add-hook 'isearch-mode-end-hook
;; 	  (function
;; 	   (lambda ()
;; 	     (and (boundp 'skk-mode) skk-mode (skk-isearch-mode-cleanup))
;; 	     (and (boundp 'skk-mode-invoked) skk-mode-invoked
;; 		  (skk-set-cursor-properly))
;; 	     (setq auto-fill-mode 0))))
