;;; auto-complete(入力補完) ----------------------------------------------------
(require 'auto-complete)
(global-auto-complete-mode t)

;; 補完候補選択
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

;; 補完開始を3文字目からにする
;(setq ac-auto-start 3)

;; 色を変換
(set-face-background 'ac-selection-face "steelblue")
;(set-face-background 'ac-menu-face "skyblue")
