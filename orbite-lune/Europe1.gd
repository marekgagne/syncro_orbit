extends RigidBody3D
class_name Europe

var multiplicateur_temps : float = 1

@export_group("Données d'orbite réelles")
@export var masse_europe: float 
@export var r_p_reelle: float
@export var v_p_reelle: float

"Valeurs données"
var periode: float = 299.819e3
var masse_jupiter: float = 1.989e27
var k:float = 1e14
var d:float = 24.97e6
var coef_dissip:float = 4e16

@export_group("Données de simulation")
@export var centre_de_rotation: RigidBody3D
@export var autre_moitié: RigidBody3D
@export var etapes_calcul_par_ecran : int
@export var periode_relative: float


"Création de vecteurs vides et préparation aux calculs"
var G  = 6.673e-11
var excentricite: float = (((v_p_reelle ** 2) * r_p_reelle)/(G * (masse_jupiter+ 2* masse_europe)))-1
var e: float = 0.0090519561382
var r_i : Vector3
var v_i: Vector3
"à changer"
var r_a_reelle = ((-1* e *(r_p_reelle) - r_p_reelle)/(e - 1)) + (d/2)
var r_p_simulee = 8.8145
var r_a_simulee = "7.2657"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	"Code appliqué au début de la simulation"
	
	r_i = r_p_reelle * Vector3(1, 0, 0)
	v_i = v_p_reelle * Vector3(0, 0, 1)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	"Le code appliqué à chaque écran pour déterminer la
	 position de tous les noeuds"
	
	appliquer_euler(delta)
	position = conv_position_reelle_a_simulee(r_i)
	if centre_de_rotation != null:
		position += centre_de_rotation.position
		



var r_diff_preced= Vector3(0,0,0)
func calculer_acceleration(position_reelle: Vector3, temps_dernier_ecran: float) -> Vector3:
	
	"Calcule l'ensemble des forces appliquées sur les deux points d'Europe
	et retourne l'accélération de ceux-ci (force / masse)"
	var force_frict = Vector3(0,0,0)
	var pos_autre_moitié = autre_moitié.r_i
	var r_diff= ( pos_autre_moitié- position_reelle)
	print("pos_autre moitié: ", pos_autre_moitié)
	print("pos_reelle: ", position_reelle)
	var r_diff_unit = r_diff.normalized()
	print("r_d_u: ", r_diff_unit)
	var r_diff_norme = r_diff.length()
	print("r_d_n: ", r_diff_norme)
	var facteur = -G * masse_europe * masse_jupiter / ((position_reelle.length())**3)
	var force_rappel = k * (r_diff_norme-d) * r_diff_unit
	print("rappel: ", force_rappel.length() * r_diff_unit)
	if r_diff_preced > Vector3(0,0,0):
		force_frict = ((r_diff - r_diff_preced) / temps_dernier_ecran) * coef_dissip
	var fg = position_reelle * facteur
	var force = fg + force_rappel + force_frict
	r_diff_preced = r_diff
	print("frict: ", force_frict)
	print("fg: ", fg)
	print("force = ", force)
	return force / masse_europe

func conv_position_reelle_a_simulee(position_reelle : Vector3) -> Vector3:
	
	"convertir les grandeures physiques astronomiquement larges en
	grandeures simulées assez petites pour être vues dans la simulation"
	
	var distance_relle = position_reelle.length()
	var ratio_distance = inverse_lerp(r_p_reelle, r_a_reelle,
	distance_relle)
	var facteur_distance_simulee = lerp (r_p_simulee, r_a_simulee,
	ratio_distance)
	return position_reelle.normalized() * facteur_distance_simulee

func appliquer_euler(temps_dernier_ecran : float) -> void:
	"utilise la méthode de euleur pour trouver la position et la vitesse 
	de chaque point pour un pas (h) donné"
	
	
	var nb_periode = temps_dernier_ecran  * periode / periode_relative
	var h = (nb_periode * multiplicateur_temps) / etapes_calcul_par_ecran
	for i in range(etapes_calcul_par_ecran):
		var a_i = calculer_acceleration(r_i, temps_dernier_ecran)
		var r_i_plus_1 = r_i + h * v_i
		var v_i_plus_1 = v_i + h * a_i
		r_i = r_i_plus_1
		v_i = v_i_plus_1
		
		#print("r_i = ", r_i.length())
		#print("v_i = ", v_i)
		#print("a_i = ", a_i)
		#print("e = ", e)
		#print("h = ", h)
		
		print("r_p:", r_p_reelle)
		#print("r_a:", r_a_reelle)
		print("r_p_s: ", r_p_simulee)
		print("r_a_s: ", r_a_simulee)
		#print("e: ", excentricite)
		
