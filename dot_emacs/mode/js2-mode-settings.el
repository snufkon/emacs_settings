;;; javascript-mode ------------------------------------------------------------
;; 参考
;; http://8-p.info/emacs-javascript.html
;; http://e-arrows.sakura.ne.jp/2010/12/closure-library-on-js2-mode.html

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; (add-hook 'js2-mode-hook
;;           '(lambda ()
;;              (setq js2-basic-offset 4)))

(add-hook 'js2-mode-hook
          #'(lambda ()
              (require 'espresso)
              (setq espresso-indent-level 2
                    espresso-expr-indent-offset 2
                    indent-tabs-mode nil)
              (set (make-local-variable 'indent-line-function) 'espresso-indent-line)))


;; (when (load "js2" t)
;;   (setq js2-cleanup-whitespace nil
;;         js2-mirror-mode nil
;;         js2-bounce-indent-flag nil)

;;   (defun indent-and-back-to-indentation ()
;;     (interactive)
;;     (indent-for-tab-command)
;;     (let ((point-of-indentation
;;            (save-excursion
;;              (back-to-indentation)
;;              (point))))
;;       (skip-chars-forward "\s " point-of-indentation)))
;;   (define-key js2-mode-map "\C-i" 'indent-and-back-to-indentation)
;;   (define-key js2-mode-map "\C-m" nil)
;;   (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))


