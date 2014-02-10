
; REQUESTED-DESIGN
; Responsible for storing the design specification input from the user


(defclass REQUESTED-DESIGN (is-a USER)
	(slot inductance 
		(type NUMBER)
		(default 0))
	(slot frequency
		(type NUMBER)
		(default 0))
	(slot dc_current
		(type NUMBER)
		(default 0))
	(slot max_temperature
		(type NUMBER)
		(default 0))
	(slot core_shape
		(type SYMBOL)
		(default c-core))
	(slot material
		(type SYMBOL)
		(default silicon))
	(slot thickness
		(type NUMBER)
		(default 0))
	(slot inductance_tolerance
		(type NUMBER)
		(default 0))
	(slot bmax_tolerance
		(type NUMBER)
		(default 0))
	(slot volume_limit
		(type NUMBER)
		(default 0))
	(slot weight_limit
		(type NUMBER)
		(default 0))
	(slot cost_limit
		(type NUMBER)
		(default 0))
)

(defmessage-handler REQUESTED-DESIGN print ()
	(printout t "Requested Design" crlf)
	(printout t "================" crlf)
	(printout t crlf)
	(printout t "Inductance:           " ?self:inductance " H" crlf)	
)

; REQUESTED-DESIGN-GET-INPUT 
(deffunction requested-design-get-input ( ?def )

