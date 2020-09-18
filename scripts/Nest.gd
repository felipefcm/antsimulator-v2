extends Node2D

export (PackedScene) var ant;
export (int) var antsPerSpawn = 1;

signal antSpawned;

func _ready():
	add_to_group('nests');
	$SpawnTimer.start();

func _on_SpawnTimer_timeout():
	if(ant && Simulator.numAnts < Simulator.maxAnts):
		for _i in range(antsPerSpawn):
			var antInstance = ant.instance();
			add_child(antInstance);
			emit_signal('antSpawned', antInstance);

func _on_Area2D_body_entered(body: Node):
	if(!body.is_in_group('antSteerable')): return;
	var antBody = body.get_parent();
	if(antBody.stateMachine.getCurrentState()):
		antBody.stateMachine.getCurrentState().onNest(self);

# func _process(delta):
# 	pass;
