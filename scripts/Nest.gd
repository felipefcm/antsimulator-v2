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
	if(body is Ant):
		var state = body.stateMachine.getCurrentState();
		if(state): state.onCollided(self);

# func _process(delta):
# 	pass;
