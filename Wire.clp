; WIRE
; object stores data about WIRE

(defclass WIRE (is-a USER)
	(slot material			; unused?
		(type NUMBER)
		(default 0))
	(slot bare_wire_size
		(type NUMBER)
		(default 0))
	(slot has_bare_wire_size
		(type SYMBOL)
		(default FALSE))
	(slot wire_size_heavy_synthetics	; unused?
		(type NUMBER)
		(default 0)	)
	(slot resistence_per_length			; unused?
		(type NUMBER)
		(default 0))
	(slot weight_per_length				; unused?
		(type NUMBER)
		(default 0))
	(slot nominal_diameter				; unused?	
		(type NUMBER)
		(default 0))
	(slot layer_insulation_thickness	; unused?
		(type NUMBER)
		(default 0))
	(slot number_of_turns_per_length	; unused?
		(type NUMBER)
		(default 0))
	(slot wire_data
		(type INSTANCE-NAME)
		(allowed-classes WIRE-DATA))
	(slot has_wire_data
		(type SYMBOL)
		(default FALSE))
)

; WIRE COMPARE

(deffunction wire-compare ( ?w1 ?w2 )
	(and 
		(= (send ?w1 get-material) (send ?w2 get-material))
		(= (send ?w1 get-bare_wire_size) (send ?w2 get-bare_wire_size))
		(= (send ?w1 get-wire_size_heavy_synthetics) (send ?w2 get-wire_size_heavy_synthetics))
		(= (send ?w1 get-resistence_per_length) (send ?w2 get-resistence_per_length))
		(= (send ?w1 get-weight_per_length) (send ?w2 get-weight_per_length))
		(= (send ?w1 get-nominal_diameter) (send ?w2 get-nominal_diameter))
		(= (send ?w1 get-layer_insulation_thickness) (send ?w2 get-layer_insulation_thickness))
		(= (send ?w1 get-number_of_turns_per_length) (send ?w2 get-number_of_turns_per_length))
		(wire-data-compare (send ?w1 get-wire_data) (send ?w2 get-wire_data))	
	)	
)

; PRINT

(defmessage-handler WIRE print ()
	(printout t "===============" crlf)
	(printout t "  WIRE" crlf)
	(printout t "===============" crlf)	
	(printout t "material = " ?self:material crlf)
	(printout t "bare_wire_size = " ?self:bare_wire_size " is " ?self:has_bare_wire_size crlf)
	(printout t "wire_size_heavy_synthetics = " ?self:wire_size_heavy_synthetics crlf)
	(printout t "resistence_per_length = " ?self:resistence_per_length crlf)
	(printout t "weight_per_length = " ?self:weight_per_length crlf)
	(printout t "nominal_diameter = " ?self:nominal_diameter crlf)
	(printout t "layer_insulation_thickness = " ?self:layer_insulation_thickness crlf)
	(printout t "number_of_turns_per_length = " ?self:number_of_turns_per_length crlf)
	(printout t " WIRE_DATA>" crlf)
	(send ?self:wire_data print)
	(printout t "has_wire_data is " ?self:has_wire_data crlf)	
	(printout t "===============" crlf)
	(printout t " END WIRE" crlf)
	(printout t "===============" crlf)
)

; COPY INSTANCE

(defmessage-handler WIRE cpy-instance ( ?tocpy )
	(bind ?self:bare_wire_size (send ?tocpy get-bare_wire_size))
	(bind ?self:has_bare_wire_size (send ?tocpy get-has_bare_wire_size))
	(bind ?self:wire_size_heavy_synthetics (send ?tocpy get-wire_size_heavy_synthetics))
	(bind ?self:resistence_per_length (send ?tocpy get-resistence_per_length))
	(bind ?self:weight_per_length (send ?tocpy get-weight_per_length))
	(bind ?self:nominal_diameter (send ?tocpy get-nominal_diameter))	
	(bind ?self:layer_insulation_thickness (send ?tocpy get-layer_insulation_thickness))
	(bind ?self:number_of_turns_per_length (send ?tocpy get-number_of_turns_per_length))
	(bind ?self:wire_data (send ?tocpy get-wire_data))
	(bind ?self:has_wire_data (send ?tocpy get-has_wire_data))	
)

; CALCULATE WIRE SIZE

(defmessage-handler WIRE calculate-bare-wire-size ( ?current ?current-density )
	; Bare Wire Size	Aw(b) = I / J
	(bind ?ws (/ ?current ?current-density))
	
	(bind ?self:has_bare_wire_size TRUE)
	(bind ?self:bare_wire_size (round-digits ?ws 4))
)

; SELECT WIRE DATA

(defmessage-handler WIRE select-wire-data ( ?wd )
	(bind ?self:has_wire_data TRUE)
	(bind ?self:wire_data ?wd)
)