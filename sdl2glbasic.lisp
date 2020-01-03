(in-package :sdl2-examples)

(require :sdl2)
(require :cl-opengl)

(defun mygl ()
  (sdl2:with-init (:everything)
    (format t "Using SDL Lib: ~D.~D.~D~%"
	    sdl2-ffi:+sdl-major-version+
	    sdl2-ffi:+sdl-minor-version+
	    sdl2-ffi:+sdl-patchlevel+)
    (finish-output)

    (sdl2:with-window (win :flags '(:shown :opengl))
      (sdl2:with-gl-context (gl-context win)
	(format t "Setting up GL window ~%")
	(finish-output)
	(sdl2:gl-make-current win gl-context)
	(gl:viewport 0 0 800 600)
	(gl:matrix-mode :projection)
	(gl:ortho -2 2 -2 2 -2 2)
	(gl:matrix-mode :modelview)
	(gl:load-identity)
	(gl:clear-color 0.0 0.0 1.0 1.0)
	(gl:clear :color-buffer)


					; Main loop
	(format t "MainLoop ~%")
	(finish-output)

	(sdl2:with-event-loop (:method :poll)
	  (:keyup (:keysym keysym)
		  (when (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-escape)
		    (sdl2:push-event :quit)))
	  (:idle ()
		 (gl:clear :color-buffer)
		 (gl:begin :triangles)
		 (gl:color 1.0 0.0 0.0)
		 (gl:vertex 0.0 1.0)
		 (gl:vertex -1.0 -1.0)
		 (gl:vertex 1.0 -1.0)
		 (gl:end)
		 (gl:flush)
		 (sdl2:gl-swap-window win))
	  (:quit () t))

	(format t "Closing~%")
	(finish-output)
	))))
