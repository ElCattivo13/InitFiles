;; init.el for Emacs 24
;;
;; Author: Stephan Böhme
;; 
;; Emacs Version: 24.3 (9.0)
;;
;; OS: Mac OS X El Capitan (10.11.3)
;;
;; last update: 2016-03-10
;;
;; ToDo: - tell RefTeX to look for bib files in the current directory
;;       - Dont ask for open processes when exiting
;;       - good color setting
;;       - Aspell personal dictionary
;;       - Magit -> word-diff=color
;;
;;
;; this init file is in a GIT repo, put this as the first an only line into your local
;; init.el at ~/.emacs.d/ :
;; (load "~/Documents/GIT/InitFiles/init.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General Setup                                                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; No Startup Screen
(setq inhibit-splash-screen t)


;; Add MELPA to package-archive
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)


;; check OS type
;; from http://ergoemacs.org/emacs/elisp_determine_OS_version.html
(cond

  ;; Microsoft Windows
  ((string-equal system-type "windows-nt")
    (progn
      (message "Microsoft Windows detected"))
    (menu-bar-mode -1)
    (setenv "%PATH%"
      (concat (getenv "%PATH%")
        ":e:/texlive/2016/bin/win32"))
    (add-to-list 'exec-path "e:/texlive/2016/bin/win32")
  )

  ;; Mac OS X
  ((string-equal system-type "darwin")
    (progn
      (message "Mac OS X detected"))

    ;; add /usr/texbin to PATH, so LaTeX compile works within Emacs
    (setenv "PATH" 				
      (concat (getenv "PATH")
        ":/usr/texbin"
        ":/usr/local/texlive/2013/bin/universal-darwin"))
    (add-to-list 'exec-path "/usr/texbin")
    (add-to-list 'exec-path "/usr/local/texlive/2013/bin/universal-darwin")
  )
  ((string-equal system-type "gnu/linux") ; linux
   (progn
     (message "Linux detected"))
  )
)

;; turn off any sound in Emacs
(setq ring-bell-function 'ignore)

;; hide ugly tool bar
(tool-bar-mode -1)

;; delete selected text, when typing
(delete-selection-mode t)

;; enable ido-mode
(ido-mode t)

;; Winner Mode
(when (fboundp 'winner-mode) (winner-mode 1))

;; add column position to mode line
(column-number-mode t)

;; In DocView Mode, view next page when at bottom of current one
(setq doc-view-continuous t)
(add-hook 'doc-view-mode-hook 'auto-revert-mode)


;; Always update buffer when associated file changes on disk
;(global-auto-revert-mode t)


;; Enter debug mode when error is encountered
;(setq debug-on-error t)

;; No scroll bars
(scroll-bar-mode -1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Workgroups2                                                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; https://github.com/pashinin/workgroups2/wiki/Configuration                            ;
                                                                                         ;
;; only when opened as App                                                               ;
(when (display-graphic-p)                                                                ;
                                                                                         ;
  (message "Loading workgroups2")                                                        ;
                                                                                         ;
  (require 'workgroups2)                                                                 ;
                                                                                         ;
  ;; Change prefix key (before activating WG)                                            ;
  (setq wg-prefix-key (kbd "C-z"))                                                       ;
  (setq wg-session-file "~/.emacs.d/myworkgroups.wg")                                    ;
  (setq wg-session-load-on-start t)                                                      ;
                                                                                         ;
  ;; What to do on Emacs exit / workgroups-mode exit?                                    ;
  (setq wg-emacs-exit-save-behavior           'save)      ; Options: 'save 'ask nil      ;
  (setq wg-workgroups-mode-exit-save-behavior 'save)      ; Options: 'save 'ask nil      ;
                                                                                         ;
  (add-hook 'workgroups-mode-hook 'wg-reload-session)                                    ;
)                                                                                        ;
                                                                                         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Color settings                                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					                                                 ;
(require 'color-theme-sanityinc-tomorrow)                                                ;
(load-theme 'sanityinc-tomorrow-night t)                                                 ;
                                                                                         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Key Settings                                                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Loading global key settings")                                                  ;
                                                                                         ;
;; mit Crtl-TAB zum nächsten Window springen                                             ;
;(global-set-key [M-tab] 'other-window)                                                  ;
                                                                                         ;
;; mit "Drucken" magit-status öffnen                                                     ;
(global-set-key [f13] 'magit-status)                                                     ;
(global-set-key [scroll] 'magit-status)                                                  ;
                                                                                         ;
                                                                                         ;
                                                                                         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Shell/Eshell Customization                                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                                                                         ;
;; set ZShell as default                                                                 ;
;(setq  explicit-shell-file-name '"/bin/zsh")                                            ;
                                                                                         ;
;; Emacs doesn't ask to kill active processes in eshell on exit                          ;
;(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)                ;
;  "Prevent annoying \"Active processes exist\" query when you quit Emacs."              ;
;  (flet ((process-list ())) ad-do-it))                                                  ;
                                                                                         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Smart Parens Minor Mode                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; https://www.emacswiki.org/emacs/EmacsLispMode                                         ;
(message "Loading smartparens")                                                          ;
                                                                                         ;
(require 'smartparens-config)                                                            ;
(smartparens-global-mode)                                                                ;
(show-smartparens-global-mode t)                                                         ;
                                                                                         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Selecting Lines Using Line Numbers                                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://www.emacswiki.org/emacs/LineNumbers                                            ;
;; click on left margin (line number) to select whole line                               ;
(message "Loading line-at-click")                                                        ;
                                                                                         ;
(defvar *linum-mdown-line* nil)                                                          ;
                                                                                         ;
(defun line-at-click ()                                                                  ;
  (save-excursion                                                                        ;
    (let ((click-y (cdr (cdr (mouse-position))))                                         ;
	  (line-move-visual-store line-move-visual))                                     ;
	  (setq line-move-visual t)                                                      ;
	  (goto-char (window-start))                                                     ;
	  (next-line (1- click-y))                                                       ;
	  (setq line-move-visual line-move-visual-store)                                 ;
	  ;; If you are using tabbar substitute the next line with                       ;
	  ;; (line-number-at-pos))))                                                     ;
	  (1+ (line-number-at-pos)))))                                                   ;
                                                                                         ;
(defun md-select-linum ()                                                                ;
  (interactive)                                                                          ;
  (goto-line (line-at-click))                                                            ;
  (set-mark (point))                                                                     ;
  (setq *linum-mdown-line*                                                               ;
		(line-number-at-pos)))                                                   ;
                                                                                         ;
(defun mu-select-linum ()                                                                ;
  (interactive)                                                                          ;
  (when *linum-mdown-line*                                                               ;
	(let (mu-line)                                                                   ;
	  ;; (goto-line (line-at-click))                                                 ;
	  (setq mu-line (line-at-click))                                                 ;
	  (goto-line (max *linum-mdown-line* mu-line))                                   ;
	  (set-mark (line-end-position))                                                 ;
	  (goto-line (min *linum-mdown-line* mu-line))                                   ;
	  (setq *linum-mdown*                                                            ;
			nil))))                                                          ;
                                                                                         ;
(global-set-key (kbd "<left-margin> <down-mouse-1>") 'md-select-linum)                   ;
(global-set-key (kbd "<left-margin> <mouse-1>") 'mu-select-linum)                        ;
(global-set-key (kbd "<left-margin> <drag-mouse-1>") 'mu-select-linum)                   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; emacs-lisp-mode-hook (auch für init.el)                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; more info: https://www.emacswiki.org/emacs/EmacsLispMode                              ;
(message "Loading emacs-lisp-mode-hook")                                                 ;
                                                                                         ;
(add-hook 'emacs-lisp-mode-hook                                                          ;
  (lambda () (linum-mode)                                                                ;
             (define-key emacs-lisp-mode-map                                             ;
	       (kbd "C-c C-c") 'comment-or-uncomment-region)))                           ;
                                                                                         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; text-mode-hook                                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                                                                         ;
;; sets autofill on in text mode automatically                                           ;
(setq text-mode-hook 'turn-on-auto-fill)                                                 ;
                                                                                         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Magit Settings                                                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					                                                 ;
;https://github.com/magit/magit/issues/1615                                              ;
;(setq magit-diff-options (list "--word-diff=color"))                                    ;
                                                                                         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LaTeX                                                                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Loading LaTeX specific settings")                                                   ;
                                                                                              ;
                                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
;; Basic AucTeX Setup                                                                   ;;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                         ;    ;
;(load "auctex.el" nil t t)  ;; not needed anymore                                       ;    ;
(setq TeX-auto-save t)                                                                   ;    ;
(setq TeX-save-query nil)                                                                ;    ;
                                                                                         ;    ;
(setq TeX-parse-self t)                                                                  ;    ;
                                                                                         ;    ;
;; nach Compile-Befehl werden Warnungen mit angezeigt                                    ;    ;
(setq TeX-debug-warnings t)                                                              ;    ;
                                                                                         ;    ;
;; nach Compile-Befehl werden BadBoxes mit angezeigt                                     ;    ;
(setq TeX-debug-bad-boxes t)                                                             ;    ;
                                                                                         ;    ;
;; scoll automtically with the compilation output                                        ;    ;
(setq compilation-scroll-output t)                                                       ;    ;
                                                                                         ;    ;
                                                                                         ;    ;
(setq-default TeX-master nil)       ; kein TeX Master File per default                   ;    ;
(setq TeX-PDF-mode t)               ; PDF statt DVI per default                          ;    ;
                                                                                         ;    ;
(add-hook 'LaTeX-mode-hook (lambda () (set-fill-column 100))) ; Zeilenumbruch            ;    ;
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)        ; nach 100 Zeichen                 ;    ;
(add-hook 'LaTeX-mode-hook 'visual-line-mode)         ; Word Wrap                        ;    ;
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)          ; Mathe Modus                      ;    ;
(add-hook 'LaTeX-mode-hook 'turn-on-font-lock)        ; Syntax Highlight                 ;    ;
(add-hook 'LaTeX-mode-hook (lambda () (linum-mode)))  ; Zeilennummern automatisch        ;    ;
                                                                                         ;    ;
(setq TeX-electric-sub-and-superscript t) ; automatische Klammern bei _ und ^            ;    ;
                                                                                         ;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                              ;
                                                                                              ;
                                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
;; My LaTeX Mode Key Bindings                                                           ;;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                         ;    ;
;; Save buffer and fold buffer                                                           ;    ;
;(defun latex-fold-and-save() (interactive)                                              ;    ;
;    (save-buffer)                                                                       ;    ;
;    (TeX-fold-buffer)                                                                   ;    ;
;)                                                                                       ;    ;
                                                                                         ;    ;
;; automatically folds all code before compiling                                         ;    ;
(defun latex-my-master() (interactive)                                                   ;    ;
       (TeX-fold-buffer)                                                                 ;    ;
       (TeX-command-run-all nil)                                                         ;    ;
   ;; (TeX-command-master)                                                               ;    ;
   ;; (let ((latexmk-process (get-process "latexmk")))                                   ;    ;
   ;;   (when latexmk-process                                                            ;    ;
   ;; 	(set-process-query-on-exit-flag latexmk-process nil)))                           ;    ;
   ;(TeX-recenter-output-buffer)                                                         ;    ;
)                                                                                        ;    ;
                                                                                         ;    ;
;; Bind keys in LaTeX mode                                                               ;    ;
(defun latex-my-bindings ()                                                              ;    ;
    (define-key LaTeX-mode-map (kbd "<f5>") 'latex-my-master)                            ;    ;
    (define-key LaTeX-mode-map (kbd "<f6>") 'latex-fold-and-save)                        ;    ;
    (define-key LaTeX-mode-map (kbd "<f7>") 'TeX-previous-error)                         ;    ;
    (define-key LaTeX-mode-map (kbd "<f8>") 'TeX-next-error)                             ;    ;
    ;(define-key LaTeX-mode-map (kbd "<f6>") 'TeX-view)                                  ;    ;
    (define-key LaTeX-mode-map (kbd "C-c C-c") 'TeX-comment-or-uncomment-region)         ;    ;
)                                                                                        ;    ;
                                                                                         ;    ;
(add-hook 'LaTeX-mode-hook 'latex-my-bindings)                                           ;    ;
                                                                                         ;    ;
(add-hook 'TeX-output-mode-hook                                                          ;    ;
    (lambda ()                                                                           ;    ;
      (define-key TeX-special-mode-map (kbd "M-SPC") 'end-of-buffer)                     ;    ;
      (define-key TeX-special-mode-map (kbd "SPC")   'scroll-down-command)))             ;    ;
                                                                                         ;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
					;

;; (require 'tex)
;; (TeX-add-style-hook
;;  "preamble-thesis"
;;  (lambda ()
;;    (TeX-run-style-hooks
;;     "amsmath")
;;    (LaTeX-add-environments
;;     '("definition" LaTeX-env-label)
;;     '("claim")
;;     )
;;    )


;;  )






                                                                                              ;
                                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
;; Spellchecking                                                                        ;;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                         ;    ;
;; get Aspell to work and enable flyspell                                                ;    ;
;(setq ispell-program-name "/opt/local/bin/aspell"                                       ;    ;
(setq ispell-program-name "/usr/local/bin/aspell"                                        ;    ;
      ispell-dictionary "english"                                                        ;    ;
;      ispell-personal-dictionary "/Users/boehme/Library/Preferences/cocoAspell/LocalDictionary.pws"         
      ispell-dictionary-alist                                                            ;    ;
      (let ((default '("[A-Za-z]" "[^A-Za-z]" "[']" nil                                  ;    ;
                       ("-B" "-d" "english" "--dict-dir"                                 ;    ;
                        "/Library/Application\ Support/cocoAspell/aspell6-en-6.0-0")     ;    ;
                       nil iso-8859-1)))                                                 ;    ;
        `((nil ,@default)                                                                ;    ;
          ("english" ,@default))))                                                       ;    ;
                                                                                         ;    ;
;; activate flyspell automatically when entering latex mode                              ;    ;
(add-hook 'LaTeX-mode-hook (lambda () (flyspell-mode)))                                  ;    ;
                                                                                         ;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                              ;
                                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
;; RefTeX                                                                               ;;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                         ;    ;
(add-hook 'LaTeX-mode-hook (lambda () (turn-on-reftex)))                                 ;    ;
(setq reftex-plug-into-AUCTeX t)                                                         ;    ;
                                                                                         ;    ;
; Status quo: \addbibresource in main.tex wird erkannt, falls die bib über preamble.sty  ;    ;
; geladen wird, muss local variable gesetzt werden                                       ;    ;
                                                                                         ;    ;
                                                                                         ;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                              ;
                                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
;; Math Symbols with F12                                                                ;;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                         ;    ;
;; Prefix um Mathesymole einzugeben: -> [F12]+a => \alpha                                ;    ;
(setq LaTeX-math-abbrev-prefix (kbd "<f12>"))                                            ;    ;
(setq LaTeX-math-list '(("<left>" "leftarrow" nil nil)                                   ;    ;
			("<right>" "rightarrow" nil nil)                                 ;    ;
			("<down>" "leftrightarrow" nil nil)                              ;    ;
			("S-<leftt>" "Leftarrow" nil nil)                                ;    ;
			("S-<right>" "Rightarrow" nil nil)                               ;    ;
			("S-<down>" "Leftrightarrow" nil nil)                            ;    ;
			("=" "coloneqq" nil nil)                                         ;    ;
			("f" "varphi" nil nil)                                           ;    ;
			("[" "sqsubseteq" nil nil)                                       ;    ;
			("{" "subseteq" nil nil)                                         ;    ;
			("+" "sqcup" nil nil)                                            ;    ;
			("-" "sqcap" nil nil)                                            ;    ;
			("e" "varepsilon" nil nil)                                       ;    ;
			("." "ldots" nil nil)                                            ;    ;
			("," "cdot" nil nil)))                                           ;    ;
                                                                                         ;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                              ;
                                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
;; Additional Code Folding Symbols                                                      ;;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                         ;    ;
(eval-after-load "latex"                                                                 ;    ;
 '(progn                                                                                 ;    ;
    (setq LaTeX-fold-math-spec-list                                                      ;    ;
      (append                                                                            ;    ;
       '((":=" ("coloneqq"))                                                             ;    ;
         ("::=" ("Coloneqq"))                                                            ;    ;
         ("|" ("oder"))                                                                  ;    ;
         ("[foo]" ("foo"))                                                               ;    ;
         ("∧" ("land"))                                                                  ;    ;
         ("∨" ("lor"))                                                                   ;    ;
         ("⊔" ("sqcup"))                                                                 ;    ;
         ("⊓" ("sqcap"))                                                                 ;    ;
         ("↳" ("itemarrow"))                                                             ;    ;
         ("↳" ("follows"))                                                               ;    ;
	 ("T" ("true"))                                                                  ;    ;
	 ("F" ("false"))                                                                 ;    ;
	 ("|" ("concat"))                                                                ;    ;
	 ("~" ("negnnf"))                                                                ;    ;
	 ("¬" ("lnot"))                                                                  ;    ;
        ) LaTeX-fold-math-spec-list))                                                    ;    ;
    (setq LaTeX-fold-macro-spec-list                                                     ;    ;
      (append                                                                            ;    ;
       '(("BOOM" ("boom"))                                                               ;    ;
	 (1  ("cite"))                                                                   ;    ;
	 (1  ("ref" "pageref" "eqref"))                                                  ;    ;
	) LaTeX-fold-macro-spec-list))                                                   ;    ;
))                                                                                       ;    ;
                                                                                         ;    ;
(add-hook 'LaTeX-mode-hook (lambda () (TeX-fold-mode t)                                  ;    ;
			              (TeX-fold-buffer)))                                ;    ;
                                                                                         ;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                              ;
                                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
;; TeX-Master Clean and CleanAll                                                        ;;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                         ;    ;
;; don't ask when deleting intermediate files                                            ;    ;
(setq TeX-clean-confirm nil)                                                             ;    ;
                                                                                         ;    ;
;; add these suffixes to list of intermediate files                                      ;    ;
(add-hook 'LaTeX-mode-hook                                                               ;    ;
  (lambda ()                                                                             ;    ;
    (setq LaTeX-clean-intermediate-suffixes                                              ;    ;
      (append LaTeX-clean-intermediate-suffixes                                          ;    ;
       '("\\.tdo"                                                                        ;    ;
	 "\\.upa"                                                                        ;    ;
	 "\\.upb"                                                                        ;    ;
	 "\\.fls"                                                                        ;    ;
	 "\\.fdb_latexmk")))))                                                           ;    ;
                                                                                         ;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                              ;
                                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
;; Delete Biber Cache                                                                   ;;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                         ;    ;
;; Delete cache of biber, sometimes solves biber compiling problems                      ;    ;
(add-hook 'LaTeX-mode-hook (lambda ()                                                    ;    ;
  (push                                                                                  ;    ;
   '("BiberDeleteCache" "biber --cache | xargs rm -rfv" TeX-run-TeX nil t                ;    ;
     :help "Delete cache of Biber")                                                      ;    ;
   TeX-command-list)))                                                                   ;    ;
                                                                                         ;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                              ;
                                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
;; Outline Minor Mode                                                                   ;;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                         ;    ;
(add-hook 'LaTeX-mode-hook (lambda() (outline-minor-mode t)))                            ;    ;
                                                                                         ;    ;
(add-hook 'outline-minor-mode-hook                                                       ;    ;
          (lambda ()                                                                     ;    ;
            (require 'outline-magic)                                                     ;    ;
            (define-key outline-minor-mode-map [C-tab] 'outline-cycle)))                 ;    ;
                                                                                         ;    ;
                                                                                         ;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                              ;
                                                                                              ;
                                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
;; Synctex with Skim                                                                    ;;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                         ;    ;
;; only when opened as App                                                               ;    ;
(when (display-graphic-p)                                                                ;    ;
                                                                                         ;    ;
  ;; make latexmk available via C-c C-c                                                  ;    ;
  ;; Note: SyncTeX is setup via ~/.latexmkrc (see below)                                 ;    ;
  (add-hook 'LaTeX-mode-hook (lambda ()                                                  ;    ;
    (push                                                                                ;    ;
     '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t                                     ;    ;
       :help "Run latexmk on file")                                                      ;    ;
     TeX-command-list)))                                                                 ;    ;
  ;(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))           ;    ;
                                                                                         ;    ;
  ;; use Skim as default pdf viewer                                                      ;    ;
  ;; Skim's displayline is used for forward search (from .tex to .pdf)                   ;    ;
  ;; option -b highlights the current line; option -g opens Skim in the background       ;    ;
  (setq TeX-view-program-selection '((output-pdf "PDF Viewer")))                         ;    ;
  (setq TeX-view-program-list                                                            ;    ;
    '(("PDF Viewer"                                                                      ;    ;
       "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b"        ;    ;
       )))                                                                               ;    ;
                                                                                         ;    ;
  (server-start); start emacs in server mode so that skim can talk to it                 ;    ;
)                                                                                        ;    ;
                                                                                         ;    ;
;;;; For reference, here my .latexmkrc                                                   ;    ;
;; # my latexmk configuration file - last update: 2016-03-13                             ;    ;
                                                                                         ;    ;
;; $pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';                     ;    ;
;; $pdf_mode = 1; # generate pdf via pdflatex                                            ;    ;
;; $postscript_mode = $dvi_mode = 0;                                                     ;    ;
                                                                                         ;    ;
;; $preview_continuous_mode = 1;                                                         ;    ;
;; #$force_mode = 1;                                                                     ;    ;
                                                                                         ;    ;
;; $pdf_previewer = "open -a /Applications/Skim.app -g %S"; #default for OS-X systems    ;    ;
;; $clean_ext = 'bbl rel %R-blx.bib %R.synctex.gz';                                      ;    ;
                                                                                         ;    ;
                                                                                         ;    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;
                                                                                              ;
                                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Workgroups                                                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (display-graphic-p)
  (workgroups-mode 1)        ; put this one at the bottom of .emacs
)










;;;;; ;;   ;; ;;;;;     ;;;;  ;;;;;   ;;;;; ;; ;;    ;;;;;
;;    ;;;  ;; ;;  ;;   ;;  ;; ;;      ;;    ;; ;;    ;;
;;;;  ;; ; ;; ;;  ;;   ;;  ;; ;;;;    ;;;;  ;; ;;    ;;;;
;;    ;;  ;;; ;;  ;;   ;;  ;; ;;      ;;    ;; ;;    ;;
;;;;; ;;   ;; ;;;;;     ;;;;  ;;      ;;    ;; ;;;;; ;;;;;











;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DACHBODEN, nur auskommentierte Reste ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; only a single buffer for dired mode
;(require 'dired-single)

;; or you can load the package via autoload:

;;     (autoload 'dired-single-buffer "dired-single" "" t)
;;     (autoload 'dired-single-buffer-mouse "dired-single" "" t)
;;     (autoload 'dired-single-magic-buffer "dired-single" "" t)
;;     (autoload 'dired-single-toggle-buffer-name "dired-single" "" t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ShowHide Mode                                                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (defvar hs-special-modes-alist
;;   (mapcar 'purecopy
;;   '((c-mode "{" "}" "/[*/]" nil nil)
;;     (c++-mode "{" "}" "/[*/]" nil nil)
;;     (bibtex-mode ("@\\S(*\\(\\s(\\)" 1))
;;     (java-mode "{" "}" "/[*/]" nil nil)
;;     ;(latex-mode "{*}" "/[*/]" nil nil)
;;     (js-mode "{" "}" "/[*/]" nil))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; special-buffer-behaviour
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (add-to-list 'special-display-buffer-names '("*magit-process*" my-display-magit-process))
;; (defun my-display-magit-process (buf)
;;   "put the *magit-process* buffer in the right spot"
;;   (let ((windows (delete (minibuffer-window) (window-list))))
;;     (if (eq 1 (length windows))
;;         (progn 
;;           (select-window (car windows))
;;           (split-window-vertically)))
;;     (let ((target-window (window-at 0 (- (frame-height) 2)))
;;           (pop-up-windows t))
;;       (set-window-buffer target-window buf)
;;       target-window)))
