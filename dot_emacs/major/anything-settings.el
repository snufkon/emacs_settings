;;; anything -------------------------------------------------------------------
(require 'anything-startup)
;(require 'anything-etags)
;(require 'anything-yaetags)
;(require 'anything-gtags)
;(require 'anything-ipa)

;; 自動でimenuのインデックスを作成
(setq imenu-auto-rescan t)
(global-set-key (kbd "C-x b") 'anything)
(global-set-key (kbd "C-x C-b") 'anything)


;;; 複数ファイルにまたがりbm.elを検索対象に追加する設定 ------------------------
;;; 参考: 
;;; - http://d.hatena.ne.jp/peccu/20100402/bmglobal
(defvar anything-c-source-bm-global-use-candidates-in-buffer
  '((name . "Global Bookmarks")
    (init . anything-c-bm-global-init)
    (candidates-in-buffer)
    (type . file-line))
  "show global bookmarks list.
Global means All bookmarks exist in `bm-repository'.

Needs bm.el.
http://www.nongnu.org/bm/")
;; (anything 'anything-c-source-bm-global-use-candidates-in-buffer)
(defvaralias 'anything-c-source-bm-global 'anything-c-source-bm-global-use-candidates-in-buffer)
;; (anything 'anything-c-source-bm-global)

(defun anything-c-bm-global-init ()
  "Init function for `anything-c-source-bm-global'."
  (when (require 'bm nil t)
    (with-no-warnings
      (let ((files bm-repository)
            (buf (anything-candidate-buffer 'global)))
        (dolist (file files)            ;ﾌﾞｯｸﾏｰｸされてるﾌｧｲﾙﾘｽﾄから，1つ取り出す
          (dolist (bookmark (cdr (assoc 'bookmarks (cdr file)))) ;1つのﾌｧｲﾙに対して複数のﾌﾞｯｸﾏｰｸがあるので
            (let ((position (cdr (assoc 'position bookmark))) ;position
                  (annotation (cdr (assoc 'annotation bookmark))) ;annotation
                  (file (car file))                               ;file名を取り出す
                  line
                  str)
              (setq str (with-current-buffer (find-file-noselect file) ;anything用の文字列にformat
                               (goto-char position)
                               (beginning-of-line)
                               (unless annotation
                                   (setq annotation ""))
                               (if (string= "" line)
                                   (setq line  "<EMPTY LINE>")
                                 (setq line (car (split-string (thing-at-point 'line) "[\n\r]"))))
                               (format "%s:%d: [%s]: %s\n" file (line-number-at-pos) annotation line)))
              (with-current-buffer buf (insert str)))))))))


; anythingの検索対象を設定 
;(setq anything-sources
;      '(anything-c-source-buffers+
;	anything-c-source-file-name-history
;	anything-c-source-buffer-not-found
;	anything-c-source-imenu
;	anything-c-source-etags-select
;	anything-c-source-plocate
;	anything-c-source-bm-global
;	anything-c-source-home-locate
;;	anytihng-c-source-gtags-select
;;	anything-c-source-yaetags-select
;	))

;; HOME以下のファイルをanythingから探す設定
(defvar anything-c-source-home-locate
  '((name . "Home Locate")
    (candidates . (lambda ()
		    (apply 'start-process "anything-home-locate-process" nil
			   (home-locate-make-command-line anything-pattern "-r"))))
    (type . file)
    (requires-pattern . 3)
    (delayed)))

;; プロジェクトごとのファイルをanythingから深す設定
(defvar anything-c-source-plocate
  '((name . "Project Locate")
    (candidates
     . (lambda ()
	 (let ((default-directory
		 (with-current-buffer anything-current-buffer default-directory)))
	   (apply 'start-process "anything-plocate-process" nil
		  (plocate-make-command-line anything-pattern "-r")))))
    (type . file)
    (requires-pattern . 3)
    (delayed)))

;; my-anything
(defun my-anything ()
  (interactive)
  (anything-other-buffer '(
;; 			   anything-c-source-buffers+
;; 			   anything-c-source-file-name-history
;; 			   anything-c-source-recentf
;;  			   anything-c-source-buffer-not-found
;; 			   anything-c-source-imenu
; 			   anything-c-source-etags-select
 			   anything-c-source-bm-global
;;  			   anything-c-source-plocate
;;  			   anything-c-source-home-locate
			   anything-c-source-ipa-global
			   ;;	anytihng-c-source-gtags-select
			   ;;	anything-c-source-yaetags-select			   
			   )
			 "*my anything*"))
(define-key global-map (kbd "C-:") 'my-anything)


