; CORE_MATERIAL
; object stores data about the core material

(defclass CORE_MATERIAL (is-a USER)
	(slot composition)
	(slot saturated_flux_density)
	(slot dc_coercive_force)
	(slot squareness_ratio)
	(slot material_density)
	(slot curie_temperature)
	(slot weight_factor)
)