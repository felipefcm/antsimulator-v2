extends Node2D

func _ready():
	var nests = get_tree().get_nodes_in_group('nests');
	for nest in nests:
		nest.connect('antSpawned', self, 'onAntSpawned');

func onAntSpawned(_ant):
	Simulator.numAnts += 1;
