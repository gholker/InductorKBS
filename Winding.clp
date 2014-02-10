; WINDING
; object stores data about winding

(defclass WINDING (is-a USER)
	(slot winding_length		; unused?
		(type NUMBER)
		(default 0))
	(slot winding_weight		; unused?
		(type NUMBER)
		(default 0))
	(slot american_wire_gauge	; unused?
		(type NUMBER)
		(default 0)) ; AWG
	(slot current_density
		(type NUMBER)
		(default 0))
	(slot has_current_density
		(type SYMBOL)
		(default FALSE))		
	(slot number_of_turns
		(type NUMBER)
		(default 0))
	(slot has_number_of_turns
		(type SYMBOL)
		(default FALSE))
	(slot number_of_turns_recalc
		(type NUMBER)
		(default 0))
	(slot has_number_of_turns_recalc
		(type SYMBOL)
		(default FALSE))
	(slot winding_loss
		(type NUMBER)
		(default 0))
	(slot has_winding_loss
		(type SYMBOL)
		(default FALSE))
	(slot resistance
		(type NUMBER)
		(default 0))	
	(slot has_resistance
		(type SYMBOL)
		(default FALSE))
)

; WINDING COMPARE

(deffunction winding-compare ( ?w1 ?w2 )
	(and 
		(= (send ?w1 get-winding_length) (send ?w2 get-winding_length))
		(= (send ?w1 get-winding_weight) (send ?w2 get-winding_weight))
		(= (send ?w1 get-american_wire_gauge) (send ?w2 get-american_wire_gauge))
		(= (send ?w1 get-current_density) (send ?w2 get-current_density))
		(= (send ?w1 get-number_of_turns) (send ?w2 get-number_of_turns))
		(= (send ?w1 get-number_of_turns_recalc) (send ?w2 get-number_of_turns_recalc))
		(= (send ?w1 get-winding_loss) (send ?w2 get-winding_loss))
		(= (send ?w1 get-resistance) (send ?w2 get-resistance))		
	)
)


; PRINT

(defmessage-handler WINDING print ()
	(printout t "===============" crlf)
	(printout t "  WINDING" crlf)
	(printout t "===============" crlf)
	(printout t "winding_length = " ?self:winding_length crlf)
	(printout t "winding_weight = " ?self:winding_weight crlf)
	(printout t "american_wire_gauge = " ?self:american_wire_gauge crlf)
	(printout t "current_density = " ?self:current_density " is " ?self:has_current_density crlf)
	(printout t "number_of_turns = " ?self:number_of_turns " is " ?self:has_number_of_turns crlf)
	(printout t "number_of_turns_recalc = " ?self:number_of_turns_recalc " is " ?self:has_number_of_turns_recalc crlf)
	(printout t "winding_loss = " ?self:winding_loss " is " ?self:has_winding_loss crlf)
	(printout t "resistance = " ?self:resistance " is " ?self:has_resistance crlf)	
	(printout t "===============" crlf)
	(printout t " END WINDING" crlf)
	(printout t "===============" crlf)
)

(defmessage-handler WINDING cpy-instance (?tocpy)
	(bind ?self:winding_length (send ?tocpy get-winding_length))
	(bind ?self:winding_weight (send ?tocpy get-winding_weight))
	(bind ?self:american_wire_gauge (send ?tocpy get-american_wire_gauge))
	(bind ?self:current_density (send ?tocpy get-current_density))
	(bind ?self:has_current_density (send ?tocpy get-has_current_density))
	(bind ?self:number_of_turns (send ?tocpy get-number_of_turns))
	(bind ?self:has_number_of_turns (send ?tocpy get-has_number_of_turns))
	(bind ?self:number_of_turns_recalc (send ?tocpy get-number_of_turns_recalc))
	(bind ?self:has_number_of_turns_recalc (send ?tocpy get-has_number_of_turns_recalc))
	(bind ?self:winding_loss (send ?tocpy get-has_winding_loss))
	(bind ?self:resistance (send ?tocpy get-has_resistance))
)

; CALCULATE CURRENT DENSITY

(defmessage-handler WINDING calculate-current-density ( ?Ap ?y ?Kj )
	; J = Kj * Ap^(y) 
	;(printout t "Ap=" ?Ap " y=" ?y " Kj=" ?Kj crlf)
	(bind ?self:has_current_density TRUE)
	(bind ?self:current_density (round-digits (* ?Kj (** ?Ap ?y)) 2))
)

; CALCULATE NUMBER OF TURNS

(defmessage-handler WINDING calculate-number-of-turns ( ?area ?Wa )
	; N = Wa(eff) * S2 / Aw
	; where, Wa(eff) = Wa * S3		
	
	;(printout t "Wa = " ?Wa " S3 = " ?*S3* " S2 = " ?*S2* " area = " ?area crlf)
	(bind ?num (round (/ (* ?Wa ?*S3* ?*S2*) ?area)))
	
	(bind ?self:has_number_of_turns TRUE)
	(bind ?self:number_of_turns ?num)
)

; RECALCULATE NUMBER OF TURNS

(defmessage-handler WINDING recalculate-number-of-turns ( ?air_gap ?inductance ?Ac ?F )
	; N = ( lg * L / 0.4 * pi * Ac * F * 10^-8 )^(1/2)
	; N = ( ?num / ?den )^.5
	
	(bind ?num (* ?air_gap ?inductance))
	(bind ?den (* 0.4 (pi) ?Ac ?F (** 10 -8)))
	(bind ?self:has_number_of_turns_recalc TRUE)
	(bind ?self:number_of_turns_recalc (round (** (/ ?num ?den) 0.5)))
)

; CALCULATE WINDING RESISTANCE

(defmessage-handler WINDING calculate-winding-resistance ( ?MLT ?resistance )
	; R = MLT * N * (muOmega / cm) * 10^-6

	(bind ?R (* ?MLT ?self:number_of_turns_recalc ?resistance (** 10 -6)))
	(bind ?self:has_resistance TRUE)
	(bind ?self:resistance (round-digits ?R 3))
)

; CALCULATE COPPER LOSS

(defmessage-handler WINDING calculate-copper-loss ( ?I )
	; Pcu = I^2 * R 
	(bind ?Pcu (* (** ?I 2) ?self:resistance))
	(bind ?self:has_winding_loss TRUE)
	(bind ?self:winding_loss (round-digits ?Pcu 2))
)