
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
		(default 0))	(slot ripple_current		(type NUMBER)		(default 0))
	(slot max_temperature
		(type NUMBER)
		(default 0))	(slot flux_density		(type NUMBER)		(default 0))	(slot power_loss		(type NUMBER)		(default 0))
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
		(default 0))	(slot power_loss_tolerance		(type NUMBER)		(default 0))
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

(defmessage-handler REQUESTED-DESIGN print ()	(printout t "================" crlf)
	(printout t "Requested Design" crlf)
	(printout t "================" crlf)
	(printout t crlf)
	(printout t "Inductance:           " ?self:inductance " H" crlf)		(printout t "DC Current:           " ?self:dc_current " A" crlf)	(printout t "Frequency:            " ?self:frequency " Hz" crlf)	(printout t "Ripple Current:       " ?self:ripple_current " A" crlf)	(printout t "Max Temperature:      " ?self:max_temperature " degC"crlf)	(printout t "Flux Density:         " ?self:flux_density " T" crlf)	(printout t "Power Loss:           " ?self:power_loss crlf)	(printout t "Core Shape:           " ?self:core_shape crlf)	(printout t "Material:             " ?self:material crlf)	(printout t "Thickness:            " ?self:thickness " cm" crlf)	(printout t "Inductance Tolerance: " ?self:inductance_tolerance " %" crlf)	(printout t "BMax Tolerance:       " ?self:bmax_tolerance " %" crlf)	(printout t "Power Loss Tolerance: " ?self:power_loss_tolerance " %" crlf)	(printout t "Volume Limit:         " ?self:volume_limit crlf)	(printout t "Weight Limit:         " ?self:weight_limit crlf)	(printout t "Cost Limit:           " ?self:cost_limit crlf)	(printout t crlf)
)

; REQUESTED-DESIGN-GET-INPUT ; function that gets input and creates the requested design
(deffunction requested-design-get-input ( ?def )	(if (<> ?def 0) then		(printout t "Would you like to use the default design? (y/n)" crlf)			(bind ?temp (read))	else		(bind ?temp "y")	)	; IF USING DEFAULT, BUILD THE DEFAULT	(if (= (str-compare ?temp "y") 0) then		(make-instance [reqdesign] of REQUESTED-DESIGN			(inductance 0.002)			(frequency 20000)			(dc_current 5)			(ripple_current 0.5)			(max_temperature 25)			(flux_density 1.4)			(power_loss 3.4)			(core_shape C-CORE)			(material silicon)			(thickness 0)			(inductance_tolerance 0.05)			(bmax_tolerance 0.05)			(power_loss_tolerance 0.1) ; unused			(volume_limit 0)			(weight_limit 0)			(cost_limit 0)					)	; OTHERWISE COLLECT DATA FROM USER 	else		(make-instance [reqdesign] of REQUESTED-DESIGN)		(printout t "Enter inductance in Henry." crlf)		(send [reqdesign] put-inductance (read))		(printout t "Enter DC current in Amperes." crlf)		(send [reqdesign] put-dc_current (read))		(printout t "Enter frequency in Hertz." crlf)		(send [reqdesign] put-frequency (read))		(printout t "Enter ripple current in Amperes." crlf)		(send [reqdesign] put-ripple_current (read))		(printout t "Enter max temperature in degrees Celsius." crlf)		(send [reqdesign] put-max_temperature (read))		(printout t "Enter flux density in Tesla." crlf)		(send [reqdesign] put-flux_density (read))			(printout t "Enter power loss." crlf)		(send [reqdesign] put-power_loss (read))					(printout t "Enter core shape (e.g. C-CORE)." crlf)		(send [reqdesign] put-core_shape (read))		(printout t "Enter material (e.g. Silicon)." crlf)		(send [reqdesign] put-material (read))		(printout t "Enter thickness in centimetres." crlf)		(send [reqdesign] put-thickness (read))		(printout t "Enter inductance tolerance." crlf)		(send [reqdesign] put-inductance_tolerance (read))		(printout t "Enter bmax tolerance." crlf)		(send [reqdesign] put-bmax_tolerance (read))		(printout t "Enter power loss tolerance." crlf)		(send [reqdesign] put-power_loss_tolerance (read))		(printout t "Enter volume limit." crlf)		(send [reqdesign] put-volume_limit (read))		(printout t "Enter weight limit." crlf)		(send [reqdesign] put-weight_limit (read))		(printout t "Enter cost limit." crlf)		(send [reqdesign] put-cost_limit (read))				(printout t "Complete." crlf)	))


