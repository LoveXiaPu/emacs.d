(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (dichromacy)))
 '(custom-safe-themes
   (quote
    ("1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default)))
 '(display-time-mode t)
 '(fci-rule-color "#373b41")
 '(menu-bar-mode nil)
 '(safe-local-variable-values
   (quote
    ((no-byte-compile t)
     (ruby-compilation-executable . "ruby")
     (ruby-compilation-executable . "ruby1.8")
     (ruby-compilation-executable . "ruby1.9")
     (ruby-compilation-executable . "rbx")
     (ruby-compilation-executable . "jruby"))))
 '(session-use-package t nil (session))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#cc6666")
     (40 . "#de935f")
     (60 . "#f0c674")
     (80 . "#b5bd68")
     (100 . "#8abeb7")
     (120 . "#81a2be")
     (140 . "#b294bb")
     (160 . "#cc6666")
     (180 . "#de935f")
     (200 . "#f0c674")
     (220 . "#b5bd68")
     (240 . "#8abeb7")
     (260 . "#81a2be")
     (280 . "#b294bb")
     (300 . "#cc6666")
     (320 . "#de935f")
     (340 . "#f0c674")
     (360 . "#b5bd68"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;--------------设置有用的个人信息---------------
(setq user-full-name "cui yong")
(setq user-mail-address "cysyz1229@163.com")

;; 启用时间显示设置，在minibuffer上面的那个杠上
(display-time-mode t)

;;使用24小时制
(setq display-time-24hr-format t)

;; 扩大或者缩小窗口（上下）,Ctrl+{}
(global-set-key (kbd "C-}") 'enlarge-window)
(global-set-key (kbd "C-{") 'shrink-window)

;;我要显示匹配的括号
(show-paren-mode t)


;; -----------------------------------------------------------------------------
;; mac系统字体配置
;; -----------------------------------------------------------------------------
;; Setting 英文字体
(set-face-attribute
 'default nil :font "Monaco 12")
;; Setting 中文字体
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "Kaiti SC" :size 14)))
;; Note: you can chang "Kaiti SC" to "Microsoft YaHei" or other fonts

;;文件左侧显示行号 2016-03-03 15:22:28
(global-linum-mode t)

;; 显示行列号,它显示在OBminibuffer上面那个杠上
(setq column-number-mode t)
(setq line-number-mode t)

;; 配置 plantuml 过程开始
;; active Org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (plantuml . t)))

(setq org-plantuml-jar-path
      (expand-file-name "/Users/cuiyong/.emacs.d/plantuml/plantuml.jar"))
;; 配置 plantuml 过程结束

;; org-mode use org-indent-mode by default
;;(setq org-startup-indented t)
;; org-mode中添加一个新的链接类型 begin
(defun org-custom-link-img-follow (path)
  (org-open-file-with-emacs
   (format "" path)))

(defun org-custom-link-img-export (path desc format)
  (cond
   ((eq format 'html)
    (format "<img src=\"/static/images/%s\" alt=\"%s\"/>" path desc))))

(org-add-link-type "img" 'org-custom-link-img-follow 'org-custom-link-img-export)
;; org-mode中添加一个新的链接类型 end

;;设置org-mode缩进模式
(setq org-startup-indented t)

;; 配置生成 pdf 开始
(require 'org-install)
;; when export to latex, use minted, rather then listings
(setq org-latex-listings 'minted)
(add-to-list 'org-latex-packages-alist '("" "minted"))

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/texlive/2014/bin/x86_64-darwin/"))

(setq exec-path (append exec-path '("/usr/local/texlive/2014/bin/x86_64-darwin/")))

(setq org-latex-pdf-process '("xelatex --shell-escape -Interaction nonstopmode %f"
                              "xelatex --shell-escape -interaction nonstopmode %f"))

;; add frame and line number for source code(using minted)
(setq org-latex-minted-options
      '(("frame" "single")
        ("linenos" "true")))


;; Specify default packages to be included in every tex file, whether pdflatex or xelatex
(setq org-latex-default-packages-alist
      '(("" "graphicx" t)
        ("" "longtable" nil)
        ("" "float" nil)))

(defun my-auto-tex-parameters (backend)
  "Automatically select the tex packages to include."
  ;; default packages for ordinary latex or pdflatex export
  (setq org-latex-default-packages-alist
        '(("AUTO" "inputenc" t)
          ("T1"   "fontenc"   t)
          (""     "fixltx2e"  nil)
          (""     "wrapfig"   nil)
          (""     "soul"      t)
          (""     "textcomp"  t)
          (""     "marvosym"  t)
          (""     "wasysym"   t)
          (""     "latexsym"  t)
          (""     "amssymb"   t)
          ("" "fontspec" t)
          ("" "xunicode" t)
          ("" "url" t)
          ("" "rotating" t)
          ("american" "babel" t)
          ("babel" "csquotes" t)
          ("" "soul" t)
          ("xetex" "hyperref" t)
          (""     "hyperref"  nil)))
  (set 'org-export-latex-classes
       '("article"
         "\\documentclass[10pt,a4paper]{article}
\\usepackage{fontspec,xunicode,xltxtra}
\\setmainfont[BoldFont=Adobe Heiti Std]{Adobe Song Std}
\\setsansfont[BoldFont=Adobe Heiti Std]{AR PL UKai CN}
\\setmonofont{Bitstream Vera Sans Mono}
\\newcommand\\fontnamemono{AR PL UKai CN}%等宽字体
\\newfontinstance\\MONO{\\fontnamemono}
\\newcommand{\\mono}[1]{{\\MONO #1}}
\\setCJKmainfont[Scale=0.9]{Adobe Heiti Std}%中文字体
\\setCJKmonofont[Scale=0.9]{Adobe Heiti Std}
\\hypersetup{unicode=true}
\\geometry{a4paper, textwidth=6.5in, textheight=10in,
marginparsep=7pt, marginparwidth=.6in}
\\definecolor{foreground}{RGB}{220,220,204}%浅灰
\\definecolor{background}{RGB}{62,62,62}%浅黑
\\definecolor{preprocess}{RGB}{250,187,249}%浅紫
\\definecolor{var}{RGB}{239,224,174}%浅肉色
\\definecolor{string}{RGB}{154,150,230}%浅紫色
\\definecolor{type}{RGB}{225,225,116}%浅黄
\\definecolor{function}{RGB}{140,206,211}%浅天蓝
\\definecolor{keyword}{RGB}{239,224,174}%浅肉色
\\definecolor{comment}{RGB}{180,98,4}%深褐色
\\definecolor{doc}{RGB}{175,215,175}%浅铅绿
\\definecolor{comdil}{RGB}{111,128,111}%深灰
\\definecolor{constant}{RGB}{220,162,170}%粉红
\\definecolor{buildin}{RGB}{127,159,127}%深铅绿
\\punctstyle{kaiming}
\\title{}
\\fancyfoot[C]{\\bfseries\\thepage}
\\chead{\\MakeUppercase\\sectionmark}
\\pagestyle{fancy}
\\tolerance=1000
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
)
                                        ;(add-hook 'org-export-latex-after-initial-vars-hook 'my-auto-tex-parameters)
(add-hook 'org-export-before-parsing-hook 'my-auto-tex-parameters)

;; 配置生成 pdf 结束


;; 配置截图 开始
;;;  image for org-mode
;;;1. suspend current emacs window
;;;2. call scrot to capture the screen and save as a file in $HOME/.emacs.img/
;;;3. put the png file reference in current buffer, like this:  [[/home/path/.emacs.img/1q2w3e.png]]

(add-hook 'org-mode-hook 'iimage-mode) ; enable iimage-mode for org-mode
(defun my-screenshot ()
  "Take a screenshot into a unique-named file in the current buffer file
  directory and insert a link to this file."
  (interactive)
  (setq filename
        (concat (make-temp-name
                 (concat  (getenv "HOME") "/images/" ) ) ".png"))

  (if (file-accessible-directory-p (concat (file-name-directory
                                            (buffer-file-name)) "images/"))
      : nil
      : (make-directory "images"))
  (call-process-shell-command (concat "screencapture -i \"" filename "\"" ) nil nil nil nil )
  (insert (concat "[[" filename "]]"))
  (org-display-inline-images)
  )

(global-set-key (kbd "C-x p") 'my-screenshot)
;; 配置截图 结束

;;; 配置窗体的标题 开始
(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
            '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))
;;; 配置窗体的标题 结束

;;插入当前时间
(defun insert-current-time ()
  "Insert the current time"
  (interactive "*")
  (insert (format-time-string "%Y-%m-%d %H:%M:%S" (current-time))))
(global-set-key "\C-xt" 'insert-current-time)

;; org mode 下划线禁止转义
(setq org-export-with-sub-superscripts '{})
;;; (add-hook 'after-make-frame-functions 'init-window-frame)
;;; (add-hook 'after-init-hook 'init-window-frame)
(defun dump-vars-to-file (varlist filename)
  "simplistic dumping of variables in VARLIST to a file FILENAME"
  (save-excursion
    (let ((buf (find-file-noselect filename)))
      (set-buffer buf)
      (erase-buffer)
      (dump varlist buf)
      (save-buffer)
      (kill-buffer)
      )))


(defun get-plantuml ()
  (interactive)
  (save-excursion
    (search-forward "#+END_SRC")
    (beginning-of-line)
    (let ((end (point)))
      (search-backward "#+BEGIN_SRC plantuml")

      (end-of-line)

      (let ((start (point))
            (line-string (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
            )
        (let ((get-plantuml-desc (buffer-substring-no-properties start end))
              (plantuml-file-name (replace-regexp-in-string "#\\+BEGIN_SRC plantuml :file \\([a-zA-Z0-9_/\\.]+\\)\.svg" "\\1" line-string))
              )

          (write-string-to-file (concat "@startuml\n" get-plantuml-desc "\n@enduml")  (concat plantuml-file-name ".puml") )
          (call-process-shell-command (concat "java -jar " org-plantuml-jar-path  " -charset utf-8 -tsvg \"" plantuml-file-name ".puml\" " ))
          (call-process-shell-command (concat "open -a Gapplin " plantuml-file-name ".svg") )
          )
        )
      )
    )
  )

;; Smart copy, if no region active, it simply copy the current whole line
(defadvice kill-line (before check-position activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode js-mode
                                latex-mode plain-tex-mode))
      (if (and (eolp) (not (bolp)))
          (progn (forward-char 1)
                 (just-one-space 0)
                 (backward-char 1)))))

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end))
                 (message "Copied line")
                 (list (line-beginning-position)
                       (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

;; Copy line from point to the end, exclude the line break
(defun qiang-copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (point)
                  (line-end-position))
  ;; (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(global-set-key (kbd "M-k") 'qiang-copy-line)

(defun indent-whole ()
  (interactive)
  (indent-region (point-min) (point-max))
  (message "format successfully"))
;;绑定到F7键
(global-set-key [f7] 'indent-whole)

;;shell相关配置 开始
;; 配置 outline-minor-mode中标识为标题的前缀 开始
(defun set-outline-minor-mode-regexp ()
  ""
  (let ((find-regexp
         (lambda
           (lst mode)
           ""
           (let
               ((innerList
                 (car lst)))
             (if innerList
                 (if
                     (string=
                      (car innerList)
                      mode)
                     (car
                      (cdr innerList))
                   (progn
                     (pop lst)
                     (funcall find-regexp lst mode))))))))
    (outline-minor-mode 1)
    (make-local-variable 'outline-regexp)
    (setq outline-regexp (funcall find-regexp outline-minor-mode-list major-mode))))

(add-hook 'shell-mode-hook      'set-outline-minor-mode-regexp t )
(add-hook 'eshell-mode-hook      'set-outline-minor-mode-regexp t )
(add-hook 'sh-mode-hook         'set-outline-minor-mode-regexp t )
(add-hook 'emacs-lisp-mode-hook 'set-outline-minor-mode-regexp t )
(add-hook 'perl-mode-hook       'set-outline-minor-mode-regexp t )

(setq outline-minor-mode-list
      (list '(emacs-lisp-mode "(defun")
            '(shell-mode ".*[bB]ash.*[#\$] ")
            '(eshell-mode "^.*\s[#\$]\s")
            '(sh-mode "function .*{")
            '(perl-mode "sub ")

            ))
;; 配置 outline-minor-mode中标识为标题的前缀 结束
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)

(autoload 'bash-completion-dynamic-complete
  "bash-completion"
  "BASH completion hook")

(add-hook 'shell-dynamic-complete-functions
          'bash-completion-dynamic-complete)
;;shell相关配置 结束

;; org mode 相关配置 开始
;;配置所有org文件中的可选tags值
(setq org-tag-alist '(

                      (:startgroup . nil)
                      ("桌面" . ?d) ("服务器" . ?s)
                      (:endgroup . nil)
                      ("编辑器" . ?e)
                      ("浏览器" . ?f)
                      ("多媒体" . ?m)
                      ))

;; 此函数目前并不起效 2016-03-03 17:09:46
(defun zin/org-tag-match-context (&optional todo-only match)
  "Identical search to `org-match-sparse-tree', but shows the content of the matches only."
  (interactive "P")
  (org-agenda-prepare-buffers (list (current-buffer)))
  (org-overview)
  (org-remove-occur-highlights)
  (org-scan-tags '(progn (org-show-entry)
                         (org-show-context))
                 (cdr (org-make-tags-matcher match)) todo-only))
;; org mode 相关配置 结束
