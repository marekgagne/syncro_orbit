extends Node3D
#variables propres à chaque astre
@export var nom_planète : String
@export var masse_kg: float
@export var v_p_ms: float
@export var r_p_m: float
@export var v_a_ms: float
@export var r_a_m: float
@export var periode_revolution_s: float
@export var etapes_calcul_par_ecran: int
@export var v_i: Vector3
@export var r_i: Vector3

#changer la vitesse de la simulation en jour/écran
@onready var parent_node = get_parent()
var mult_jour_s: float

var acceleration_temps: float
var periode_relative: float


var G = 6.67e-11
var r_a_sim = 10
var r_p_sim = 2



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mult_jour_s = parent_node.accel_jour_s
	add_to_group("planetes")
	#application de l'accélération de la simulation
	acceleration_temps = mult_jour_s * 24 * 60 * 60
	#transformation de la position réelle en position simulée
	position = conv_position(r_i)
	

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#simulation du mouvement des astres
	appliquer_rk(delta)
	#Conversion de la position réelle résultante de appliquer_rk à la position simulée
	position = conv_position(r_i)

func calculer_acceleration_gravitationnelle(position_rellee: Vector3) -> Vector3:
	#détermine l'accélération d'un astre en fonction de sa position par rapport aux autres astres
	var force = Vector3(0,0,0)
	for autre in get_tree().get_nodes_in_group("planetes"):
		if autre.name == self.name:
			force += Vector3(0,0,0)
		else:
			var masse_autre = autre.masse_kg
			var pos_autre = autre.r_i
			var direction = pos_autre - position_rellee
			var distance = direction.length()
			if distance <= 0.1:
				distance = 0.1
			var v_unit = direction.normalized()
			force += v_unit * (G * masse_autre * masse_kg/(distance*distance))
	return force / masse_kg
	
func conv_position(position_reelle : Vector3) -> Vector3:
	#convertie la position réelle en position simulée 
	#à l'intérieur d'un minimum et maximum prédéterminé
	#problème de bornes fait en sorte que les astres sont
	#propulsés à de trop grandes distances 
	var distance_relle = position_reelle.length()
	var ratio_distance = inverse_lerp(r_p_m, r_a_m,
	distance_relle)
	var facteur_distance_simulee = lerp (r_p_sim, r_a_sim,
	ratio_distance)
	var v_unit_reelle = position_reelle.normalized()
	return v_unit_reelle * facteur_distance_simulee
	
func appliquer_rk(temps_dernier_ecran: float) -> void:
	#simule la vitesse et la position de l'astre grace à Runge-Kutta 4
	var temps_reel_par_ecran = temps_dernier_ecran  * acceleration_temps
	var h = temps_reel_par_ecran / etapes_calcul_par_ecran
	var vk1 =  calculer_acceleration_gravitationnelle(r_i)
	var vk2 = calculer_acceleration_gravitationnelle(r_i + vk1 * (h/2))
	var vk3 = calculer_acceleration_gravitationnelle(r_i + vk2 * (h/2))
	var vk4 = calculer_acceleration_gravitationnelle(r_i + vk3 * h)
	var v_plus_un = v_i + ((h/6) * (vk1 + 2 * vk2 + 2 * vk3 + vk4))
	
	var rk1 =  v_i
	var rk2 = v_i + rk1 * (h/2)
	var rk3 = v_i + rk2 * (h/2)
	var rk4 = v_i + rk3 * h
	var r_plus_un = r_i + ((h/6) * (rk1 + (2 * rk2) + (2 * rk3) + rk4))
	
	r_i = r_plus_un
	v_i = v_plus_un
	
	
func infos_planetes():
	#retourne les informations importantes quand on clique sur un astre
	return{
		"nom" : nom_planète,
		"masse" : masse_kg,
		"vitesse_perihelie" : v_p_ms,
		"exentricite" : calculer_exentricite(),
		"periode_revolution" : periode_revolution_s,
		"periode_rotation" : null
		}
	

func calculer_exentricite():
	#calcule l'excentricité de l'orbite d'un astre
	return ((r_a_m - r_p_m)/(r_a_m + r_p_m))
	
