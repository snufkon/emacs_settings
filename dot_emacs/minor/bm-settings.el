
;;; bm.el setting --------------------------------------------------------------
;;; 参考
;;; - http://d.hatena.ne.jp/peccu/20100402/bmglobal

(require 'bm)
;(global-set-key (kbd "<M-f2>") 'bm-toggle)
;; save bookmarks
(setq-default bm-buffer-persistence t)

;; Filename to store persistent bookmarks
(setq bm-repository-file "~/.bm-repository")

;; Loading the repository from file when on start up.
(add-hook' after-init-hook 'bm-repository-load)

;; Restoring bookmarks when on file find.
(add-hook 'find-file-hooks 'bm-buffer-restore)
 
;; Saving bookmark data on killing and saving a buffer
(add-hook 'kill-buffer-hook 'bm-buffer-save)
(add-hook 'auto-save-hook 'bm-buffer-save)
(add-hook 'after-save-hook 'bm-buffer-save)
 
;; Saving the repository to file when on exit.
;; kill-buffer-hook is not called when emacs is killed, so we
;; must save all bookmarks first.
(add-hook 'kill-emacs-hook '(lambda nil
                              (bm-buffer-save-all)
                              (bm-repository-save)))