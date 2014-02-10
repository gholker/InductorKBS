; CORE
; object stores data about inductor core

(defclass CORE (is-a USER)
	(slot material		; unused?
		(type NUMBER)
		(default 0))
	(slot shape			; unused?
		(type NUMBER)
		(default 0))
	(slot catalogue-reference-number	; unused?
		(type NUMBER)
		(default 0))	
	(slot core_constants
		(type INSTANCE-NAME)
		(allowed-classes CORE-CONSTANTS))
	(slot max_flux_density		
		(type NUMBER)
		(default 0)	)
	(slot max_flux_density_calculated
		(type NUMBER))
	(slot has_max_flux_density_calculated
		(type SYMBOL)
		(default FALSE))
	(slot max_flux_density_ac
		(type NUMBER))
	(slot has_max_flux_density_ac
		(type SYMBOL)
		(default FALSE))
	(slot area_product_calculated
		(type NUMBER)
		(default 0))
	(slot has_area_product
		(type SYMBOL)
		(default FALSE))
	(slot core_loss
		(type NUMBER)
		(default 0))
	(slot has_core_loss
		(type SYMBOL)
		(default FALSE))
	(slot air_gap
		(type NUMBER))
	(slot has_air_gap
		(type SYMBOL)
		(default FALSE))
	(slot core_data
		(type INSTANCE-NAME)
		(allowed-classes CORE-DATA))
	(slot has_core_data
		(type SYMBOL)
		(default FALSE))
	(slot fringing_factor
		(type NUMBER)
		(default 0))
	(slot has_fringing_factor
		(type SYMBOL)
		(default FALSE))
)

; CORE COMPARE

(deffunction core-compare ( ?c1 ?c2 )
	(and 
		(= (send ?c1 get-material) (send ?c2 get-material))
		(= (send ?c1 get-shape) (send ?c2 get-shape))
		(= (send ?c1 get-catalogue-reference-number) (send ?c2 get-catalogue-reference-number))
		(core-constants-compare (send ?c1 get-core_constants) (send ?c2 get-core_constants))
		(= (send ?c1 get-max_flux_density) (send ?c2 get-max_flux_density))
		(= (send ?c1 get-max_flux_density_calculated) (send ?c2 get-max_flux_density_calculated))
		(= (send ?c1 get-max_flux_density_ac) (send ?c2 get-max_flux_density_ac))
		(= (send ?c1 get-area_product_calculated) (send ?c2 get-area_product_calculated))
		(= (send ?c1 get-core_loss) (send ?c2 get-core_loss))
		(= (send ?c1 get-air_gap) (send ?c2 get-air_gap))
		(core-data-compare (send ?c1 get-core_data) (send ?c2 get-core_data))
		(= (send ?c1 get-fringing_factor) (send ?c2 get-fringing_factor))
	)
)

; PRINT

(defmessage-handler CORE print ()
	(printout t "===============" crlf)
	(printout t "  CORE" crlf)
	(printout t "===============" crlf)
	(printout t " CONSTANTS>" crlf)
	(send ?self:core_constants print)
	(printout t "max_flux_density = " ?self:max_flux_density crlf)
	(printout t "max_flux_density_calc = " ?self:max_flux_density_calculated " is " ?self:has_max_flux_density_calculated crlf)
	(printout t "max_flux_density_ac = " ?self:max_flux_density_ac " is " ?self:has_max_flux_density_ac crlf)
	(printout t "area_product = " ?self:area_product_calculated " is " ?self:has_area_product crlf)
	(printout t "core_loss = " ?self:core_loss " is " ?self:has_core_loss crlf)
	(printout t "air_gap = " ?self:air_gap " is " ?self:has_air_gap crlf)
	(printout t " CORE_DATA>" crlf)
	(send ?self:core_data print)
	(printout t "has_core_data is " ?self:has_core_data crlf)
	(printout t "fringing_factor = " ?self:fringing_factor " is " ?self:has_fringing_factor crlf)
	(printout t "===============" crlf)
	(printout t " END CORE" crlf)
	(printout t "===============" crlf)
)


; COPY INSTANCE

(defmessage-handler CORE cpy-instance (?tocpy)
	(bind ?self:material (send ?tocpy get-material))
	(bind ?self:shape (send ?tocpy get-shape))
	(bind ?self:catalogue-reference-number (send ?tocpy get-catalogue-reference-number))
	(bind ?self:core_constants (send ?tocpy get-core_constants))
	(bind ?self:max_flux_density (send ?tocpy get-max_flux_density))
	(bind ?self:max_flux_density_calculated (send ?tocpy get-max_flux_density_calculated))
	(bind ?self:has_max_flux_density_calculated (send ?tocpy get-has_max_flux_density_calculated))
	(bind ?self:max_flux_density_ac (send ?tocpy get-max_flux_density_ac))
	(bind ?self:has_max_flux_density_ac (send ?tocpy get-has_max_flux_density_ac))
	(bind ?self:area_product_calculated (send ?tocpy get-area_product_calculated))
	(bind ?self:has_area_product (send ?tocpy get-has_area_product))
	(bind ?self:core_loss (send ?tocpy get-core_loss))
	(bind ?self:has_core_loss (send ?tocpy get-has_core_loss))
	(bind ?self:air_gap (send ?tocpy get-air_gap))
	(bind ?self:has_air_gap (send ?tocpy get-has_air_gap))
	(bind ?self:core_data (send ?tocpy get-core_data))
	(bind ?self:has_core_data (send ?tocpy get-has_core_data))
	(bind ?self:fringing_factor (send ?tocpy get-fringing_factor))
	(bind ?self:has_fringing_factor (send ?tocpy get-has_fringing_factor))
)

; CALCULATE AREA PRODUCT
; REQUIRES energy-handling-capability AND its necessities

(defmessage-handler CORE calculate-area-product ( ?E )
	; Ap = (2 * E * 10^4 / (Bm * Ku * Kj))^x
	
	(bind ?Bm ?self:max_flux_density)
	(bind ?Kj (send ?self:core_constants get-Kj))
	(bind ?x (send ?self:core_constants get-x))
	
	;(printout t "Bm=" ?Bm " Kj=" ?Kj " x=" ?x " Ku=" ?*Ku* crlf)
	
	(bind ?Ap_numerator (* 2 ?E (** 10 4)))
	(bind ?Ap_denominator (* ?Bm ?*Ku* ?Kj))	
	(bind ?Ap (/ ?Ap_numerator ?Ap_denominator))
	(bind ?Ap (** ?Ap ?x))
	
	(bind ?self:has_area_product TRUE)
	(bind ?self:area_product_calculated (round-digits ?Ap 2))
)

; SELECT CORE DATA

(defmessage-handler CORE select-core-data ( ?core-data )
	(bind ?self:has_core_data TRUE)
	(bind ?self:core_data ?core-data)	
)

; CALCULATE AIR GAP

(defmessage-handler CORE calculate-air-gap ( ?turns ?Ac ?L )
	; lg = 0.4 *pi* N^2 *Ac * 10^-8 / L	
	(bind ?lg (/ (* 0.4 (pi) (** ?turns 2) ?Ac (** 10 -8)) ?L))	

	; The following was found on p156 fo the McLyman book (2nd ed.)
	; lg in mils
	(bind ?lg (* ?lg 393.7))
	; round to closest even number
	(if (= (mod (round (+ ?lg 0.5)) 2) 0) then
		(bind ?lg (round (+ ?lg 0.5)))
	else
		(bind ?lg (round (- ?lg 0.5)))
	)
	; IF THE CLOSEST EVEN NUMBER IS ZERO, make it 2
	(if (= ?lg 0) then 
		(bind ?lg 2)
	)
	(bind ?lg (* ?lg (** 10 -3) 2.54))

	(if (= ?lg 0) then 
		(printout t "?lg = " (/ (* 0.4 (pi) (** ?turns 2) ?Ac (** 10 -8)) ?L) crlf)
		(printout t "?turns = " ?turns " ?Ac= " ?Ac " ?L= " ?L crlf)
	)
	
	(bind ?self:has_air_gap TRUE)	
	(bind ?self:air_gap (round-digits ?lg 5))
)


; CALCULATE FRINGING FACTOR

(defmessage-handler CORE calculate-fringing-factor ()
	; F = 1 + [lg / sqrt( Ac )] * ln( 2 * G / lg )
	; F = 1 + p1 * p2
	(bind ?G (send ?self:core_data get-G))
	(bind ?Ac (send ?self:core_data get-Ac))
	(if (or (= ?Ac 0) (= (sqrt ?Ac) 0)(= ?self:air_gap 0)) then
		(printout t "air_gap= " ?self:air_gap crlf)
		(printout t "Ac = " ?Ac crlf)
	)
	(bind ?p2 (log (* 2 ?G (/ 1 ?self:air_gap))))
	(bind ?p1 (/ ?self:air_gap (sqrt ?Ac)))
	
	(bind ?self:has_fringing_factor TRUE)
	(bind ?self:fringing_factor (round-digits (+ 1 (* ?p1 ?p2)) 4) )	
)

; CALCULATE AC FLUX DENSITY

(defmessage-handler CORE calculate-ac-flux-density ( ?N ?ac-current )
	; Bm,ac = 0.4 * pi * N * delta I * 10^-4 / lg

	(bind ?Bac (* 0.4 (pi) ?N (/ ?ac-current 2) (** 10 -4) (/ 1 ?self:air_gap)))
	(bind ?self:has_max_flux_density_ac TRUE)
	(bind ?self:max_flux_density_ac (round-digits ?Bac 4))
)

; CALCULATE FLUX DENSITY

(defmessage-handler CORE calculate-flux-density ( ?N ?I )
	; Bmax = (0.4*pi*N* (Idc + deltaI/2) *10^-4) /lg
	(bind ?Bmax (* 0.4 (pi) ?N ?I (** 10 -4) (** ?self:air_gap -1)))
	(bind ?self:has_max_flux_density_calculated TRUE)
	(bind ?self:max_flux_density_calculated (round-digits ?Bmax 2))
)

; CALCULATE CORE LOSS

(defmessage-handler CORE calculate-core-loss ( ?freq ) 
	; W/Kg  = K * f^(m) * Bm,ac^(n)
	; Pfe = (W/ Kg) * Wtfe [W]
	(bind ?WKg (* 5.97 (** 10 -3) (** ?freq 1.26) (** ?self:max_flux_density_ac 1.73)))
	(bind ?Pfe (* ?WKg (send ?self:core_data get-WTFE)))
	(bind ?self:has_core_loss TRUE)
	(bind ?self:core_loss (round-digits ?Pfe 3))
)