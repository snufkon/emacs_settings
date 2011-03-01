;;; anything -------------------------------------------------------------------
(require 'anything)
(require 'anything-config)
(require 'anything-match-plugin)
(require 'anything-etags)
(require 'anything-yaetags)
(require 'anything-gtags)
(require 'anything-ipa)

;; 自動でimenuのインデックスを作成
(setq imenu-auto-rescan t)
(global-set-key (kbd "C-x b") 'anything)

;; anythingの検索対象を設定 
(setq anything-sources
      '(anything-c-source-buffers+
	anything-c-source-file-name-history
	anything-c-source-buffer-not-found
	anything-c-source-imenu
	anything-c-source-etags-select
	anything-c-source-plocate
;	anything-c-source-home-locate
;;	anytihng-c-source-gtags-select
;;	anything-c-source-yaetags-select
	))

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
