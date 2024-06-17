extends Node2D

var PlayerScene : PackedScene = preload("res://player.tscn")
var EnemyScene : PackedScene = preload("res://enemy.tscn")

var event_timer = 0

var event_list = [
	{
		"wait": 0,
		"scene": PlayerScene
	},
	{
		"wait": 1,
		"scene": EnemyScene
	},
	{
		"wait": 2,
		"scene": EnemyScene
	},
	{
		"wait": 3,
		"scene": EnemyScene
	},
	{
		"wait": 4,
		"scene": EnemyScene
	}
]


func process_script(level_script):
	for event in level_script:
		handle_event(event.wait, event.scene)
		

func handle_event(wait, scene) -> void:
	event_timer += wait
	
	await get_tree().create_timer(event_timer).timeout 
	
	var scene_instance = scene.instantiate()
	get_parent().add_child(scene_instance)


func _ready():
	process_script(event_list)
