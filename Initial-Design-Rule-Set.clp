
; INITIAL DESIGN RULES 

; CALCULATE ENERGY HANDLING ABILITY

;DESIGN::

(defrule R-Design-11-Calculate-Energy-Handling-Ability
	?rdesign <- (object (is-a REQUESTED-DESIGN))
	?inductor <- (object (is-a INDUCTOR)
					(status DESIGN)
					(has_inductance TRUE) (has_current TRUE)
					(has_energy_handling_capability FALSE))	
=>
	;(printout t "11" crlf)	
	(send ?inductor calculate-energy-handling-ability)
	;(printout t "E=" (send ?inductor get-energy_handling_capability) " should = .0276" crlf)
)

(defrule R-Design-15-Calculate-Area-Product
	?rdesign <- (object (is-a REQUESTED-DESIGN))
	?inductor <- (object (is-a INDUCTOR)
					(status DESIGN)
					(has_energy_handling_capability TRUE)(energy_handling_capability ?E))	
	?core <- (object (is-a CORE)
					(has_area_product FALSE))
=>
	;(printout t "15" crlf)	
	(send ?core calculate-area-product ?E) 
	;(printout t "Ap=" (send ?core get-area_product_calculated) " should = 2.88" crlf)
)

(defrule R-Design-16-Select-Cores
	;?inductor <- (object (is-a INDUCTOR) 
	;				(status DESIGN)
	;				(proposed_core ?pcore))	
	?pcore <- (object (is-a CORE)
					(has_area_product TRUE) (area_product_calculated ?desired-Ap)
					(has_core_data FALSE))
	?found-core <- (object (is-a CORE-DATA) (Ap ?Ap1))	
=>
	;(printout t "16" crlf)	
	(if (= 0 (length (find-instance ( (?core2 CORE-DATA) )  ( > (abs (- ?Ap1 ?desired-Ap)) (abs (- ?core2:Ap ?desired-Ap)))))) then
			(send ?pcore select-core-data ?found-core)
			;(printout t "Cat-Num=" (send ?found-core get-cat-num) " should = CL-9" crlf)
	)
)

(defrule R-Design-18-Calculate-Current-Density
	?inductor <- (object (is-a INDUCTOR)
					(status DESIGN))
	?pcore <- (object (is-a CORE)
				(has_core_data TRUE)(core_data ?cdata)
				;(has_area_product TRUE)(area_product_calculated ?Ap)
				(core_constants ?constants))	
	?winding <- (object (is-a WINDING)
					(has_current_density FALSE))
=>
	;(printout t "18" crlf)	
	(send ?winding calculate-current-density (send ?cdata get-Ap) (send ?constants get-y) (send ?constants get-Kj))
	;(printout t "J=" (send ?winding get-current_density) " should = 315.09" crlf)
)

(defrule R-Design-19-Calculate-Wire-Size
	?inductor <- (object (is-a INDUCTOR)
					(status DESIGN)
					(current ?current)(has_current TRUE))
	?winding <- (object (is-a WINDING)
					(has_current_density TRUE)(current_density ?cd))
	?wire <- (object (is-a WIRE)
				(has_bare_wire_size FALSE))
=>
	;(printout t "19" crlf)
	(send ?wire calculate-bare-wire-size ?current ?cd)
	;(printout t "Aw(b)=" (send ?wire get-bare_wire_size) " should = .0167" crlf)
)

(defrule R-Design-21-Select-Wires
	?inductor <- (object (is-a INDUCTOR)
					(status DESIGN))
	?wire <- (object (is-a WIRE)
				(has_bare_wire_size TRUE)(bare_wire_size ?bare_wire_size)
				(has_wire_data FALSE))
	?found-wire <- (object (is-a WIRE-DATA) 
						(bare-area-cm2 ?area))	
=>
	;(printout t "21" crlf)
	(bind ?bare_wire_size (* 1000 ?bare_wire_size))	
	
	(if (= 0 (length 
			(find-instance ((?wire2 WIRE-DATA))
				(> (abs(- ?area ?bare_wire_size)) (abs(- ?wire2:bare-area-cm2 ?bare_wire_size))))))	
		then
		(send ?wire select-wire-data ?found-wire)
	;	(printout t "AWG=" (send ?found-wire get-AWG) " should = 15" crlf)		
	)
)

(defrule R-Design-23-Calculate-Number-Of-Turns
	?inductor <- (object (is-a INDUCTOR)
					(status DESIGN))	
	?wire <- (object (is-a WIRE) (has_wire_data TRUE) (wire_data ?wd))
	?core <- (object (is-a CORE) (has_core_data TRUE) (core_data ?cd))
	?winding <- (object (is-a WINDING)
					(has_number_of_turns FALSE))
=>
	;(printout t "23" crlf)
	(bind ?area (send ?wd get-area-cm2))
	(bind ?Wa (send ?cd get-Wa))	
	(send ?winding calculate-number-of-turns ?area ?Wa)
	;(printout t "N=" (send ?winding get-number_of_turns) " should = 70" crlf)
)

(defrule R-Design-24-Calculate-Air-Gap
	?inductor <- (object (is-a INDUCTOR)
					(status DESIGN)
					(has_inductance TRUE)(inductance ?L))
	?winding <- (object (is-a WINDING)
					(has_number_of_turns TRUE) (number_of_turns ?turns))
	?core <- (object (is-a CORE)
					(has_core_data TRUE)(core_data ?cdata)
					(has_air_gap FALSE))
=>	
	;(printout t "24" crlf)		
	(send ?core calculate-air-gap ?turns (send ?cdata get-Ac) ?L)
	;(printout t "lg=" (send ?core get-air_gap) " should = 0.03556" crlf)	
)

(defrule R-Design-25-Calculate-Fringing-Factor
	?inductor <- (object (is-a INDUCTOR)
					(status DESIGN))	
	?core <- (object (is-a CORE)
					(has_air_gap TRUE)
					(has_fringing_factor FALSE))
=>
	;(printout t "25" crlf)
	(send ?core calculate-fringing-factor)
	;(printout t "F=" (send ?core get-fringing_factor) " should = 1.1757" crlf)	
)

(defrule R-Design-26-Recalculate-Number-Of-Turns
	?inductor <- (object (is-a INDUCTOR)
					(status DESIGN)
					(has_inductance TRUE)(inductance ?inductance))	
	?core <- (object (is-a CORE)
					(has_fringing_factor TRUE)(fringing_factor ?F) 
					(has_air_gap TRUE)(air_gap ?air_gap)
					(has_core_data TRUE) (core_data ?core_data))
	?winding <- (object (is-a WINDING)(has_number_of_turns_recalc FALSE))
=>
	;(printout t "26" crlf)
		
	(bind ?Ac (send ?core_data get-Ac))	
	(send ?winding recalculate-number-of-turns ?air_gap ?inductance ?Ac ?F)	
	;(printout t "N2=" (send ?winding get-number_of_turns_recalc) " should = 67" crlf)	
)

(defrule R-Design-27-Calculate-Winding-Resistance
	?inductor <- (object (is-a INDUCTOR)
					(status DESIGN))	
	?winding <- (object (is-a WINDING) 
					(has_number_of_turns_recalc TRUE)
					(has_resistance FALSE))
	?wire <- (object (is-a WIRE)
				(has_wire_data TRUE)(wire_data ?wd))
	?core <- (object (is-a CORE)
				(has_core_data TRUE)(core_data ?cd))
=>
	;(printout t "27" crlf)
	(bind ?MLT (send ?cd get-MLT))
	(bind ?resistance (send ?wd get-resistance))
	
	(send ?winding calculate-winding-resistance ?MLT ?resistance)
	;(printout t "R=" (send ?winding get-resistance) " should = 0.046" crlf)	
)

(defrule R-Design-28-Calculate-Copper-Loss
	?inductor <- (object (is-a INDUCTOR)
					(status DESIGN)
					(current ?I)(has_current TRUE)
					(ac_current ?ac)
					(frequency ?freq))					
	?winding <- (object (is-a WINDING)(has_resistance TRUE)
					(has_number_of_turns_recalc TRUE)(number_of_turns_recalc ?N)
					(has_winding_loss FALSE))
	?core <- (object (is-a CORE))
=>
	;(printout t "28" crlf)	
	(send ?winding calculate-copper-loss ?I)
	;(printout t "Pcu=" (send ?winding get-winding_loss) " should = 1.25" crlf)
	(send ?core calculate-ac-flux-density ?N ?ac)
	;(printout t "Bmac=" (send ?core get-max_flux_density_ac) " should = 0.0594" crlf)
	(send ?core calculate-flux-density ?N ?I)
	;(printout t "Pm=" (send ?core get-max_flux_density_calculated) " should = 1.24" crlf)
	(send ?core calculate-core-loss ?freq)
	;(printout t "Pfe=" (send ?core get-core_loss) " should = 1.038" crlf)
	
)

(defrule R-Design-29-Calculate-Total-Loss
	?inductor <- (object (is-a INDUCTOR)
					(status DESIGN)
					(has_total_power_loss FALSE))
	?winding <- (object (is-a WINDING)(has_winding_loss TRUE))	
	?core <- (object (is-a CORE)(has_core_loss TRUE))
=>
	;(printout t "29" crlf)
	(send ?inductor calculate-total-loss)
	;(printout t "PSigma=" (send ?inductor get-total_power_loss) " should = 2.3" crlf)	
)

(defrule R-Design-31-Calculate-Loss-Density
	?inductor <- (object (is-a INDUCTOR)
						(status DESIGN)
						(has_total_power_loss TRUE)
						(has_power_loss_density FALSE))
	?core <- (object (is-a CORE)
						(has_core_data TRUE)(core_data ?cd))
=>
	;(printout t "31" crlf)	
	(bind ?At (send ?cd get-At))
	(send ?inductor calculate-loss-density ?At)	
	;(printout t "Psi=" (send ?inductor get-power_loss_density) " should = .0334" crlf)
)

(defrule R-Design-32-Calculate-Final-Inductance
	?inductor <- (object (is-a INDUCTOR)
					(status DESIGN)
					(has_inductance_calculated FALSE))
	?winding <- (object (is-a WINDING)
					(has_number_of_turns_recalc TRUE)(number_of_turns_recalc ?N))
	?core <- (object (is-a CORE)
					(has_core_data TRUE)(core_data ?cd)
					(has_air_gap TRUE)(air_gap ?lg))
=>
	;(printout t "32" crlf)	
	(bind ?Ac (send ?cd get-Ac))	
	
	(send ?inductor calculate-final-inductance ?N ?Ac ?lg)	
	;(printout t "Final Inductance Calculated. =" (send ?inductor get-inductance_calculated) " should = 0.001715" crlf)
	
)

(defrule R-Design-34-Deactivate-Design-Activate-Test
	?inductor <- (object (is-a INDUCTOR)
					(status DESIGN)
					(has_inductance_calculated TRUE)
					(has_total_power_loss TRUE)
					(has_power_loss_density TRUE))
=>
	(printout t "Designed Inductor:" crlf)
	(printout t "==================" crlf)
	(send ?inductor print)
	(printout t "==================" crlf)
	(send ?inductor put-status TEST)
)