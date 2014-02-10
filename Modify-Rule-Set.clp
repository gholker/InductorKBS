
; MODIFY RULE SET


; WINDOW PROBLEMS

(defrule R-Modify-11-Window-Problem-Decrease-Number-Of-Turns

=>

)

(defrule R-Modify-12-Window-Problem-Reduce-Wire-Size

=>

)

(defrule R-Modify-13-Window-Problem-Select-New-Core-Bigger-Window-Area

=>

)

; LOSS DENSITY PROBLEMS

(defrule R-Modify-14-Loss-Density-Problem-Increase-Number-Of-Turns
	?inductor <- (object (is-a INDUCTOR)
					(status MODIFY)
					(meet_power_loss_density NO)
					(modification_tried NO)
					(turns_increase_tried NO)
					(meet_inductance ~LOW)
					(meet_max_flux_density ~LOW))
=>
	(send ?inductor put-turns_increase_tried YES)
	(bind ?i (inductor-make-copy-of-instance ?inductor))
	(send ?i Increase_Number_Of_Turns)	
)

(defrule R-Modify-15-Loss-Density-Problem-Increase-Wire-Size
	?inductor <- (object (is-a INDUCTOR)
					(status MODIFY)
					(meet_power_loss_density NO)
					(modification_tried NO)
					(wire_size_increase_tried NO)
					(meet_inductance ~LOW)
					(meet_max_flux_density ~HIGH))
=>
	(send ?inductor put-turns_increase_tried YES)
	(bind ?i (inductor-make-copy-of-instance ?inductor))
	(send ?i Increase_Wire_Size)	
)

(defrule R-Modify-16-Loss-Density-Problem-Increase-Core-Size
	?inductor <- (object (is-a INDUCTOR)
					(status MODIFY)
					(meet_power_loss_density NO)
					(modification_tried NO)
					(core_size_increase_tried NO)
					(meet_inductance ~LOW)
					(meet_max_flux_density ~LOW))
=>
	(send ?inductor put-turns_increase_tried YES)
	(bind ?i (inductor-make-copy-of-instance ?inductor))
	(send ?i Increase_Core_Size)	
)

(defrule R-Modify-17-Loss-Density-Problem-Increase-Air-Gap
	?inductor <- (object (is-a INDUCTOR)
					(status MODIFY)
					(meet_power_loss_density NO)
					(modification_tried NO)
					(air_gap_increase_tried NO)
					(meet_inductance ~HIGH)
					(meet_max_flux_density ~LOW))
=>
	(send ?inductor put-turns_increase_tried YES)
	(bind ?i (inductor-make-copy-of-instance ?inductor))
	(send ?i Increase_Air_Gap)	
)


; FLUX DENSITY PROBLEMS

(defrule R-Modify-21-Flux-Density-High-Increase-Number-Of-Turns
	?inductor <- (object (is-a INDUCTOR)
					(status MODIFY)
					(meet_max_flux_density HIGH)
					(modification_tried NO)
					(turns_increase_tried NO)
					(meet_inductance ~LOW)
					)
=>
	;(printout t "Modify21" crlf)
	(send ?inductor put-turns_increase_tried YES)
	(bind ?i (inductor-make-copy-of-instance ?inductor))
	(send ?i Increase_Number_Of_Turns)	
)

(defrule R-Modify-22-Flux-Density-High-Increase-Air-Gap
	?inductor <- (object (is-a INDUCTOR)
					(status MODIFY)
					(meet_max_flux_density HIGH)
					(modification_tried NO)
					(air_gap_increase_tried NO)
					(meet_inductance ~HIGH))
=>
	;(printout t "Modify22" crlf)
	(send ?inductor put-air_gap_increase_tried YES)
	(bind ?i (inductor-make-copy-of-instance ?inductor))
	(send ?i Increase_Air_Gap)	
)

(defrule R-Modify-23-Flux-Density-High-Select-New-Core-Increase-Core-Area
	?inductor <- (object (is-a INDUCTOR)
					(status MODIFY)
					(meet_max_flux_density HIGH)
					(modification_tried NO)
					(core_size_increase_tried NO)
					(meet_inductance ~LOW))
=>
	;(printout t "Modify23" crlf)
	(send ?inductor put-core_size_increase_tried YES)
	(bind ?i (inductor-make-copy-of-instance ?inductor))
	(send ?i Increase_Core_Size)	
)

(defrule R-Modify-24-Flux-Density-Low-Decrease-Number-Of-Turns
	?inductor <- (object (is-a INDUCTOR)
					(status MODIFY)
					(meet_max_flux_density LOW)
					(modification_tried NO)
					(turns_decrease_tried NO)
					(meet_inductance ~HIGH)
					(meet_power_loss_density YES))
=>
	;(printout t "Modify24" crlf)
	(send ?inductor put-core_size_increase_tried YES)
	(bind ?i (inductor-make-copy-of-instance ?inductor))
	(send ?i Increase_Core_Size)	
)

(defrule R-Modify-25-Flux-Density-Low-Decrease-Air-Gap
	?inductor <- (object (is-a INDUCTOR)
					(status MODIFY)
					(meet_max_flux_density LOW)
					(modification_tried NO)
					(air_gap_decrease_tried NO)
					(meet_inductance ~LOW)
					(meet_power_loss_density YES))
=>
	;(printout t "Modify25" crlf)
	(send ?inductor put-air_gap_decrease_tried YES)
	(bind ?i (inductor-make-copy-of-instance ?inductor))
	(send ?i Decrease_Air_Gap)	
)

(defrule R-Modify-26-Flux-Density-Low-Select-New-Core-Decrease-Core-Area
	?inductor <- (object (is-a INDUCTOR)
					(status MODIFY)
					(meet_max_flux_density LOW)
					(modification_tried NO)
					(core_size_decrease_tried NO)
					(meet_inductance ~HIGH)
					(meet_power_loss_density YES))
=>
	;(printout t "Modify26" crlf)
	(send ?inductor put-core_size_decrease_tried YES)
	(bind ?i (inductor-make-copy-of-instance ?inductor))
	(send ?i Decrease_Core_Size)	
)

; INDUCTANCE PROBLEMS

(defrule R-Modify-27-Inductance-High-Increase-Number-Of-Turns
	?inductor <- (object (is-a INDUCTOR)
					(status MODIFY)
					(meet_inductance HIGH)
					(modification_tried NO)
					(turns_increase_tried NO)
					(meet_max_flux_density ~LOW))
=>
	;(printout t "Modify27" crlf)
	(send ?inductor put-turns_increase_tried YES)
	(bind ?i (inductor-make-copy-of-instance ?inductor))
	(send ?i Increase_Number_Of_Turns)	
)

(defrule R-Modify-28-Inductance-High-Decrease-Air-Gap
	?inductor <- (object (is-a INDUCTOR)
					(status MODIFY)
					(meet_inductance HIGH)
					(modification_tried NO)
					(air_gap_decrease_tried NO)
					(meet_max_flux_density ~HIGH)
					(meet_power_loss_density YES))
=>
	(printout t "Modify28" crlf)
	(send ?inductor put-air_gap_decrease_tried YES)
	(bind ?air_gap (send (send ?inductor get-proposed_core) get-air_gap))
	;(if (> ?air_gap (* 3 (** 10 -4))) then
		(bind ?i (inductor-make-copy-of-instance ?inductor))
		(send ?i Decrease_Air_Gap)
	;)
)


(defrule R-Modify-29-Inductance-High-Select-New-Core-Increase-Core-Area
	?inductor <- (object (is-a INDUCTOR)
					(status MODIFY)
					(meet_inductance HIGH)
					(modification_tried NO)
					(core_size_increase_tried NO)
					(meet_max_flux_density ~LOW))
=>
	(printout t "Modify29" crlf)
	(send ?inductor put-core_size_increase_tried YES)
	(bind ?i (inductor-make-copy-of-instance ?inductor))
	(send ?i Increase_Core_Size)
)

(defrule R-Modify-31-Inductance-Low-Decrease-Number-Of-Turns
	?inductor <- (object (is-a INDUCTOR)
					(status MODIFY)
					(meet_inductance LOW)
					(modification_tried NO)
					(turns_decrease_tried NO)
					(meet_max_flux_density ~HIGH)
					(meet_power_loss_density YES))
=>
	;(printout t "Modify31 > " ?inductor crlf)
	(send ?inductor put-turns_decrease_tried YES)
	(bind ?i (inductor-make-copy-of-instance ?inductor))
	(send ?i Decrease_Number_Of_Turns)
	;(printout t "i > " ?inductor " >> " ?i crlf)
)

(defrule R-Modify-32-Inductance-Low-Increase-Air-Gap
	?inductor <- (object (is-a INDUCTOR)
					(status MODIFY)
					(meet_inductance LOW)
					(modification_tried NO)
					(air_gap_increase_tried NO)
					(meet_max_flux_density ~LOW))
=>
	;(printout t "Modify32" crlf)
	(send ?inductor put-air_gap_increase_tried YES)
	(bind ?i (inductor-make-copy-of-instance ?inductor))
	(send ?i Increase_Air_Gap)
	;(printout t "i > " ?inductor " >> " ?i crlf)
)

(defrule R-Modify-33-Inductance-Low-Select-New-Core-Decrease-Core-Area
	?inductor <- (object (is-a INDUCTOR)
					(status MODIFY)
					(meet_inductance LOW)
					(modification_tried NO)
					(core_size_decrease_tried NO)
					(meet_max_flux_density ~HIGH)
					(meet_power_loss_density YES))
=>
	;(printout t "Modify33" crlf)
	(send ?inductor put-core_size_decrease_tried YES)
	(bind ?i (inductor-make-copy-of-instance ?inductor))
	(send ?i Decrease_Core_Size)
)

(defrule R-Modify-34-Change-Design-Status
	(declare (salience -10))
	?inductor <- (object (is-a INDUCTOR)
					(status MODIFY))
=>
	(send ?inductor put-status DONE)
)

(defrule R-Modify-35-Deactivate-Modify-Activate-Test
	?inductor <- (object (is-a INDUCTOR)
					(status MODIFY)
					(modification_tried YES))
=>
	;(printout t "Modify35" crlf)
	(send ?inductor reset-checks)
	(send ?inductor put-status TEST)
)