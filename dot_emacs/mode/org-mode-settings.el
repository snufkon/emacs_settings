(require 'org-install)
(require 'org)

;; 参考
;; http://d.hatena.ne.jp/rubikitch/20100819/org
(setq org-startup-truncated nil)
(setq org-return-follows-link t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-directory "~/Dropbox/Emacs/org-file/")
(setq org-default-notes-file (concat org-directory "note.org"))
(setq org-agenda-files (list
			org-default-notes-file
			(concat org-directory "project/smn.org")
			(concat org-directory "project/smn_minute.org")
			(concat org-directory "project/antlers.org")
			(concat org-directory "project/sonet.org")))
(global-set-key (kbd "C-c a") 'org-agenda)

;; 参考
;; http://d.hatena.ne.jp/tamura70/20100208/org
;; アジェンダ表示で下線を用いる
(add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))
(setq hl-line-face 'underline)
      
(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline nil "Inbox")
         "** TODO %?\n   %i\n   %a\n   %t")
        ("b" "Bug" entry
         (file+headline nil "Inbox")
         "** TODO %?   :bug:\n   %i\n   %a\n   %t")
        ("i" "Idea" entry
         (file+headline nil "New Ideas")
         "** %?\n   %i\n   %a\n   %t")))
(global-set-key (kbd "C-c c") 'org-capture)


;; (setq org-agenda-files (list 
;; 			org-default-notes-file 
;;  			"/Users/kondo/memo/project/smn.org"
;;  			"/Users/kondo/memo/project/antlers.org"
;;  			"/Users/kondo/memo/project/misc.org"
;;  			"/Users/kondo/memo/learn/org-mode.org"
;;  			"/Users/kondo/memo/learn/emacs.org"
;; 			"/Users/kondo/tmp/hoge.org"
;; 			))

;; ;;;; キーバインド --------------------------------------------------------------
;; (define-key org-mode-map (kbd "<C-return>") 'org-insert-heading-dwim)
;; (define-key org-mode-map (kbd "ESC <up>") 'org-metaup)
;; (define-key org-mode-map (kbd "ESC <down>") 'org-metadown)
;; (define-key org-mode-map (kbd "ESC <left>") 'org-metaleft)
;; (define-key org-mode-map (kbd "ESC <right>") 'org-metaright)

;;;; Emacs テクニックバイブル 14.2 ---------------------------------------------
; (require 'org)
(defun org-insert-upheading (org)
  "1レベル上の見出しを入力する。"
  (interactive "P")
  (org-insert-heading arg)
  (cond ((org-on-heading-p) (org-do-promote))
	((org-at-item-p) (org-indent-item -1))))
(defun org-insert-heading-dwim (arg)
  "現在と同じレベルの見出しを入力する。
C-uをつけると１レベル上、C-u C-uをつけると１レベル下の見出しを入力する。"
  (interactive "p")
  (case arg
    (4  (org-insert-subheading nil))	;C-u
    (16 (org-insert-upheading  nil))	;C-u C-u
    (t  (org-insert-heading    nil))))
(define-key org-mode-map (kbd "<C-return>") 'org-insert-heading-dwim)

;; ;;;; Emacs テクニックバイブル 14.4 ---------------------------------------------
;; (org-remember-insinuate)		; org-rememberの初期化
;; ;; メモを格納するorgファイルの設定
;; (setq org-directory "~/memo/")
;; (setq org-default-notes-file (expand-file-name "memo.org" org-directory))
;; ;(setq org-default-notes-file (expand-file-name "emacs_study.org" org-directory)) ; Emacs勉強会用に一時的に変更
;; ;; テンプレートの設定
;; (setq org-remember-templates
;;       '(("Note" ?n "** %?\n   %i\n   %a\n   %t" nil "Inbox")
;; 	("Todo" ?t "** TODO %?\n   %i\n   %a\n   %t" nil "Inbox")))

;; ;; Select template: [n]note [t]odo

;; ;;;; Emacs テクニックバイブル 14.6 ---------------------------------------------
;; (setq org-use-fast-todo-selection t)
;; (setq org-todo-keywords
;;       '((sequence "TODO(t)"   "STARTED(s)"   "WAITING(w)" "|" "DONE(x)" "CANCEL(c)")
;; 	(sequence "APPT(a)" "|" "DONE(x)" "CANCEL(c)")))

;; ;;;; Emacs テクニックバイブル 14.9 ---------------------------------------------
;; (global-set-key (kbd "C-c l") 'org-store-link)
;; ;; リンクを辿る際のブラウザとして、emacs-w3mを利用
;; ;(setq browse-url-browser-function 'w3m-browse-url)
;; ;; RETでリンクを辿る
;; (setq org-return-follows-link t)


;; ;;;; Emacs テクニックバイブル 14.14 --------------------------------------------
;; ;; M-x org-rememberによるメモを集めるorgファイル
;; ;(setq org-default-notes-file "~/memo/plan.org")
;; ;; 予定表に使うorgファイルのリスト
;; (setq org-agenda-files (list 
;; 			org-default-notes-file 
;;  			"/Users/kondo/memo/project/smn.org"
;;  			"/Users/kondo/memo/project/antlers.org"
;;  			"/Users/kondo/memo/project/misc.org"
;;  			"/Users/kondo/memo/learn/org-mode.org"
;;  			"/Users/kondo/memo/learn/emacs.org"
;; 			"/Users/kondo/tmp/hoge.org"
;; 			))
;;(global-set-key (kbd "C-c a") 'org-agenda)

;; M-x org-agenda を拡張する
;; (setq org-agenda-custom-commands
;;       '(("x" "My agenda view"
;; 	 ((agenda)
;; 	  (todo "WAITING")
;; 	  (tags-todo "project")))))
;; (("x" "My agenda view" ((agenda) (todo "WAITING") (tags-todo "project"))))


;;;; ---------------------------------------------------------------------------
;; 参考: http://d.hatena.ne.jp/tamura70/20100227/org
;; TODO状態
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))
;; DONEの時刻を記録
(setq org-log-done 'time)

(require 'org-habit)
