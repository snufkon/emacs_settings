;;;; Emacs テクニックバイブル 14.2 ---------------------------------------------
(require 'org)
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

;;;; Emacs テクニックバイブル 14.4 ---------------------------------------------
(org-remember-insinuate)		; org-rememberの初期化
;; メモを格納するorgファイルの設定
(setq org-directory "~/memo/")
(setq org-default-notes-file (expand-file-name "memo.org" org-directory))
;; テンプレートの設定
(setq org-remember-templates
      '(("Note" ?n "** %?\n   %i\n   %a\n   %t" nil "Inbox")
	("Todo" ?t "** TODO %?\n   %i\n   %a\n   %t" nil "Inbox")))
;; Select template: [n]note [t]odo

;;;; Emacs テクニックバイブル 14.6 ---------------------------------------------
(setq org-use-fast-todo-selection t)
(setq org-todo-keywords
      '((sequence "TODO(t)"   "STARTED(s)"   "WAITING(w)" "|" "DONE(x)" "CANCEL(c)")
	(sequence "APPT(a)" "|" "DONE(x)" "CANCEL(c)")))

;;;; Emacs テクニックバイブル 14.9 ---------------------------------------------
(global-set-key (kbd "C-c l") 'org-store-link)
;; リンクを辿る際のブラウザとして、emacs-w3mを利用
;(setq browse-url-browser-function 'w3m-browse-url)
;; RETでリンクを辿る
(setq org-return-follows-link t)


;;;; Emacs テクニックバイブル 14.14 --------------------------------------------
;; M-x org-rememberによるメモを集めるorgファイル
;(setq org-default-notes-file "~/memo/plan.org")
;; 予定表に使うorgファイルのリスト
(setq org-agenda-files (list 
			org-default-notes-file 
			"/Users/kondo/memo/project/smn.org"
			"/Users/kondo/memo/project/antlers.org"
			"/Users/kondo/memo/project/misc.org"
			"/Users/kondo/memo/learn/org-mode.org"
			"/Users/kondo/memo/learn/emacs.org"
			))
(global-set-key (kbd "C-c a") 'org-agenda)

;;;; ---------------------------------------------------------------------------
;; 参考: http://d.hatena.ne.jp/tamura70/20100227/org
;; TODO状態
;; (setq org-todo-keywords
;;       '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))
;; ;; DONEの時刻を記録
;; (setq org-log-done 'time)

;; (require 'org-habit)
