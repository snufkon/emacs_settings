;;;; フォントに関する設定 ======================================================

;; フォント設定
;; (set-face-attribute 'default nil :family "Ricty" :height 160)
;; (set-fontset-font
;;  nil 'japanese-jisx0208
;;  (font-spec :family "Ricty"))

(let* ((size 16)
           (asciifont "Ricty") ; ASCII fonts
           (jpfont "Ricty") ; Japanese fonts
           (h (* size 10))
           (fontspec (font-spec :family asciifont))
           (jp-fontspec (font-spec :family jpfont)))
      (set-face-attribute 'default nil :family asciifont :height h)
      (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
      (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
      (set-fontset-font nil 'katakana-jisx0201 jp-fontspec)
      (set-fontset-font nil '(#x0080 . #x024F) fontspec) 
      (set-fontset-font nil '(#x0370 . #x03FF) fontspec))




;; ;; 参考(パクリ):  http://sakito.jp/emacs/emacs23.html#id17
;; (when (>= emacs-major-version 23)
;;  (set-face-attribute 'default nil
;;                      :family "monaco"
;;                      :height 140)
;;  (set-fontset-font
;;   (frame-parameter nil 'font)
;;   'japanese-jisx0208
;;   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
;;  (set-fontset-font
;;   (frame-parameter nil 'font)
;;   'japanese-jisx0212
;;   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
;;  (set-fontset-font
;;   (frame-parameter nil 'font)
;;   'mule-unicode-0100-24ff
;;   '("monaco" . "iso10646-1"))
;;  (setq face-font-rescale-alist
;;       '(("^-apple-hiragino.*" . 1.2)
;;         (".*osaka-bold.*" . 1.2)
;;         (".*osaka-medium.*" . 1.2)
;;         (".*courier-bold-.*-mac-roman" . 1.0)
;;         (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
;;         (".*monaco-bold-.*-mac-roman" . 0.9)
;;         ("-cdac$" . 1.3))))


;; ;;; フォント設定(Xを使用 and Emacs 23 の場合のみ設定)
;; (cond ((and window-system (string-match "GNU Emacs 23\\." (emacs-version)))
;; ;;;        (set-default-font "Osaka－等幅-9")
;; ;;;        (set-fontset-font (frame-parameter nil 'font)
;; ;;; 			 'japanese-jisx0208
;; ;;; 			 '("Osaka－等幅-9" . "unicode-bmp"))))
;;        (set-default-font "Bitstream Vera Sans Mono-6")
;;        (set-fontset-font (frame-parameter nil 'font)
;;  			 'japanese-jisx0208
;;  			 '("VL ゴシック" . "unicode-bmp"))))
;; ;;;        (set-default-font "MeiryoKe-Gothic-6")
;; ;;;        (set-fontset-font (frame-parameter nil 'font)
;; ;;; 			 'japanese-jisx0208
;; ;;; 			 '("MeiryoKe_Gothic" . "unicode-bmp"))))

;;;; テスト用
;; (when (>= emacs-major-version 23)
;;  (set-face-attribute 'default nil
;;                      :family "monaco"
;;                      :height 140)
;;  (set-fontset-font
;;   (frame-parameter nil 'font)
;;   'japanese-jisx0208
;;   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
;;  (set-fontset-font
;;   (frame-parameter nil 'font)
;;   'japanese-jisx0212
;;   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
;;  (set-fontset-font
;;   (frame-parameter nil 'font)
;;   'mule-unicode-0100-24ff
;;   '("monaco" . "iso10646-1"))
;;  (setq face-font-rescale-alist
;;       '(("^-apple-hiragino.*" . 1.2)
;;         (".*osaka-bold.*" . 1.2)
;;         (".*osaka-medium.*" . 1.2)
;;         (".*courier-bold-.*-mac-roman" . 1.0)
;;         (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
;;         (".*monaco-bold-.*-mac-roman" . 0.9)
;;         ("-cdac$" . 1.3))))

;; テスト用2
;; (create-fontset-from-ascii-font "Menlo-14:weight=normal:slant=normal" nil "menlokakugo")
;; (set-fontset-font "fontset-menlokakugo"
;;                   'unicode
;;                   (font-spec :family "Hiragino Kaku Gothic ProN" :size 16)
;;                   nil
;;                   'append)
;; (add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))

;; テスト用3
;; (set-face-attribute 'default nil
;; 		    :family "Monaco"
;; 		    :height 140)
;; 		    ;:height 90)
;; (set-fontset-font "fontset-default"
;; 		  'japanese-jisx0208
;; 		  '("Osaka" . "iso10646-1"))
;; (set-fontset-font "fontset-default"
;; 		  'katakana-jisx0201
;; 		  '("Osaka" . "iso10646-1"))
;; (setq face-font-rescale-alist
;;       '((".*Monaco-bold.*" . 1.0)
;; 	(".*Monaco-medium.*" . 1.0)
;; 	(".*Osaka-bold.*" . 1.2)
;; 	(".*Osaka-medium.*" . 1.2)
;; 	("-cdac$" . 1.4)))



