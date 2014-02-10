; MISCELLANEOUS THINGS

; ROUND DIGITS
; specify the number of digits to remain. 

(deffunction round-digits ( ?num ?digits )
	(bind ?num (* ?num (** 10 ?digits)))
	(bind ?num (round ?num))
	(bind ?num (/ ?num (** 10 ?digits)))
	?num
)