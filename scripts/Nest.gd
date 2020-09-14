extends Node2D

export (PackedScene) var ant;

signal antSpawned;

func _ready():
	add_to_group('nests');

func _on_SpawnTimer_timeout():
	if(ant && Simulator.numAnts < Simulator.maxAnts):
		var antInstance = ant.instance();
		add_child(antInstance);
		emit_signal('antSpawned', antInstance);

# func _process(delta):
# 	pass;
