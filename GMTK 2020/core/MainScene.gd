extends Control


onready var camera :Camera2D = get_node("Camera2D");
onready var mapController := get_node("MainMap");
onready var ghost := get_node("MainPlayer");

#UI
onready var UI := get_node("UI");


var currentLevel = 1;

var currentPlayableCharacter;

#Win variables
var amountOfCharactersInMap;
var amountCharacterTaken;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	yield(get_tree().create_timer(2), "timeout");
	StartGame();


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func StartGame():
	amountCharacterTaken = 0;
	amountOfCharactersInMap = mapController.GetAmountOfCharactersInMap();
	mapController.ReadyUpMap();
	yield(get_tree().create_timer(2), "timeout");
	ghost.EnterGhostToMap();
	pass

func WinGame():
	currentLevel += 1;
	StartGame();

func LostGame():
	RestartGame();

func RestartGame():
	mapController.RestartMapEntities();

func _input(event: InputEvent) -> void:
	HandleMovingPlayableCharacter();


func HandleMovingPlayableCharacter():
	pass


func GhostTookCharacter():
	amountCharacterTaken += 1;
	_checkIfWonGame();

func _checkIfWonGame():
	if(amountCharacterTaken >= amountOfCharactersInMap):
		WinGame();


func _on_TextureButton_pressed() -> void:
	get_tree().quit();
