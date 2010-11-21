;;; python-mode ----------------------------------------------------------------
(require 'python)
 (add-hook 'python-mode-hook
	  (lambda ()
	    (setq python-indent 4)
	    (setq indent-tabs-mode nil)
	    (setq python-guess-indent t)
	    (define-key python-mode-map "\C-cc" 'python-insert-class)
	    (define-key python-mode-map "\C-cd" 'python-insert-def)
	    (define-key python-mode-map "\C-cf" 'python-insert-for)
	    (define-key python-mode-map "\C-ci" 'python-insert-if)
	    (define-key python-mode-map "\C-ce" 'python-insert-try/except)
;	    (define-key python-mode-map "\C-ct" 'python-insert-try/finally)
	    (define-key python-mode-map "\C-cw" 'python-insert-while)
	    (define-key python-mode-map "\C-m"  'newline-and-indent)
	    (define-key python-mode-map "\C-cr" 'comment-region)
	    (setq auto-fill-mode 0)))

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; python-modeに補完機能を追加
;(require 'pysmell)
;(add-hook 'python-mode-hook (lambda () (pysmell-mode 1)))

;; pysmellをauto-complete.elから呼び出せるように変更
;; (defvar ac-source-pysmell
;;   '((candidates
;;      . (lambda ()
;; 	 (require 'pysmell)
;; 	 (pysmell-get-all-completions))))
;;   "Source for PySmell")

;; (add-hook 'python-mode-hook
;; 	  '(lambda ()
;; 	     (set (make-local-variable 'ac-sources) (append ac-sources '(ac-source-pysmell)))))
