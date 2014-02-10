

; INDUCTOR
; object stores data about the inductor

(defclass INDUCTOR (is-a USER)
	(slot proposed_core 			; type is CORE
		(type INSTANCE-NAME)
		(allowed-classes CORE))
	(slot proposed_winding			; type is WINDING
		(type INSTANCE-NAME)
		(allowed-classes WINDING))
	(slot proposed_wire				; type is WIRE
		(type INSTANCE-NAME)
		(allowed-classes WIRE))

	(slot inductance
		(type NUMBER)
		(default 0))
	(slot has_inductance 
		(type SYMBOL)
		(default FALSE))
	(slot inductance_calculated
		(type NUMBER)
		(default 0))
	(slot has_inductance_calculated
		(type SYMBOL)
		(default FALSE))
	(slot dc_current
		(type NUMBER))
	(slot ac_current
		(type NUMBER))
	(slot current					; I = Idc + deltaI / 2
		(type NUMBER)
		(default 0))
	(slot has_current
		(type SYMBOL)
		(default FALSE))		
	(slot frequency
		(type NUMBER)
		(default 0))
	(slot total_power_loss
		(type NUMBER)
		(default 0))
	(slot has_total_power_loss
		(type SYMBOL)
		(default FALSE))
	(slot power_loss_density
		(type NUMBER)
		(default 0))
	(slot has_power_loss_density
		(type SYMBOL)
		(default FALSE))
	(slot energy_handling_capability
		(type NUMBER)
		(default 0))
	(slot has_energy_handling_capability
		(type SYMBOL)
		(default FALSE))
	(slot weight
		(type NUMBER)
		(default 0))
	(slot volume
		(type NUMBER)
		(default 0))
	(slot cost
		(type NUMBER)
		(default 0))

	(slot meet_window			; yes/no
		(type SYMBOL)
		(allowed-symbols YES NO)
		(default YES))
	(slot meet_power_loss_density		; yes/no
		(type SYMBOL)
		(allowed-symbols YES NO)
		(default YES))
	(slot meet_max_flux_density		; yes/high/low
		(type SYMBOL)
		(allowed-symbols YES HIGH LOW)
		(default YES))
	(slot meet_inductance			; yes/high/low
		(type SYMBOL)
		(allowed-symbols YES HIGH LOW)
		(default YES))
	(slot meet_volume			; yes/no
		(type SYMBOL)
		(allowed-symbols YES NO)
		(default YES))
	(slot meet_weight			; yes/no
		(type SYMBOL)
		(allowed-symbols YES NO)
		(default YES))
	(slot meet_cost				; yes/no
		(type SYMBOL)
		(allowed-symbols YES NO)
		(default YES))

	(slot inductance_checked
		(type SYMBOL)
		(allowed-symbols YES NO)
		(default NO))
	(slot flux_density_checked
		(type SYMBOL)
		(allowed-symbols YES NO)
		(default NO))
	(slot power_loss_checked
		(type SYMBOL)
		(allowed-symbols YES NO)
		(default NO))
		
	(slot modification_tried
		(type SYMBOL)
		(allowed-symbols YES NO)
		(default NO))
		
	(slot air_gap_increase_tried
		(type SYMBOL)
		(allowed-symbols YES NO)
		(default NO))
	(slot air_gap_decrease_tried
		(type SYMBOL)
		(allowed-symbols YES NO)
		(default NO))
	(slot turns_increase_tried
		(type SYMBOL)
		(allowed-symbols YES NO)
		(default NO))
	(slot turns_decrease_tried
		(type SYMBOL)
		(allowed-symbols YES NO)
		(default NO))
	(slot wire_size_increase_tried
		(type SYMBOL)
		(allowed-symbols YES NO)
		(default NO))
	(slot wire_size_decrease_tried
		(type SYMBOL)
		(allowed-symbols YES NO)
		(default NO))
	(slot core_size_increase_tried
		(type SYMBOL)
		(allowed-symbols YES NO)
		(default NO))
	(slot core_size_decrease_tried
		(type SYMBOL)
		(allowed-symbols YES NO)
		(default NO))
	
		
	(slot status				; test/modify/done/ok ; Needs to be tested, Needs to be modified, all modifications complete still unsatisfactory, okay means satisfactory
		(type SYMBOL)
		(allowed-symbols DESIGN TEST MODIFY DONE OK)
		(default DESIGN))
)


; PRINT

(defmessage-handler INDUCTOR print ()
	(printout t "===============" crlf)
	(printout t "  INDUCTOR" crlf)
	(printout t "===============" crlf)
	(printout t " CORE>" crlf)
	(send ?self:proposed_core print)
	(printout t " WINDING>" crlf)
	(send ?self:proposed_winding print)
	(printout t " WIRE>" crlf)
	(send ?self:proposed_wire print)
		
	(printout t "inductance = " ?self:inductance " is " ?self:has_inductance crlf)
	(printout t "inductance_calculated = " ?self:inductance_calculated " is " ?self:has_inductance_calculated crlf)
	(printout t "dc_current = " ?self:dc_current crlf)
	(printout t "ac_current = " ?self:ac_current crlf)
	(printout t "current = " ?self:current " is " ?self:has_current crlf)
	(printout t "frequency = " ?self:frequency crlf)
	(printout t "total_power_loss = " ?self:total_power_loss " is " ?self:has_total_power_loss crlf)
	(printout t "power_loss_density = " ?self:power_loss_density " is " ?self:has_power_loss_density crlf)
	(printout t "energy_handling_capability = " ?self:energy_handling_capability " is " ?self:has_energy_handling_capability crlf)
	(printout t "weight = " ?self:weight crlf)
	(printout t "volume = " ?self:volume crlf)
	(printout t "cost = " ?self:cost crlf)
	
	(printout t "meet_window = " ?self:meet_window crlf)
	(printout t "meet_power_loss_density = " ?self:meet_power_loss_density crlf)
	(printout t "meet_max_flux_density = " ?self:meet_max_flux_density crlf)
	(printout t "meet_inductance = " ?self:meet_inductance crlf)
	(printout t "meet_volume = " ?self:meet_volume crlf)
	(printout t "meet_weight = " ?self:meet_weight crlf)
	(printout t "meet_cost = " ?self:meet_cost crlf)
		
	(printout t "===============" crlf)
	(printout t " END INDUCTOR" crlf)
	(printout t "===============" crlf)
)


; CALCULATE CURRENT
; REQUIRES dc-current AND ac-current

(defmessage-handler INDUCTOR calculate-current (?dc ?ac)	
	; I = Idc + deltaI / 2
	(send ?self put-has_current TRUE)
	(send ?self put-current (+ ?dc (/ ?ac 2)))
)

; CALCULATE ENERGY HANDLING CAPABILITY
; REQUIRES inductance AND current

(defmessage-handler INDUCTOR calculate-energy-handling-ability ()
	; E = L * I^2 / 2 [W]
	(bind ?self:has_energy_handling_capability TRUE)
	(bind ?self:energy_handling_capability (round-digits (/ (* ?self:inductance  (** ?self:current 2 ) ) 2 ) 4))
)

; CALCULATE TOTAL LOSS

(defmessage-handler INDUCTOR calculate-total-loss ()
	; TOTAL Psigma = Pfe + Pcu (core + winding)
	(bind ?self:has_total_power_loss TRUE)
	(send ?self put-total_power_loss (+ (send ?self:proposed_core get-core_loss) (send ?self:proposed_winding get-winding_loss)))
)

; CALCULATE LOSS DENSITY

(defmessage-handler INDUCTOR calculate-loss-density ( ?At )
	; Psi = Psigma / At	
	(bind ?self:has_power_loss_density TRUE)
	(send ?self put-power_loss_density (round-digits (/ ?self:total_power_loss ?At) 4))
)

; CALCULATE FINAL INDUCTANCE

(defmessage-handler INDUCTOR calculate-final-inductance ( ?N ?Ac ?air_gap )
	; L = 0.4 *pi * N^2 *Ac * 10^-8 / lg
	(bind ?L (* 0.4 (pi) (** ?N 2) ?Ac (** 10 -8) (** ?air_gap -1)))
	(bind ?self:has_inductance_calculated TRUE)
	(send ?self put-inductance_calculated (round-digits ?L 6))
)

; INDUCTOR MAKE INSTANCE
; CREATES an instance of an inductor (with core and winding instances as well)

(deffunction inductor-make-instance (?design ?core-constants)
	(bind ?inductance (send ?design get-inductance))
	(bind ?frequency (send ?design get-frequency))
	(bind ?dc-current (send ?design get-dc_current))
	(bind ?ac-current (send ?design get-ripple_current))
	(bind ?flux-density (send ?design get-flux_density))

	; INDUCTOR INSTANCE
	(bind ?i (make-instance of INDUCTOR (inductance ?inductance)))
	(send ?i put-has_inductance TRUE)
	(send ?i put-frequency ?frequency)
	(send ?i put-dc_current ?dc-current)
	(send ?i put-ac_current ?ac-current)
	(send ?i calculate-current ?dc-current ?ac-current)
	
	; CORE instance and definition
	(bind ?core (make-instance of CORE))
	(send ?i put-proposed_core ?core)
	(send ?core put-core_constants ?core-constants)
	(send ?core put-max_flux_density ?flux-density)
	
	; WINDING / WIRE instance making
	(send ?i put-proposed_winding 	(make-instance of WINDING))
	(send ?i put-proposed_wire 		(make-instance of WIRE))
	
	; RETURN
	?i
)

; INDUCTOR COPY INSTANCE
; make instance copy of a previous instance

(deffunction inductor-make-copy-of-instance ( ?tocpy )
	(bind ?tocpy-core (send ?tocpy get-proposed_core))
	(bind ?tocpy-winding (send ?tocpy get-proposed_winding))
	(bind ?tocpy-wire (send ?tocpy get-proposed_wire))

	; INDUCTOR INSTANCE
	(bind ?i (make-instance of INDUCTOR))
	
	(send ?i put-inductance (send ?tocpy get-inductance))
	(send ?i put-has_inductance (send ?tocpy get-has_inductance))
	(send ?i put-inductance_calculated (send ?tocpy get-inductance_calculated))
	(send ?i put-has_inductance_calculated (send ?tocpy get-has_inductance_calculated))	
	(send ?i put-dc_current (send ?tocpy get-dc_current))
	(send ?i put-ac_current (send ?tocpy get-ac_current))		
	(send ?i put-current (send ?tocpy get-current))	
	(send ?i put-has_current (send ?tocpy get-has_current))	
	(send ?i put-frequency (send ?tocpy get-frequency))
	(send ?i put-total_power_loss (send ?tocpy get-total_power_loss))
	(send ?i put-has_total_power_loss (send ?tocpy get-has_total_power_loss))		
	(send ?i put-power_loss_density (send ?tocpy get-power_loss_density))
	(send ?i put-has_power_loss_density (send ?tocpy get-has_power_loss_density))
	(send ?i put-energy_handling_capability (send ?tocpy get-energy_handling_capability))	
	(send ?i put-has_energy_handling_capability (send ?tocpy get-has_energy_handling_capability))
	(send ?i put-weight (send ?tocpy get-weight))		
	(send ?i put-volume (send ?tocpy get-volume))
	(send ?i put-cost (send ?tocpy get-cost))
		
	(send ?i put-meet_window (send ?tocpy get-meet_window))
	(send ?i put-meet_power_loss_density (send ?tocpy get-meet_power_loss_density))
	(send ?i put-meet_max_flux_density (send ?tocpy get-meet_max_flux_density))
	(send ?i put-meet_inductance (send ?tocpy get-meet_inductance))
	(send ?i put-meet_volume (send ?tocpy get-meet_volume))	
	(send ?i put-meet_weight (send ?tocpy get-meet_weight))
	(send ?i put-meet_cost (send ?tocpy get-meet_cost))
	
	(send ?i put-status (send ?tocpy get-status))
		
	; CORE instance and copy
	(bind ?core (make-instance of CORE))
	(send ?i put-proposed_core ?core)
	(send ?core cpy-instance ?tocpy-core)
		
	; WINDING instance making
	(bind ?winding (make-instance of WINDING))
	(send ?i put-proposed_winding 	?winding)
	(send ?winding cpy-instance ?tocpy-winding)
	
	; WIRE instance making
	(bind ?wire (make-instance of WIRE))
	(send ?i put-proposed_wire ?wire)
	(send ?wire cpy-instance ?tocpy-wire)
	
	; RETURN the copy
	?i
)


; MODIFY HANDLERS

(defmessage-handler INDUCTOR Decrease_Number_Of_Turns ()
	(bind ?current-turns (send ?self:proposed_winding get-number_of_turns))
	(bind ?proposed-turns (- ?current-turns 1))
	(send ?self modify-number-of-turns ?proposed-turns)
	(bind ?self:modification_tried YES)
)

(defmessage-handler INDUCTOR Increase_Air_Gap ()
	(bind ?current-air-gap (send ?self:proposed_core get-air_gap))
	(bind ?proposed-air-gap (* ?current-air-gap 1.1))
	(send ?self modify-air-gap ?proposed-air-gap)
	(bind ?self:modification_tried YES)
)

(defmessage-handler INDUCTOR Increase_Number_Of_Turns ()
	(bind ?current-turns (send ?self:proposed_winding get-number_of_turns))
	(bind ?proposed-turns (+ ?current-turns 1))
	(send ?self modify-number-of-turns ?proposed-turns)
	(bind ?self:modification_tried YES)
)

(defmessage-handler INDUCTOR Decrease_Air_Gap ()
	(bind ?current-air-gap (send ?self:proposed_core get-air_gap))
	(bind ?proposed-air-gap (* ?current-air-gap 0.9))
	(send ?self modify-air-gap ?proposed-air-gap)
	(bind ?self:modification_tried YES)
)

(defmessage-handler INDUCTOR Increase_Core_Size ()
	(bind ?current-core-size (send (send ?self:proposed_core get-core_data) get-Ap))
	
	; FIND NEXT HIGHEST CORE SIZE 
	(bind ?next_highest 100)
	(do-for-all-instances
		((?cd CORE-DATA))
		TRUE
		(if (and (> ?cd:Ap ?current-core-size)
				(< ?cd:Ap ?next_highest)
		) then
			(bind ?next_highest ?cd:Ap)
		)
	)
	
	(send ?self modify-core-size ?next_highest)
	(bind ?self:modification_tried YES)
)

(defmessage-handler INDUCTOR Decrease_Core_Size ()
	(bind ?current-core-size (send (send ?self:proposed_core get-core_data) get-Ap))
	
	; FIND NEXT SMALLEST CORE SIZE 
	(bind ?next_smallest 0)
	(do-for-all-instances
		((?cd CORE-DATA))
		TRUE
		(if (and (< ?cd:Ap ?current-core-size)
				(> ?cd:Ap ?next_smallest)
		) then
			(bind ?next_smallest ?cd:Ap)
		)
	)
	
	(send ?self modify-core-size ?next_smallest)
	(bind ?self:modification_tried YES)
)

(defmessage-handler INDUCTOR Increase_Wire_Size ()
	(bind ?current-wire-size (send (send ?self:proposed_wire get-wire_data) get-bare-area-cm2))
	
	; FIND NEXT HIGHEST WIRE SIZE 
	(bind ?next_highest 100)
	(do-for-all-instances
		((?wd WIRE-DATA))
		TRUE
		(if (and (> ?wd:bare-area-cm2 ?current-wire-size)
				(< ?wd:bare-area-cm2 ?next_highest)
		) then
			(bind ?next_highest ?wd:bare-area-cm2)
		)
	)
	
	(send ?self modify-wire-size ?next_highest)
	(bind ?self:modification_tried YES)
)

(defmessage-handler INDUCTOR Decrease_Wire_Size ()
		(bind ?current-wire-size (send (send ?self:proposed_wire get-wire_data) get-bare-area-cm2))
	
	; FIND NEXT SMALLEST WIRE SIZE 
	(bind ?next_smallest 0)
	(do-for-all-instances
		((?wd WIRE-DATA))
		TRUE
		(if (and (< ?wd:bare-area-cm2 ?current-wire-size)
				(> ?wd:bare-area-cm2 ?next_smallest)
		) then
			(bind ?next_smallest ?wd:bare-area-cm2)
		)
	)
	
	(send ?self modify-wire-size ?next_smallest)
	(bind ?self:modification_tried YES)
)

; MODIFY NUMBER OF TURNS

(defmessage-handler INDUCTOR modify-number-of-turns ( ?N )
	(bind ?core ?self:proposed_core)
	(bind ?winding ?self:proposed_winding)
	(bind ?wire ?self:proposed_wire)
	(bind ?cdata (send ?core get-core_data))
	(bind ?wdata (send ?wire get-wire_data))
	(bind ?L ?self:inductance)
	(bind ?Ac (send ?cdata get-Ac))
	(bind ?I ?self:current)
	(bind ?At (send ?cdata get-At))
	
	(send ?winding put-number_of_turns ?N)
	(send ?self modify-air-gap (send ?core calculate-air-gap ?N ?Ac ?L))	
)

; MODIFY AIR GAP

(defmessage-handler INDUCTOR modify-air-gap ( ?air_gap )
	(bind ?core ?self:proposed_core)
	(bind ?winding ?self:proposed_winding)
	(bind ?wire ?self:proposed_wire)
	(bind ?cdata (send ?core get-core_data))
	(bind ?wdata (send ?wire get-wire_data))
	(bind ?L ?self:inductance)
	(bind ?Ac (send ?cdata get-Ac))
	(bind ?I ?self:current)
	(bind ?At (send ?cdata get-At))
	
	(send ?core put-air_gap ?air_gap)
	
	;(bind ?oldn (round (sqrt (/ (* ?air_gap ?L (** 10 8)) (* 4 (pi) ?Ac)))))
	;(send ?winding put-number_of_turns ?oldn)	
	
	(bind ?F (send ?core calculate-fringing-factor))
	
	(bind ?N (send ?winding recalculate-number-of-turns ?air_gap ?L ?Ac ?F))
	(send ?winding put-number_of_turns ?N)	
	
	(bind ?MLT (send ?cdata get-MLT))
	(bind ?resistance (send ?wdata get-resistance))
	
	(send ?winding calculate-winding-resistance ?MLT ?resistance)
	(send ?winding calculate-copper-loss ?I)	
	(send ?core calculate-ac-flux-density ?N ?self:ac_current)	
	(send ?core calculate-flux-density ?N ?I)	
	(send ?core calculate-core-loss ?self:frequency)	
	(send ?self calculate-total-loss)
	(send ?self calculate-loss-density ?At)	
	(send ?self calculate-final-inductance ?N ?Ac ?air_gap)
)

; MODIFY WIRE SIZE

(defmessage-handler INDUCTOR modify-wire-size ( ?bare_wire_size )
	(bind ?core ?self:proposed_core)
	(bind ?winding ?self:proposed_winding)
	(bind ?wire ?self:proposed_wire)
	(bind ?cdata (send ?core get-core_data))
	(bind ?wdata (send ?wire get-wire_data))
	(bind ?L ?self:inductance)
	(bind ?Ac (send ?cdata get-Ac))
	(bind ?I ?self:current)
	(bind ?At (send ?cdata get-At))	
	
	(send ?wire put-bare_wire_size ?bare_wire_size )
	
	(bind ?bare_wire_size (* 1000 ?bare_wire_size))	
	
	(do-for-all-instances 
		((?wire1 WIRE-DATA))
		TRUE
		(bind ?area ?wire1:bare-area-cm2)
		(if (= 0 (length 
				(find-instance ((?wire2 WIRE-DATA))
					(> (abs(- ?area ?bare_wire_size)) (abs(- ?wire2:bare-area-cm2 ?bare_wire_size))))))
			then
			(send ?wire select-wire-data ?wire1)
			;(printout t "AWG=" (send ?wire1 get-AWG) "" crlf)		
		)
	)
	(bind ?wdata (send ?wire get-wire_data))	
	(bind ?area (send ?wdata get-area-cm2))
	(bind ?Wa (send ?cdata get-Wa))	
	(bind ?N (send ?winding calculate-number-of-turns ?area ?Wa))
	;(printout t "N=" (send ?winding get-number_of_turns) " should = 70" crlf)
	(send ?self modify-number-of-turns ?N)	
)

; MODIFY CORE SIZE

(defmessage-handler INDUCTOR modify-core-size ( ?desired-Ap )
	(bind ?core ?self:proposed_core)
	(bind ?winding ?self:proposed_winding)
	(bind ?wire ?self:proposed_wire)
	(bind ?cdata (send ?core get-core_data))
	(bind ?wdata (send ?wire get-wire_data))
	(bind ?L ?self:inductance)
	(bind ?Ac (send ?cdata get-Ac))
	(bind ?I ?self:current)
	(bind ?At (send ?cdata get-At))
	
	(send ?core put-area_product_calculated ?desired-Ap)
	
	(do-for-all-instances 
		((?core1 CORE-DATA))
		TRUE
		(bind ?Ap1 ?core1:Ap)
		(if (= 0 (length (find-instance ( (?core2 CORE-DATA) )  ( > (abs (- ?Ap1 ?desired-Ap)) (abs (- ?core2:Ap ?desired-Ap)))))) then
			(send ?core select-core-data ?core1)
			;(printout t "Cat-Num=" (send ?core1 get-cat-num) "" crlf)
		)
	)
	
	(bind ?Ap (send (send ?core get-core_data) get-Ap))
	(bind ?constants (send ?core get-core_constants))
	(bind ?y (send ?constants get-y))
	(bind ?Kj (send ?constants get-Kj))
	(bind ?current-density (send ?winding calculate-current-density ?Ap ?y ?Kj))
	
	(bind ?bare_wire_size (send ?wire calculate-bare-wire-size ?I ?current-density))
	
	(send ?self modify-wire-size ?bare_wire_size)
)

; TEST check flux density

(defmessage-handler INDUCTOR test-flux-density ( ?tolerance )
	(bind ?self:flux_density_checked YES)
	(bind ?flux_density (send ?self:proposed_core get-max_flux_density))
	(bind ?flux_density_calc (send ?self:proposed_core get-max_flux_density_calculated))
	(bind ?diff (abs (- ?flux_density_calc ?flux_density)))
	(bind ?percent (/ ?diff ?flux_density))
	(if (> ?percent ?tolerance ) then				; WITHIN X% of the desired.
		(if (> ?flux_density_calc ?flux_density) then	; high
			(bind ?self:meet_max_flux_density HIGH)
		else (if (< ?flux_density_calc ?flux_density) then
			(bind ?self:meet_max_flux_density LOW)
		))
	else
		(bind ?self:meet_max_flux_density YES)
	)
)

; TEST window

(defmessage-handler INDUCTOR test-window ()
	
)

; TEST Inductance

(defmessage-handler INDUCTOR test-inductance ( ?tolerance )
	(bind ?self:inductance_checked YES)
	(bind ?diff (abs (- ?self:inductance_calculated ?self:inductance)))
	(bind ?percent (/ ?diff ?self:inductance))
	(if (> ?percent ?tolerance ) then				; WITHIN X% of the desired.
		(if (> ?self:inductance_calculated ?self:inductance) then	; high
			(bind ?self:meet_inductance HIGH)
		else (if (< ?self:inductance_calculated ?self:inductance) then
			(bind ?self:meet_inductance LOW)
		))
	else
		(bind ?self:meet_inductance YES)
	)
)

; TEST loss density

(defmessage-handler INDUCTOR test-loss-density ( ?target ?tolerance )
	(bind ?self:power_loss_checked YES)
	(bind ?diff (abs (- ?self:total_power_loss ?target)))
	(bind ?percent (/ ?diff ?target))
	;(if (> ?percent ?tolerance ) then				; WITHIN X% of the desired.
		(if (> ?self:total_power_loss ?target) then	; high
			(bind ?self:meet_power_loss_density NO)
		else (if (< ?self:total_power_loss ?target) then
			(bind ?self:meet_power_loss_density YES)
		))
	;else
	;	(bind ?self:meet_power_loss_density YES)
	;)
)

; TEST volume

(defmessage-handler INDUCTOR test-volume ()

)

; TEST cost

(defmessage-handler INDUCTOR test-cost ()

)

; TEST weight

(defmessage-handler INDUCTOR test-weight ()

)

; RESET CHECKS

(defmessage-handler INDUCTOR reset-checks ()
	(bind ?self:inductance_checked NO)
	(bind ?self:modification_tried NO)
)

; INDUCTOR COMPARE

(deffunction inductor-compare ( ?i1 ?i2 )
	(and 
		(core-compare (send ?i1 get-proposed_core) (send ?i2 get-proposed_core))
		(winding-compare (send ?i1 get-proposed_winding) (send ?i2 get-proposed_winding))
		(wire-compare (send ?i1 get-proposed_wire) (send ?i2 get-proposed_wire))
	
		(= (send ?i1 get-inductance) (send ?i2 get-inductance))
		(= (send ?i1 get-inductance_calculated) (send ?i2 get-inductance_calculated))
		(= (send ?i1 get-dc_current) (send ?i2 get-dc_current))
		(= (send ?i1 get-ac_current) (send ?i2 get-ac_current))
		(= (send ?i1 get-current) (send ?i2 get-current))
		(= (send ?i1 get-frequency) (send ?i2 get-frequency))
		(= (send ?i1 get-total_power_loss) (send ?i2 get-total_power_loss))
		(= (send ?i1 get-power_loss_density) (send ?i2 get-power_loss_density))
		(= (send ?i1 get-energy_handling_capability) (send ?i2 get-energy_handling_capability))
		(= (send ?i1 get-weight) (send ?i2 get-weight))
		(= (send ?i1 get-volume) (send ?i2 get-volume))
		(= (send ?i1 get-cost) (send ?i2 get-cost))
		;(= 0 (str-compare (send ?i1 get-status) (send ?i2 get-status)))
	)
)

; DELETE

(deffunction delete-inductor ( ?i )
	(unmake-instance (send ?i get-proposed_core))
	(unmake-instance (send ?i get-proposed_winding))
	(unmake-instance (send ?i get-proposed_wire))
	(unmake-instance ?i)
)
