;; Install this file as being in the emacs config directory
(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))

;; Install 'straight.el' for package management
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(prin1 "Starting tilemacs initialization...")

;; --- Initialize Tilemacs ---
(defvar tilemacs-modules
  (list
   ;;; External Modules
    '((symbol . f)
     (is-external . true)
     (hook . nil))

    '((symbol . company)
     (is-external . true)
     (hook . "company.el"))

    '((symbol . which-key)
     (is-external . true)
     (hook . "which-key.el"))
    
    '((symbol . doom-themes)
     (is-external . true)
     (hook . "theme.el"))
    
    '((symbol . awesome-tab)
     (is-external . true)
     (hook . "tabs.el"))
    
    '((symbol . flycheck)
     (is-external . true)
     (hook . nil))
    
    '((symbol . flycheck-pos-tip)
     (is-external . true)
     (hook . nil))
    
    '((symbol . treemacs)
     (is-external . true)
     (hook . "treemacs.el"))
    
    ;; Syntax visuals packages
    '((symbol . rainbow-identifiers)
     (is-external . true)
     (hook . "rainbow-identifiers.el"))

    '((symbol . rust-mode)
     (is-external . true)
     (hook . "rust-mode.el"))

     '((symbol . typescript-mode)
     (is-external . true)
     (hook . "typescript-mode.el"))
    
    ;;; Internal Modules
    '((symbol . cursor-movement)
     (is-external . false)
     (hook . "cursor-movement.el"))

    '((symbol . interface)
      (is-external . false)
      (hook . "interface.el"))
        
    '((symbol . terminal)
     (is-external . false)
     (hook . "terminal.el"))

  )
  "A list of alists corresponding to module installations."
)

(defun gassoc (key alist) (cdr (assoc key alist)))

(defun load-tilemacs-modules ()
  (dolist (mod tilemacs-modules)
    (progn
      (cond ((eq (gassoc 'is-external mod) 'true)
	  (progn
	    (print (gassoc 'symbol mod))
	    (straight-use-package (gassoc 'symbol mod))
	    ))
	)
      (if (gassoc 'hook mod)
	  (load (expand-file-name (gassoc 'hook mod) user-emacs-directory)))
      (print "Loaded module...")
      (print (gassoc 'symbol mod))
      )
    )
  "Load each module, using straight.el to install it (if necessary)."
  )

(load-tilemacs-modules)

(prin1 "Emacs initialization complete.")
