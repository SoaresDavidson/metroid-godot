extends Node
class_name  FiniteStateMachine


@export var initial_state : State
var current_state : State
var states: Dictionary = {}

#ao inciar esse node FSM pega todos os seus filhos e coloca em um dicionario e conecta o sinal desses nodes
#a função change_state
#todo os states tem suas funções e sinais herdados da classe State
func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(change_state)
	#um state inicial é escolhido,seu metodo Enter é executado e se torna o current_state
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

#todos o nodes terão um Update e PhysicsUpdate que serão executados dentro dentro do _process e physics_process 
#do node pai:FSM,Meio que o FSM escolhe apenas um de seus filhos para que fique sendo executado
func _process(delta):
	if current_state:
		current_state.Update(delta)
	
func _physics_process(delta):
	if current_state:
		current_state.PhysicsUpdate(delta)

func change_state(state, new_state_name):
	#essa função so realiza a troca de estados caso a variavel state seja o estado atual
	#por padrão a troca de estado para estado
	if state != current_state:
		return
	#so continua a troca se o new_state_name esteja presente dentro do dicionario states
	var new_state = states.get(new_state_name.to_lower())
	if not new_state:
		return
	#caso o estado atual seja um objeto valido realiza sua função de saída:Exit
	if current_state:
		current_state.Exit()
	#realiza a função de entrada do novo estado:Enter e troca o estado atual pelo novo
	new_state.Enter()
	current_state = new_state
