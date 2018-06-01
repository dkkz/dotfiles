;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

;; 列数を表示する
(column-number-mode t)

;; 行数を表示する
(global-linum-mode t)

(set-face-attribute 'linum nil
  :foreground "#a9a9a9"
  :background "#404040"
  :height 0.9)

;; 改行コードを表示する
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; バックアップファイルを作成させない
(setq make-backup-files nil)

;; 終了時にオートセーブファイルを削除する
(setq auto-save-default nil)

; ;; load-path で ~/.emacs.d とか書かなくてよくなる
; (when load-file-name
;   (setq user-emacs-directory (file-name-directory load-file-name)))
;
; ;; el-get
; (add-to-list 'load-path (locate-user-emacs-file "el-get"))
; (require 'el-get)
; ;; el-getでダウンロードしたパッケージは ~/.emacs.d/ に入るようにする
; (setq el-get-dir (locate-user-emacs-file ""))
;
; ;; auto-complage
; (el-get-bundle auto-complete)
