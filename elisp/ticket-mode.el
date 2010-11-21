;;;; Ticket mode.

;; 作業リスト
;; 1. プロジェクト設定項目＆チケット項目の入力チェックを行なう
;; 2. 設定項目にcomplitionを追加
;; 3. trac-dbとの連携処理を
;; 4. チケットバッファ中に変更不可領域を定義する


;;; プロジェクト設定項目の設定 =================================================
(defvar ticket-mode-setting-item-trac-home
  (list :name "trac-home" 
	:text "/var/trac"
	:areatype 0))
(defvar ticket-mode-setting-item-trac-project
  (list :name "trac-project"
	:text "test_project"
	:areatype 0))
(defvar ticket-mode-setting-item-trac-db
  (list :name "trac-db" 
	:text "db/trac.db"
	:areatype 0))
(defvar ticket-mode-setting-item-sqlite-cmd
  (list :name "sqlite-cmd"
	:text "sqlite3"
	:areatype 0))

(defconst ticket-mode-setting-item-lst
  (list ticket-mode-setting-item-trac-home
	ticket-mode-setting-item-trac-project
	ticket-mode-setting-item-trac-db
	ticket-mode-setting-item-sqlite-cmd))

(defun ticket-mode-trac-db ()
  "DBのパス"
  (concat (getf ticket-mode-setting-item-trac-home ':text) "/"
	  (getf ticket-mode-setting-item-trac-project ':text) "/"
	  (getf ticket-mode-setting-item-trac-db ':text)))

(defun ticket-mode-sqlite-cmd ()
  "SQLITEコマンド"
  (getf ticket-mode-setting-item-sqlite-cmd ':text))


;;; チケット項目の設定 =========================================================
(defvar ticket-mode-item-type
  (list :name "type"
	:text "defect"
	:areatype 0))
(defvar ticket-mode-item-component
  (list :name "component"
	:text "component1"
	:areatype 0))
; tracのバージョン0.9以前に使かわれていた？
;(defvar ticket-mode-item-severity
;  (list :name "severity" 
;	:text ""
;	:areatype 0))
(defvar ticket-mode-item-priority
  (list :name "priority"
	:text "major"
	:areatype 0))
(defvar ticket-mode-item-owner
  (list :name "owner"
	:text user-full-name
	:areatype 0))
(defvar ticket-mode-item-reporter
  (list :name "reporter"
	:text user-full-name
	:areatype 0))
(defvar ticket-mode-item-cc
  (list :name "cc"
	:text ""
	:areatype 0))
(defvar ticket-mode-item-version
  (list :name "version"
	:text ""
	:areatype 0))
(defvar ticket-mode-item-milestone
  (list :name "milestone"
	:text ""
	:areatype 0))
(defvar ticket-mode-item-status
  (list :name "status"
	:text "new"
	:areatype 0))
(defvar ticket-mode-item-resolution
  (list :name "resolution"
	:text ""
	:areatype 0))
(defvar ticket-mode-item-summary
  (list :name "summary"
	:text ""
	:areatype 0))
(defvar ticket-mode-item-keywords
  (list :name "keywords"
	:text ""
	:areatype 0))  
(defvar ticket-mode-item-description
  (list :name "description"
	:text ""
	:areatype 1))

(defconst ticket-mode-item-lst
  (list ticket-mode-item-type
	ticket-mode-item-component
;	ticket-mode-item-severity
	ticket-mode-item-priority
	ticket-mode-item-owner
	ticket-mode-item-reporter
	ticket-mode-item-cc
	ticket-mode-item-version
	ticket-mode-item-milestone
	ticket-mode-item-status
	ticket-mode-item-resolution
	ticket-mode-item-summary
	ticket-mode-item-keywords
	ticket-mode-item-description))

;;; チケット情報取得用関数 =====================================================
(defun ticket-mode-get-item (name)
  "チケット項目名よりチケット項目を取得"
  (let (ret-item)
    (dolist (item ticket-mode-item-lst ret-item)
      (if (string= name (getf item ':name))
	  (setq ret-item item)))))

(defun ticket-mode-get-item-name-lst ()
  "チケット項目名のリストを取得"
  (let (ret-lst)
    (dolist (item ticket-mode-item-lst ret-lst)
      (setq ret-lst (cons (getf item ':name) ret-lst)))
    (reverse ret-lst)))

(defun ticket-mode-get-item-text-lst ()
  "チケット項目の設定値を取得"
  (let (ret-lst)
    (dolist (item ticket-mode-item-lst ret-lst)
      (setq ret-lst (cons (getf item ':text) ret-lst)))
    (reverse ret-lst)))

(defun ticket-mode-get-item-areatype-lst ()
  "チケット項目のエリアタイプリストを取得"
  (let (ret-lst)
    (dolist (item ticket-mode-item-lst ret-lst)
      (setq ret-lst (cons (getf item ':areatype) ret-lst)))
    (reverse ret-lst)))


;;; 共通使用関数群 =============================================================
(defun ticket-mode-get-area-point (head-and-tail-regexp)
  "指定エリアの開始、終了位置のリストを取得する"
  (save-excursion
    (goto-char (point-min))
    (if (re-search-forward (car head-and-tail-regexp) nil t)
	(progn
	  (next-line)
	  (beginning-of-line)
	  (setq begin-pos (point)))
      (error "エリアの開始文字列が見つかりません: 正規表現[%s]" (car head-and-tail-regexp)))
    (if (re-search-forward (cadr head-and-tail-regexp) nil t)
	(progn 
	  (previous-line)
	  (setq end-pos (point)))
      (error "エリアの終了文字列が見つかりません: 正規表現[%s]" (cadr head-and-tail-regexp)))
    (list begin-pos end-pos)))

(defun ticket-mode-line-string (char column-pos)
  (let (line-string)
    (setq num (- column-pos (current-column)))
    (dotimes (x num line-string)
      (setq line-string (concat line-string char)))))


;;; バッファテンプレート作成用関数群 ===========================================
(defun ticket-mode-insert-template ()
  "*Ticket*バッファにテンプレートを作成する"
  (insert "== プロジェクト設定項目 ")
  (insert (ticket-mode-line-string "=" 50) "\n")
  (ticket-mode-insert-item-template ticket-mode-setting-item-lst) 
  (insert (ticket-mode-line-string "=" 50) "\n\n\n")

  (insert "== チケット項目 ")
  (insert (ticket-mode-line-string "=" 50) "\n")
  (ticket-mode-insert-item-template ticket-mode-item-lst)
  (insert (ticket-mode-line-string "=" 50) "\n"))

(defun ticket-mode-insert-item-template (lst)
  "プロジェクト設定項目＆チケット項目用のテンプレートを作成する"
  (if (null lst)
      ()
    (let ((item (car lst)))
      (if (zerop (getf item ':areatype))
	  (ticket-mode-insert-areatype0 item)
	(insert "\n")
	(ticket-mode-insert-areatype1 item))
      (ticket-mode-insert-item-template (cdr lst)))))

(defun ticket-mode-insert-areatype0 (item)
  "一行タイプの項目エリアを作成する"
  (insert (getf item ':name))
  (move-to-column 20 t)
  (insert (concat "= " (getf item ':text) "\n")))

(defun ticket-mode-insert-areatype1 (item)
  "複数行タイプの項目エリアを作成する"
  (insert (concat "@@" (upcase (getf item ':name)) " HEAD@@ "))
  (insert (ticket-mode-line-string "-" 50) "\n")
  (insert (getf item ':text) "\n")
  (insert (concat "@@" (upcase (getf item ':name)) " TAIL@@ "))
  (insert (ticket-mode-line-string "-" 50) "\n\n\n"))


;;; バッファより設定値を取得する関数群 =========================================
(defun ticket-mode-get-area-text (item)
  "*Ticket*バッファより設定値を取得する"
  (if (zerop (getf item ':areatype))
      (ticket-mode-get-area-text0 item)
    (ticket-mode-get-area-text1 item)))

(defun ticket-mode-get-area-text0 (item)
  "*Ticket*バッファより設定値を取得する(areatype:0)"
  (save-excursion
    (goto-char (point-min))
    (let ((name (getf item ':name)))
      (if (re-search-forward (concat "^" name  "[ \t]*=[ \t]*") nil t)
	  (progn 
	    (setq begin-pos (point))
	    (end-of-line)
	    (skip-chars-backward " \t")
	    (setq end-pos (point)))
	(error "指定項目値が見つかりません"))
      (buffer-substring-no-properties begin-pos end-pos))))

(defun ticket-mode-get-area-text1 (item)
  "*Ticket*バッファより設定値を取得する(areatype:1)"
  (let ((head-and-tail-re 
	 (ticket-mode-area-indicate-list (getf item ':name))))
    (ticket-mode-get-area-string head-and-tail-re)))

(defun ticket-mode-area-indicate-list (item)
  (let ((head-regexp (concat "^@@" (upcase item) " HEAD@@ -+"))
        (tail-regexp (concat "^@@" (upcase item) " TAIL@@ -+")))
    (list head-regexp tail-regexp)))

(defun ticket-mode-get-area-string (head-and-tail-regexp)
  "指定エリアの文字列を取得する"
  (setq points (ticket-mode-get-area-point head-and-tail-regexp))
  (buffer-substring-no-properties (car points) (cadr points)))


;;; バッファより設定値を更新する関数群 =========================================
(defun ticket-mode-update-item-text (item)
  "*Ticket*バッファより設定項目の設定値を更新する"
  (setf (getf item ':text) (ticket-mode-get-area-text item)))

(defun ticket-mode-update-all-item-text ()
  "*Ticket*バッファより全てのチケット項目の設定値を更新する"
  (dolist (item ticket-mode-item-lst t)
    (ticket-mode-update-item-text item)))
	
(defun ticket-mode-update-all-setting-item-text ()
  "*Ticket*バッファより全てのプロジェクト設定項目の設定値を更新する"
  (dolist (item ticket-mode-setting-item-lst t)
    (ticket-mode-update-item-text item)))


;;; *Ticket*バッファ内移動処理用の関数群 =======================================
(defun ticket-mode-set-init-point ()
  "初期ポイント位置を設定する"
  (and (goto-char (point-min))
       (re-search-forward "^== チケット項目 =+" nil t)
       (search-forward "= " nil t)))

(defun ticket-mode-next-line ()
  "次の項目に移動する"
  (interactive)
  (next-line)
  (if (ticket-mode-tail-setting-region-p)
      (next-line 4))
  (if (and (null (ticket-mode-in-areatype1-region-p))
	   (ticket-mode-empty-line))
      (next-line))
  (if (ticket-mode-head-areatype1-region-p)
      (next-line))
  (if (ticket-mode-tail-areatype1-region-p)
      (previous-line))
  (if (ticket-mode-in-areatype1-region-p)
      ()
    (ticket-mode-move-item-start)))

(defun ticket-mode-previous-line ()
  "前の項目に移動する"
  (interactive)
  (previous-line)
  (if (ticket-mode-head-ticket-region-p)
      (previous-line 4))
  (if (ticket-mode-head-areatype1-region-p)
      (previous-line 2))
  (if (ticket-mode-head-setting-region-p)
      (forward-line))
  (if (ticket-mode-in-areatype1-region-p)
      ()
    (ticket-mode-move-item-start)))

(defun ticket-mode-beginning-of-line ()
  "行の先頭に移動する"
  (interactive)
  (if (ticket-mode-in-areatype1-region-p)
      (beginning-of-line)
    (ticket-mode-move-item-start)))

(defun ticket-mode-move-item-start ()
  "チケット項目の開始位置へ移動する"
  (setq end-point (progn (end-of-line)
			 (point)))
  (beginning-of-line)
  (search-forward "= " end-point t))

(defun ticket-mode-head-setting-region-p ()
  "現在のポイント行がプロジェクト設定領域の開始行であるかを検査する"
  (save-excursion
    (beginning-of-line)
    (looking-at "^== プロジェクト設定項目 =+")))

(defun ticket-mode-tail-setting-region-p ()
  "現在のポイント行がプロジェクト設定領域の終了行であるかを検査する"
  (save-excursion
    (beginning-of-line)
    (looking-at "^=+$")))

(defun ticket-mode-head-ticket-region-p ()
  "現在のポイント行がチケット項目領域の開始行であるかを検査する"
  (save-excursion
    (beginning-of-line)
    (looking-at "^== チケット項目 =+")))

(defun ticket-mode-head-areatype1-region-p ()
  "現在のポイント行がエリアタイプ1領域の開始行であるかを検査する"
  (save-excursion
    (beginning-of-line)
    (looking-at "^@@[A-Z]+ HEAD@@")))

(defun ticket-mode-tail-areatype1-region-p ()
  "現在のポイント行がエリアタイプ1領域の終了行であるかを検査する"
  (save-excursion
    (beginning-of-line)
    (looking-at "@@[A-Z]+ TAIL@@")))

(defun ticket-mode-in-areatype1-region-p ()
  "現在のポイント行がエリアタイプ1領域内であるかを検査する"
  (save-excursion
    (let ((current-pos (point)))
      (and (re-search-forward "^@@[A-Z]+ TAIL@@ -+" nil t)
	   (goto-char current-pos)
	   (re-search-backward "^@@[A-Z]+ HEAD@@ -+" nil t)))))

(defun ticket-mode-empty-line ()
  "現在のポイント行が空行であるかを検査する"
  (save-excursion
    (beginning-of-line)
    (looking-at "^ *$")))


;;; デバッグ用の表示関数群 ========================================================
(defun ticket-mode-disp-item-text ()
  "*Ticket*バッファの設定値で更新後、チケット項目の設定値を表示する"
  (interactive)
  (ticket-mode-update-all-item-text)
  (dolist (item ticket-mode-item-lst t)
    (insert (getf item ':name) "--> \"" (getf item ':text) "\"\n")))

(defun ticket-mode-disp-setting-item-text ()
  "*Ticket*バッファの設定値で更新後、プロジェクト設定項目の設定値を表示する"
  (interactive)
  (ticket-mode-update-all-setting-item-text)
  (dolist (item ticket-mode-setting-item-lst t)
    (insert (getf item ':name) "--> \"" (getf item ':text) "\"\n")))


;;; complition関数群 ===========================================================
;; 未完成のためコメントアウトしておく

;; (defun ticket-mode-completion ()
;;   "*現在のカーソル位置から補完入力を行う"
;;   (interactive)
;;   (let ((item-list (ticket-mode-get-item-name-lst)) (cur-point (point)) (read-string ""))
;;     (while item-list
;;       (setq item (car item-list))
;;       (setq head-and-tail (ticket-mode-area-indicate-list item))
;;       (setq points (ticket-mode-get-area-point head-and-tail))
;;       (if (and (>= cur-point (car points)) (<= cur-point (cadr points)))
;; 	  (progn 
;; 	    (setq comp-list (ticket-mode-completion-list item))
;; 	    (setq init-string (car comp-list))
;; 	    (setq completion-ignore-case t)
;; 	    (if comp-list
;; 		(setq read-string (completing-read (concat item ": ") comp-list nil t init-string)))))
;;       (setq item-list (cdr item-list)))
;;     (insert read-string)))

;; (defun ticket-mode-completion-list (item)
;;   "補完候補リスト"
;;   (cond 
;; ;   ((string-equal "project" item) (list "IDC" "MN5"))
;;    ((string-equal "reporter" item) (list "kondou" "tsunoi"))
;;    nil))


;;; チケット追加関数群 =========================================================
(defun ticket-mode-add-ticket ()
  "チケットを追加する"
  (interactive)
  (defun strval (lst)
    (let (ret-lst)
      (dolist (item lst ret-lst)
	(setq ret-lst (cons (concat "'" item "'") ret-lst)))
      (reverse ret-lst)))
  (ticket-mode-update-all-item-text)
  (ticket-mode-update-all-setting-item-text)
  (let ((name-lst (ticket-mode-get-item-name-lst))
	(text-lst (strval (ticket-mode-get-item-text-lst)))
	(time (trac-get-time-string)))
    (setq name-lst (append name-lst '("time" "changetime")))
    (setq text-lst (append text-lst (list time time)))
    (call-process (ticket-mode-sqlite-cmd) nil t nil
		  (ticket-mode-trac-db)
		  (ticket-mode-add-ticket-sql name-lst text-lst))
    (message "チケットを追加しました")))

(defun ticket-mode-left-shift (x len)
  "左シフト(<<)"
  (if (= len 0)
      x
    (ticket-mode-left-shift (* x 2) (- len 1))))

(defun trac-get-time-string ()
  "現在時刻のtime_t文字列取得. INTEGERの桁数が足りないのでいちどfloatに変換している"
  (let ((ctime (current-time)))
    (format "%.0f" (+ (ticket-mode-left-shift (float (car ctime)) 16) (car (cdr ctime))))))

(defun ticket-mode-add-ticket-sql (column-lis value-lis)
  "チケット追加のSQL文字列"
  (defun lis-str (lis s sep)
    (if (null lis)
        s
      (lis-str (cdr lis) (concat s (if (string= s "") "" sep) (car lis)) sep)))
  (let ((column-str (lis-str column-lis "" ","))
        (value-str (lis-str value-lis "" ",")))
    (concat "insert into ticket (" column-str ") values (" value-str ")")))


;;; チケットモード定義 =========================================================
(defun ticket-mode ()
  "Tracのチケット作成を行うモード"
  (interactive)
  (pop-to-buffer "*Ticket*" nil)
  (kill-all-local-variables)
  (set-buffer "*Ticket*")
  (ticket-mode-insert-template)
  (ticket-mode-set-init-point)
  (setq major-mode 'ticket-mode)
  (setq mode-name "Ticket")
  (setq ticket-mode-map (make-keymap))
  (define-key ticket-mode-map "\C-c\C-c" 'ticket-mode-disp-item-text)
;  (define-key ticket-mode-map "\C-c\C-v" 'ticket-mode-completion)
  (define-key ticket-mode-map "\C-c\C-d" 'ticket-mode-add-ticket)
  (define-key ticket-mode-map "\C-p" 'ticket-mode-previous-line)
  (define-key ticket-mode-map "\C-n" 'ticket-mode-next-line)
  (define-key ticket-mode-map "\C-a" 'ticket-mode-beginning-of-line)
  (use-local-map ticket-mode-map)
)

(provide 'ticket-mode)
;;; ticket-mode.el ends here
