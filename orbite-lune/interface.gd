extends Control
class_name Interface

@export_group("Europe")
@export var Europe1 : Europe
@export var Europe2 : Europe
@export var Jupiter : Europe

@export_group("Textes")
@export var Distance : Label
@export var Pt : Label
@export var multiplicateur : Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	
	var distance_lunes = (Europe1.r_i - Europe2.r_i).length()
	
	if Europe1.length() < Europe2.length() :
		Pt.text = "Europe 1"
	else :
		Pt.text = "Europe 2"
	
	Distance.text = format_scientifique(distance_lunes)
	
	
func format_scientifique(valeur : float) -> String:
	"""Converti en format scientifique les nombres décimaux avec 3 décimales
	
	Parametre:
	valeur -- la valeur à afficher de façon scientifique
	
	Retour:
	une chaîne de caractères représentant ce nombre
	"""
	var nombre_decimales = int(log(valeur) / log(10))
	var nombre_presente = valeur / 10**nombre_decimales
	return "%.3f" % nombre_presente + "e" + "%s" % nombre_decimales


func _on_glissiere_value_changed(value: float) -> void:
	Europe1.multiplicateur_temps = value
	Europe2.multiplicateur_temps = value
	
	multiplicateur.text = "x%.2f" % value
