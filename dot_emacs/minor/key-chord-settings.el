;;;; Emacs テクニックバイブル 3.9
(require 'key-chord)
(setq key-chord-two-keys-delay 0.04)
(key-chord-mode 1)

;;;; グローバルキーマップへの設定 ----------------------------------------------
(key-chord-define-global "jk" 'org-remember)
(key-chord-define-global "ui" 'mac-toggle-max-window) ; ウィンドウを最大化

