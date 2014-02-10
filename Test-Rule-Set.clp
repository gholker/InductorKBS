
; TEST RULE SET

(defrule R-Test-11-Check-Window

=>

)

(defrule R-Test-12-Check-Max-Flux-Density
	?inductor <- (object (is-a INDUCTOR)
					(status TEST)
					(flux_density_checked NO))
	?design <- (object (is-a REQUESTED-DESIGN)
					(bmax_tolerance ?tolerance))
=>
	(send ?inductor test-flux-density ?tolerance)
)

(defrule R-Test-13-Check-Loss-Density
	?inductor <- (object (is-a INDUCTOR)
					(status TEST)
					(power_loss_checked NO))
	?design <- (object (is-a REQUESTED-DESIGN)
					(power_loss ?target)
					(power_loss_tolerance ?tolerance))
=>
	(send ?inductor test-loss-density ?target ?tolerance)
)

(defrule R-Test-14-Check-Inductance
	?inductor <- (object (is-a INDUCTOR)
					(status TEST)
					(inductance_checked NO))
	?design <- (object (is-a REQUESTED-DESIGN)
					(inductance_tolerance ?tolerance))
=>
	;(printout t "Test-14" crlf)
	(send ?inductor test-inductance ?tolerance)
)

(defrule R-Test-15-Check-Volume

=>

)

(defrule R-Test-16-Check-Weight

=>

)

(defrule R-Test-17-Check-Cost

=>

)

(defrule R-Test-18-Design-Satisfactory

=>

)

(defrule R-Test-19-Change-Design-Status

=>

)

(defrule R-Test-21-Delete-Identical-Designs
	(declare (salience 100))
	?inductor <- (object (is-a INDUCTOR)				
					(status TEST)
					)
=>
	;(printout t "Test21" crlf)
	(if (> (length (find-all-instances 
		((?i2 INDUCTOR))
		(inductor-compare ?inductor ?i2)
		)) 1)
	then 
		;(printout t "delete" crlf)
		(delete-inductor ?inductor)
	)
)

(defrule R-Test-22-Deactivate-Test-Activate-Modify
	;(declare (salience 50))
	?inductor <- (object (is-a INDUCTOR)					
					(inductance_checked YES)
					(status TEST)
					)
=>
	;(printout t "Test22" crlf)
	(send ?inductor put-status MODIFY)
)

(defrule R-Test-23-Deactivate-Test-Activate-Screen
	?inductor <- (object (is-a INDUCTOR)
					(status TEST)
					(inductance_checked YES)
					(meet_inductance YES)
					(power_loss_checked YES)
					(meet_power_loss_density YES)
					(flux_density_checked YES)
					(meet_max_flux_density YES))
=>
	(send ?inductor put-status OK)
	(printout t "FOUND GOOD INDUCTOR DESIGN: > " ?inductor crlf)
	(printout t "===========================" crlf)
	;(printout t "inductance= " (send ?inductor get-inductance_calculated) crlf)
	(send ?inductor print)
	(printout t "===========================" crlf)
)