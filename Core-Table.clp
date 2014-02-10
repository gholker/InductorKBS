; CORE TABLE

; OBJECT DEFINITION

(defclass CORE-DATA (is-a USER)
	(slot cat-num
		(type SYMBOL))
	(slot D
		(type NUMBER))
	(slot E
		(type NUMBER))
	(slot F
		(type NUMBER))	
	(slot G						
		(type NUMBER))
	(slot MPL
		(type NUMBER))
	(slot HT
		(type NUMBER))
	(slot WTH
		(type NUMBER))
	(slot LT
		(type NUMBER))
	(slot WTFE
		(type NUMBER))
	(slot WTCU
		(type NUMBER))
	(slot MLT
		(type NUMBER))
	(slot Ac
		(type NUMBER))
	(slot Wa
		(type NUMBER))
	(slot Ap
		(type NUMBER))
	(slot Kg
		(type NUMBER))
	(slot At
		(type NUMBER))
)

; CORE DATA

(deffunction core-data-compare ( ?c1 ?c2 )
	(= 0 (str-compare (send ?c1 get-cat-num) (send ?c2 get-cat-num)))
)


; PRINT

(defmessage-handler CORE-DATA print ()
	(printout t "===============" crlf)
	(printout t "  CORE-DATA" crlf)
	(printout t "===============" crlf)
	(printout t "cat-num = " ?self:cat-num crlf)
	(printout t "D = " ?self:D crlf)
	(printout t "E = " ?self:E crlf)
	(printout t "F = " ?self:F crlf)
	(printout t "G = " ?self:G crlf)
	(printout t "MPL = " ?self:MPL crlf)
	(printout t "HT = " ?self:HT crlf)
	(printout t "WTH = " ?self:WTH crlf)
	(printout t "LT = " ?self:LT crlf)
	(printout t "WTFE = " ?self:WTFE crlf)
	(printout t "WTCU = " ?self:WTCU crlf)
	(printout t "MLT = " ?self:MLT crlf)
	(printout t "Ac = " ?self:Ac crlf)
	(printout t "Wa = " ?self:Wa crlf)
	(printout t "Ap = " ?self:Ap crlf)
	(printout t "Kg = " ?self:Kg crlf)
	(printout t "At = " ?self:At crlf)
	(printout t "===============" crlf)
	(printout t " END CORE-DATA" crlf)
	(printout t "===============" crlf)
)


; TABLE CREATION
; Pg. 120 of Transformer and Inductor Design Handbook (2nd Edition). Colonel Wm. T. McLymans

(deffunction core-data-table-create-table ()
	(make-instance of CORE-DATA (cat-num CL-1) 		(D 0.635) (E 0.317) (F 0.635) (G 1.270) (MPL 4.60) (HT 1.9) (WTH 1.3) (LT 1.9) (WTFE 0.006) (WTCU 0.009) (MLT 3.3) 	(Ac 0.18) (Wa 0.81) 	(Ap 0.14) 	(Kg 0.003136) (At 17.7) )
	(make-instance of CORE-DATA (cat-num CL-2) 		(D 0.635) (E 0.476) (F 0.635) (G 1.587) (MPL 5.60) (HT 2.5) (WTH 1.3) (LT 2.2) (WTFE 0.011) (WTCU 0.011) (MLT 3.6) 	(Ac 0.27) (Wa 1.01) 	(Ap	0.27) 	(Kg 0.008049) (At 22.4) )
	(make-instance of CORE-DATA (cat-num CL-3) 		(D 0.952) (E 0.476) (F 0.635) (G 1.587) (MPL 5.60) (HT 2.5) (WTH 1.6) (LT 2.2) (WTFE 0.017) (WTCU 0.017) (MLT 4.3) 	(Ac 0.40) (Wa 1.01) 	(Ap 0.41) 	(Kg 0.015411) (At 25.4) )
	(make-instance of CORE-DATA (cat-num CL-4) 		(D 0.635) (E 0.635) (F 0.635) (G 2.222) (MPL 7.40) (HT 3.5) (WTH 1.3) (LT 2.5) (WTFE 0.020) (WTCU 0.020) (MLT 3.9) 	(Ac 0.36) (Wa 1.41) 	(Ap 0.51) 	(Kg 0.018420) (At 29.8) )
	(make-instance of CORE-DATA (cat-num CL-5) 		(D 0.952) (E 0.635) (F 0.635) (G 2.222) (MPL 7.40) (HT 3.5) (WTH 1.6) (LT 2.5) (WTFE 0.030) (WTCU 0.023) (MLT 4.6) 	(Ac 0.54) (Wa 1.41) 	(Ap 0.76) 	(Kg 0.035698) (At 33.7) )
	(make-instance of CORE-DATA (cat-num CL-7) 		(D 0.952) (E 0.556) (F 0.794) (G 2.540) (MPL 8.10) (HT 3.7) (WTH 1.7) (LT 2.7) (WTFE 0.029) (WTCU 0.033) (MLT 4.7) 	(Ac 0.47) (Wa 2.02) 	(Ap 0.95) 	(Kg 0.038286) (At 40.9) )
	(make-instance of CORE-DATA (cat-num CL-6) 		(D 1.270) (E 0.635) (F 0.635) (G 2.222) (MPL 7.40) (HT 3.5) (WTH 1.9) (LT 2.5) (WTFE 0.040) (WTCU 0.027) (MLT 5.4) 	(Ac 0.72) (Wa 1.41) 	(Ap 1.01) 	(Kg 0.053643) (At 37.5) )
	(make-instance of CORE-DATA (cat-num CL-124) 	(D 1.270) (E 0.635) (F 0.794) (G 2.540) (MPL 8.40) (HT 3.8) (WTH 2.1) (LT 2.9) (WTFE 0.046) (WTCU 0.041) (MLT 5.7) 	(Ac 0.72) (Wa 2.02) 	(Ap 1.45) 	(Kg 0.073260) (At 47.1) )
	(make-instance of CORE-DATA (cat-num CL-121) 	(D 0.952) (E 0.635) (F 1.270) (G 3.334) (MPL 10.9) (HT 4.6) (WTH 2.2) (LT 3.8) (WTFE 0.045) (WTCU 0.084) (MLT 5.6) 	(Ac 0.54) (Wa 4.23) 	(Ap 2.28) 	(Kg 0.087935) (At 75.1) )
	(make-instance of CORE-DATA (cat-num CL-8) 		(D 0.952) (E 0.952) (F 0.952) (G 3.016) (MPL 10.7) (HT 4.9) (WTH 1.9) (LT 3.8) (WTFE 0.066) (WTCU 0.058) (MLT 5.7) 	(Ac 0.81) (Wa 2.87) 	(Ap 2.32) 	(Kg 0.131057) (At 63.5) )
	(make-instance of CORE-DATA (cat-num CL-9) 		(D 1.270) (E 0.952) (F 0.952) (G 3.016) (MPL 10.7) (HT 4.9) (WTH 2.2) (LT 3.8) (WTFE 0.088) (WTCU 0.067) (MLT 6.6) 	(Ac 1.08) (Wa 2.87) 	(Ap 3.09) 	(Kg 0.203180) (At 69.1) )
	(make-instance of CORE-DATA (cat-num CL-10) 	(D 1.587) (E 0.952) (F 0.952) (G 3.016) (MPL 10.7) (HT 4.9) (WTH 2.5) (LT 3.8) (WTFE 0.110) (WTCU 0.073) (MLT 7.2) 	(Ac 1.35) (Wa 2.87) 	(Ap 3.86) 	(Kg 0.289415) (At 74.6) )
	(make-instance of CORE-DATA (cat-num CL-12) 	(D 1.270) (E 1.111) (F 1.270) (G 2.857) (MPL 11.4) (HT 5.1) (WTH 2.5) (LT 4.8) (WTFE 0.110) (WTCU 0.095) (MLT 7.4) 	(Ac 1.26) (Wa 3.63) 	(Ap 4.56) 	(Kg 0.310621) (At 90.1) )
	(make-instance of CORE-DATA (cat-num CL-135) 	(D 1.270) (E 1.111) (F 1.429) (G 2.857) (MPL 11.7) (HT 5.1) (WTH 2.7) (LT 5.1) (WTFE 0.112) (WTCU 0.111) (MLT 7.6) 	(Ac 1.26) (Wa 4.08) 	(Ap 5.13) 	(Kg 0.338007) (At 100.2) )
	(make-instance of CORE-DATA (cat-num CL-11) 	(D 1.905) (E 0.952) (F 0.952) (G 3.016) (MPL 10.7) (HT 4.9) (WTH 2.9) (LT 3.8) (WTFE 0.131) (WTCU 0.080) (MLT 7.8) 	(Ac 1.61) (Wa 2.87) 	(Ap 4.64) 	(Kg 0.382920) (At 80.1) )
	(make-instance of CORE-DATA (cat-num CL-78) 	(D 1.905) (E 0.794) (F 0.794) (G 5.715) (MPL 15.0) (HT 7.3) (WTH 2.7) (LT 3.2) (WTFE 0.154) (WTCU 0.117) (MLT 7.3) 	(Ac 1.35) (Wa 4.54) 	(Ap 6.10) 	(Kg 0.452681) (At 97.9) )
	(make-instance of CORE-DATA (cat-num CL-18) 	(D 1.270) (E 1.111) (F 1.587) (G 3.969) (MPL 14.2) (HT 6.2) (WTH 2.9) (LT 5.4) (WTFE 0.136) (WTCU 0.176) (MLT 7.9) 	(Ac 1.26) (Wa 6.30) 	(Ap 7.91) 	(Kg 0.505077) (At 129.2) )
	(make-instance of CORE-DATA (cat-num CL-14) 	(D 1.270) (E 1.270) (F 1.270) (G 3.969) (MPL 14.2) (HT 6.5) (WTH 2.5) (LT 5.1) (WTFE 0.136) (WTCU 0.138) (MLT 7.7)	(Ac 1.44) (Wa 5.04) 	(Ap 7.23) 	(Kg 0.540205) (At 112.1) )
	(make-instance of CORE-DATA (cat-num CL-16) 	(D 1.905) (E 1.270) (F 1.270) (G 3.969) (MPL 14.2) (HT 6.5) (WTH 3.2) (LT 5.1) (WTFE 0.234) (WTCU 0.160) (MLT 8.3) 	(Ac 1.79) (Wa 5.04) 	(Ap 9.04) 	(Kg 0.779647) (At 119.5) )
	(make-instance of CORE-DATA (cat-num CL-15) 	(D 1.587) (E 1.270) (F 1.270) (G 3.969) (MPL 14.2) (HT 6.5) (WTH 2.9) (LT 5.1) (WTFE 0.195) (WTCU 0.149) (MLT 9.0) 	(Ac 2.15) (Wa 5.04) 	(Ap 10.84) 	(Kg 1.043079) (At 126.8) )
	(make-instance of CORE-DATA (cat-num CL-17) 	(D 2.540) (E 1.270) (F 1.270) (G 3.969) (MPL 14.2) (HT 6.5) (WTH 3.8) (LT 5.1) (WTFE 0.312) (WTCU 0.183) (MLT 10.2) (Ac 2.87) (Wa 5.04) 	(Ap 14.46) 	(Kg 1.624036) (At 141.5) )
	(make-instance of CORE-DATA (cat-num CL-19) 	(D 2.540) (E 1.270) (F 1.587) (G 3.969) (MPL 14.7) (HT 6.5) (WTH 4.1) (LT 5.7) (WTFE 0.323) (WTCU 0.240) (MLT 10.7) (Ac 2.87) (Wa 6.30) 	(Ap 18.08) 	(Kg 1.935620) (At 166.4) )
	(make-instance of CORE-DATA (cat-num CL-79) 	(D 1.270) (E 1.270) (F 2.222) (G 5.080) (MPL 18.0) (HT 7.6) (WTH 4.1) (LT 7.0) (WTFE 0.296) (WTCU 0.419) (MLT 10.5) (Ac 2.15) (Wa 11.29) 	(Ap 24.30) 	(Kg 2.001962) (At 231.0) )
	(make-instance of CORE-DATA (cat-num CL-21) 	(D 1.905) (E 1.587) (F 1.587) (G 4.921) (MPL 17.8) (HT 8.1) (WTH 3.5) (LT 6.3) (WTFE 0.365) (WTCU 0.280) (MLT 10.1) (Ac 2.69) (Wa 7.81) 	(Ap 21.02) 	(Kg 2.242302) (At 183.6) )
	(make-instance of CORE-DATA (cat-num CL-20) 	(D 2.540) (E 1.587) (F 1.587) (G 3.969) (MPL 15.7) (HT 7.1) (WTH 4.1) (LT 6.3) (WTFE 0.431) (WTCU 0.254) (MLT 11.4) (Ac 3.59) (Wa 6.30) 	(Ap 22.60) 	(Kg 2.855327) (At 182.0) )	
)

