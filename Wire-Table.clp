; WIRE TABLE

; OBJECT DEFINITION

(defclass WIRE-DATA (is-a USER)
	(slot AWG
		(type INTEGER))
	(slot bare-area-cm2			; cm^2 10^-3
		(type NUMBER)
		(create-accessor write))
	(slot bare-area-CIR-MIL		
		(type NUMBER))
	(slot resistance 			; 10^-6 W / .cm at 20 C
		(type NUMBER))
	(slot area-cm2				; cm^2 10^-3
		(type NUMBER)
		(create-accessor write))
	(slot area-CIR-MIL
		(type NUMBER))
	(slot diameter-cm
		(type NUMBER))
	(slot diameter-inch
		(type NUMBER))
	(slot turns-per-cm
		(type NUMBER))
	(slot turns-per-inch
		(type NUMBER))
	(slot turns-per-cm2
		(type NUMBER))
	(slot turns-per-inch2
		(type NUMBER))
	(slot weight				; g/cm
		(type NUMBER))	
)


; TABLE CREATION
; Pg. 254 of Transformer and Inductor Design Handbook (2nd Edition). Colonel Wm. T. McLyman
; Also, can be found in Dr. Sadeghian's thesis: 4.14

(deffunction wire-data-table-create-table ()
	(make-instance of WIRE-DATA (AWG 10) (bare-area-cm2 52.61) (bare-area-CIR-MIL 10384)	(resistance 32.70) (area-cm2 55.9) 	(area-CIR-MIL 11046)	(diameter-cm 0.267) 	(diameter-inch 0.1051) (turns-per-cm 3.87)	(turns-per-inch 9.5) 	(turns-per-cm2 10.73) (turns-per-inch2 69.20) 	(weight 0.468) 		)
	(make-instance of WIRE-DATA (AWG 11) (bare-area-cm2 41.68) (bare-area-CIR-MIL 8226)		(resistance 41.37) (area-cm2 44.5) 	(area-CIR-MIL 8798)		(diameter-cm 0.238) 	(diameter-inch 0.0938) (turns-per-cm 4.36) 	(turns-per-inch 10.7) 	(turns-per-cm2 13.48) (turns-per-inch2 89.95) 	(weight 0.3750) 	)
	(make-instance of WIRE-DATA (AWG 12) (bare-area-cm2 33.08) (bare-area-CIR-MIL 6529)		(resistance 52.09) (area-cm2 35.64) (area-CIR-MIL 7022)		(diameter-cm 0.213) 	(diameter-inch 0.0838) (turns-per-cm 4.85) 	(turns-per-inch 11.9) 	(turns-per-cm2 16.81) (turns-per-inch2 108.95) 	(weight 0.2977) 	)
	(make-instance of WIRE-DATA (AWG 13) (bare-area-cm2 26.26) (bare-area-CIR-MIL 5184)		(resistance 65.64) (area-cm2 28.36) (area-CIR-MIL 5610)		(diameter-cm 0.190)		(diameter-inch 0.0749) (turns-per-cm 5.47) 	(turns-per-inch 13.4) 	(turns-per-cm2 21.15) (turns-per-inch2 136.4) 	(weight 0.2367) 	)
	(make-instance of WIRE-DATA (AWG 14) (bare-area-cm2 20.82) (bare-area-CIR-MIL 4109)		(resistance 82.80) (area-cm2 22.95) (area-CIR-MIL 4556)		(diameter-cm 0.171) 	(diameter-inch 0.0675) (turns-per-cm 6.04) 	(turns-per-inch 14.8) 	(turns-per-cm2 26.14) (turns-per-inch2 168.6) 	(weight 0.1879) 	)
	(make-instance of WIRE-DATA (AWG 15) (bare-area-cm2 16.51) (bare-area-CIR-MIL 3260)		(resistance 104.3) (area-cm2 18.37) (area-CIR-MIL 3624)		(diameter-cm 0.153) 	(diameter-inch 0.0602) (turns-per-cm 6.77) 	(turns-per-inch 16.6) 	(turns-per-cm2 32.66) (turns-per-inch2 210.6) 	(weight 0.1492) 	)
	(make-instance of WIRE-DATA (AWG 16) (bare-area-cm2 13.07) (bare-area-CIR-MIL 2581)		(resistance 131.8) (area-cm2 14.73) (area-CIR-MIL 2905)		(diameter-cm 0.137) 	(diameter-inch 0.0539) (turns-per-cm 7.32) 	(turns-per-inch 18.6) 	(turns-per-cm2 40.73) (turns-per-inch2 262.7) 	(weight 0.1184) 	)
	(make-instance of WIRE-DATA (AWG 17) (bare-area-cm2 10.39) (bare-area-CIR-MIL 2052)		(resistance 165.8) (area-cm2 11.68) (area-CIR-MIL 2323)		(diameter-cm 0.122) 	(diameter-inch 0.0482) (turns-per-cm 8.18) 	(turns-per-inch 20.8) 	(turns-per-cm2 51.36) (turns-per-inch2 331.2) 	(weight 0.0943) 	)
	(make-instance of WIRE-DATA (AWG 18) (bare-area-cm2 8.228) (bare-area-CIR-MIL 1624)		(resistance 209.5) (area-cm2 9.326) (area-CIR-MIL 1857)		(diameter-cm 0.109) 	(diameter-inch 0.0431) (turns-per-cm 9.13) 	(turns-per-inch 23.2) 	(turns-per-cm2 64.33) (turns-per-inch2 414.9) 	(weight 0.07472) 	)
	(make-instance of WIRE-DATA (AWG 19) (bare-area-cm2 6.531) (bare-area-CIR-MIL 1289)		(resistance 263.9) (area-cm2 7.539) (area-CIR-MIL 1490)		(diameter-cm 0.0980) 	(diameter-inch 0.0386) (turns-per-cm 10.19) (turns-per-inch 25.9) 	(turns-per-cm2 79.85) (turns-per-inch2 515.0) 	(weight 0.05940) 	)
	(make-instance of WIRE-DATA (AWG 20) (bare-area-cm2 5.188) (bare-area-CIR-MIL 1024)		(resistance 332.3) (area-cm2 6.065) (area-CIR-MIL 1197)		(diameter-cm 0.0879) 	(diameter-inch 0.0346) (turns-per-cm 11.37) (turns-per-inch 28.9) 	(turns-per-cm2 98.93) (turns-per-inch2 638.1) 	(weight 0.04726) 	)
)

(defmessage-handler WIRE-DATA get-bare-area-cm2 ()
	(/ ?self:bare-area-cm2 1000)
)

(defmessage-handler WIRE-DATA get-area-cm2 ()
	(/ ?self:area-cm2 1000)
)

; WIRE DATA COMPARE

(deffunction wire-data-compare ( ?w1 ?w2 )
	(= (send ?w1 get-AWG) (send ?w2 get-AWG))
)

; PRINT

(defmessage-handler WIRE-DATA print ()
	(printout t "===============" crlf)
	(printout t "  WIRE-DATA" crlf)
	(printout t "===============" crlf)	
	(printout t "AWG = " ?self:AWG crlf)
	(printout t "bare-area-cm2 = " ?self:bare-area-cm2 crlf)
	(printout t "bare-area-CIR-MIL = " ?self:bare-area-CIR-MIL crlf)
	(printout t "resistance = " ?self:resistance crlf)
	(printout t "area-cm2 = " ?self:area-cm2 crlf)
	(printout t "area-CIR-MIL = " ?self:area-CIR-MIL crlf)
	(printout t "diameter-cm = " ?self:diameter-cm crlf)
	(printout t "diameter-inch = " ?self:diameter-inch crlf)
	(printout t "turns-per-cm = " ?self:turns-per-cm crlf)
	(printout t "turns-per-inch = " ?self:turns-per-inch crlf)
	(printout t "turns-per-cm2 = " ?self:turns-per-cm2 crlf)
	(printout t "turns-per-inch2 = " ?self:turns-per-inch2 crlf)
	(printout t "weight = " ?self:weight crlf)
	(printout t "===============" crlf)
	(printout t " END WIRE-DATA" crlf)
	(printout t "===============" crlf)
)