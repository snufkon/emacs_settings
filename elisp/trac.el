;;; trac.el --- Trac client interface for Emacs

;; Copyright (C) 2008  TSUNOI Taku

;; Author: TSUNOI Taku <tsunoi@adin.co.jp>
;; Keywords: 

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; 
;;(defvar trac-home "/home/projects/trac")
(defvar trac-home "/var/trac")
(defvar trac-project "")
(defvar trac-db-path "db/trac.db")
(defvar sqlite-cmd "sqlite3")

;;; Code:

; DBのパス
(defun trac-db ()
  (concat trac-home "/" trac-project "/" trac-db-path))

; 左シフト(<<)
(defun left-shift (x len)
  (if (= len 0)
      x
    (left-shift (* x 2) (- len 1))))

; 現在時刻のtime_t文字列取得
; INTEGERの桁数が足りないのでいちどfloatに変換している
(defun trac-get-time-string ()
  (let ((ctime (current-time)))
    (format "%.0f" (+ (left-shift (float (car ctime)) 16) (car (cdr ctime))))))

; チケット追加のSQL文字列
(defun trac-add-ticket-sql (column-lis value-lis)
  (defun lis-str (lis s sep)
    (if (null lis)
        s
      (lis-str (cdr lis) (concat s (if (string= s "") "" sep) (car lis)) sep)))
  (let ((column-str (lis-str column-lis "" ","))
        (value-str (lis-str value-lis "" ",")))
    (concat "insert into ticket (" column-str ") values (" value-str ")")))

; チケット追加
(defun trac-add-ticket ()
  (interactive)
  (setq trac-project (read-string "Trac Project: " trac-project))
  (let ((reporter (read-string "reporter: " user-full-name))
        (summary (read-string "summary: " ""))
        (time (trac-get-time-string)))
    (defun strval (s) (concat "'" s "'"))
    (call-process sqlite-cmd nil t nil
                  (trac-db)
                  (trac-add-ticket-sql (list "reporter"
                                             "summary"
                                             "status"
                                             "time"
                                             "changetime")
                                       (list (strval reporter)
                                             (strval summary)
                                             (strval "new")
                                             time
                                             time)))))


(provide 'trac)
;;; trac.el ends here
