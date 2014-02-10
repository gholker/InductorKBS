; CORE CONSTANTS

; OBJECT DEFINITION

(defclass CORE-CONSTANTS (is-a USER)
	(slot core
		(type SYMBOL))
	(slot Kj25
		(type NUMBER))
	(slot Kj50
		(type NUMBER))
	(slot x
		(type NUMBER))
	(slot y
		(type NUMBER))
)

(defmessage-handler CORE-CONSTANTS get-Kj ()
	(round (/ (+ ?self:Kj25 ?self:Kj50) 2))
)

(deffunction core-constants-compare ( ?c1 ?c2 )
	(and
		(= 0 (str-compare (send ?c1 get-core) (send ?c2 get-core)))
		(= (send ?c1 get-Kj25) (send ?c2 get-Kj25))
		(= (send ?c1 get-Kj50) (send ?c2 get-Kj50))
		(= (send ?c1 get-x) (send ?c2 get-x))
		(= (send ?c1 get-y) (send ?c2 get-y))
	)
)

; TABLE CREATION
; Pg. 106 of Transformer and Inductor Design Handbook (2nd Edition). Colonel Wm. T. McLyman

(deffunction core-constants-create-table ()

	(make-instance PotCore 			of CORE-CONSTANTS (core POT-CORE) 			(Kj25 433) (Kj50 632) (x 1.20) (y -.17) )
	(make-instance PowderCore 		of CORE-CONSTANTS (core POWDER-CORE) 		(Kj25 403) (Kj50 590) (x 1.14) (y -.12) )
	(make-instance Lamination 		of CORE-CONSTANTS (core LAMINATION) 		(Kj25 366) (Kj50 534) (x 1.14) (y -.12) )
	(make-instance CCore 			of CORE-CONSTANTS (core C-CORE) 			(Kj25 323) (Kj50 468) (x 1.16) (y -.14) )
	(make-instance SingleCoil 		of CORE-CONSTANTS (core SINGLE-COIL) 		(Kj25 395) (Kj50 569) (x 1.16) (y -.14) )
	(make-instance TapeWoundCore 	of CORE-CONSTANTS (core TAPE-WOUND-CORE) 	(Kj25 250) (Kj50 365) (x 1.15) (y -.13) )
)

; PRINT

(defmessage-handler CORE-CONSTANTS print ()
	(printout t "====================" crlf)
	(printout t "  CORE-CONSTANTS" crlf)
	(printout t "====================" crlf)
	(printout t "core = " ?self:core crlf)
	(printout t "Kj25 = " ?self:Kj25 crlf)
	(printout t "Kj50 = " ?self:Kj50 crlf)
	(printout t "x = " ?self:x crlf)
	(printout t "y = " ?self:y crlf)
	(printout t "====================" crlf)
	(printout t " END CORE-CONSTANTS" crlf)
	(printout t "====================" crlf)
)