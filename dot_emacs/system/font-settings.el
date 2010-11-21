;;;; フォントに関する設定 ======================================================
;;; フォント設定(Xを使用 and Emacs 23 の場合のみ設定)
(cond ((and window-system (string-match "GNU Emacs 23\\." (emacs-version)))
;;;        (set-default-font "Osaka－等幅-9")
;;;        (set-fontset-font (frame-parameter nil 'font)
;;; 			 'japanese-jisx0208
;;; 			 '("Osaka－等幅-9" . "unicode-bmp"))))
       (set-default-font "Bitstream Vera Sans Mono-6")
       (set-fontset-font (frame-parameter nil 'font)
 			 'japanese-jisx0208
 			 '("VL ゴシック" . "unicode-bmp"))))
;;;        (set-default-font "MeiryoKe-Gothic-6")
;;;        (set-fontset-font (frame-parameter nil 'font)
;;; 			 'japanese-jisx0208
;;; 			 '("MeiryoKe_Gothic" . "unicode-bmp"))))
