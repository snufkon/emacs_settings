
(defun count-words-buffer ()
 "Count the number of words in the current buffer.
print a message in the minibuffer with the result."
 (interactive)
  (let ((count 0))
    (save-excursion
      (goto-char (point-min))
      (while (< (point) (point-max))
	(forward-word 1)
	(setq count (1+ count)))
      (message "buffer contains %d words." count))))

(defun goto-percent (pct)
  "入力した値を％値としてバッファ中の指定位置に移動する."
  (interactive "nPercent: ")
  (goto-char (/ (* pct (point-max)) 100)))
goto-percent

