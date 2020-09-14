extends Node2D

export (NodePath) var antsLabel;

func _ready():
	var nests = get_tree().get_nodes_in_group('nests');
	for nest in nests:
		nest.connect('antSpawned', self, 'onAntSpawned');

func onAntSpawned(ant):
	Simulator.numAnts += 1;
	get_node(antsLabel).text = 'Ants: ' + var2str(Simulator.numAnts);
