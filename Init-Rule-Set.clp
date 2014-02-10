; INITIALIZATION RULES 

;INIT::
(defrule R-Init-11-Start-Process
	
	?rdesign 	<- (object (is-a REQUESTED-DESIGN)(core_shape ?shape))
	?cconstants <- (object (is-a CORE-CONSTANTS) (core ?shape))
=>
	;(printout t "Init 11" crlf)	
	(inductor-make-instance ?rdesign ?cconstants)	
	;(focus DESIGN)
)