extends PanelContainer
@export_group("Textes")
@export var nom : Label
@export var masse : Label
@export var vitesse_perihelie : Label
@export var excentricite : Label
@export var periode_revolution : Label
@export var periode_rotation : Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func afficher_infos(nom_planètes:String, donnees: Dictionary):
	nom.text = donnees[nom]
	masse.text = donnees["masse"]
	vitesse_perihelie.text = donnees["vitesse_perihelie"]
	excentricite.text = donnees["exentricite"]
	periode_revolution.text = donnees["periode_revolution"]
