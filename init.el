;;; init.el --- Spacemacs Initialization File
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; Without this comment emacs25 adds (package-initialize) here
;; (package-initialize)

;; Increase gc-cons-threshold, depending on your system you may set it back to a
;; lower value in your dotfile (function `dotspacemacs/user-config')
(setq gc-cons-threshold 100000000)

(load-file (concat (file-name-directory load-file-name)
                   "core/core-load-paths.el"))
(require 'core-emacs)
;;(spacemacs/init)
;;(spacemacs/maybe-install-dotfile)
;;(configuration-layer/sync)
;;(spacemacs-buffer/display-info-box)
;;(spacemacs/setup-startup-hook)
;;(require 'server)
;;(unless (server-running-p) (server-start))
