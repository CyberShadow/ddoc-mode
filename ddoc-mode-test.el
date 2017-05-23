;;; ddoc-mode-test.el --- Tests for ActionScript assembly major mode

;;; Commentary:

;;; Code:

(require 'ddoc-mode nil t)

(require 'htmlfontify)

(defun ddoc-mode-test-read-file (name)
  "Read file NAME and return it as a string."
  (with-temp-buffer
    (insert-file-contents name)
    (buffer-string)))

(defun ddoc-mode-test-htmlize-file (name)
  "Read file NAME, fontify it and return the HTML as a string."
  (save-current-buffer
    (find-file name)
    (let ((hfy-optimisations (list 'body-text-only 'merge-adjacent-tags)))
      (with-current-buffer (htmlfontify-buffer) (buffer-string)))))

(ert-deftest ddoc-mode-test-fontification ()
  (should
   (equal
    (ddoc-mode-test-htmlize-file "test.ddoc")
    (ddoc-mode-test-read-file "test.ddoc.html"))))

;;----------------------------------------------------------------------------

(provide 'ddoc-mode-test)

;;; ddoc-mode-test.el ends here
