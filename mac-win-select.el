

(defun mac-win-select ()
  "Next version of this function that attempts to use better keybindings
and add more contingencies for issues that have come up outside of my
standard window setup."
  (interactive)
  (let ((choice))
    ;; start here for ease of use
    (select-window (car (window-at-side-list nil 'left)))

    (setq choice (read-key-sequence
                  "[f]--topleft, [j]--topright, [TAB]--R, [r]--RE-Builder, [m]--minibuffer, [o]--other"))
    (cond
     ((string= choice "f")
      (select-window (car (window-at-side-list nil 'left))))

     ;; help, man, or R help, typically
     ((string= choice "j")
      (select-window (car (window-at-side-list nil 'right))))

     ;; R, typically
     ((string= (key-description (format "%s" choice)) "TAB")
      (select-window (car (reverse (window-at-side-list nil 'left)))))

     ;; RE_builder, typically
     ((string= choice "r")
      (select-window (car (cdr (window-at-side-list nil 'left)))))

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







