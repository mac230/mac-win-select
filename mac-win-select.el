;; my function for selecting windows ala 'avy-window'

(defun mac-win-select ()
  "Next version of this function that attempts to use better
keybindings and add more contingencies for issues that have come
up outside of my standard window setup."
  (interactive)
  (let ((choice))
    
    ;; start here for ease of use
    (select-window (car (window-at-side-list nil 'left)))

    (setq choice
          (format "%s" (key-description
                        (read-key-sequence
                         (concat
                          (propertize  "Which window:   " 'face '(italic default))
                          (propertize  "f:" 'face '(bold default)) " top left      "
                          (propertize  "j:" 'face '(bold default)) " top right      "
                          (propertize  "o:" 'face '(bold default)) " other   "
                          (propertize  "m:" 'face '(bold default)) " minibuffer\n                "
                          (propertize  "d:" 'face '(bold default)) " middle left   "
                          (propertize  "k:" 'face '(bold default)) " middle right\n                "
                          (propertize  "s:" 'face '(bold default)) " bottom right  "
                          (propertize  "l:" 'face '(bold default)) " bottom left"))))) 

    (cond
     ((string= choice "f")
      (select-window (car (window-at-side-list nil 'left))))

     ((string= choice "j")
      (select-window (car (window-at-side-list nil 'right))))

     ((string= choice "d")
      (select-window (car (cdr (window-at-side-list nil 'left)))))

     ((string= choice "k")
      (select-window (car (cdr (window-at-side-list nil 'right)))))

     ((string= choice "s")
      (select-window (car (nthcdr 2 (window-at-side-list nil 'left)))))

     ((string= choice "l")
      (select-window (car (nthcdr 2 (window-at-side-list nil 'right)))))

     ;; minibuffer window
     ((string= choice "m")
      (select-window (minibuffer-window)))

     ;; something else
     ((string= choice "o")
      (while
          (string= choice "o")
        (progn
          (other-window 1)
          (setq choice (read-key-sequence "key: ")))))

     ;; default to top left window under most circumstances
     (t
      (select-window (car (window-at-side-list nil 'left)))))
    (message "")
    ))

(global-set-key (kbd "C-'") 'mac-win-select)
