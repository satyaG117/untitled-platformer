extends Node

class_name StateMachine

var current_state : State
@export var starting_state : State
var states : Dictionary = {}
var label : Label

func init(parent):
	for child in get_children():
		if(child is State):
			child.parent = parent
			states[child.name.to_lower()] = child
	
	current_state = starting_state
	if(current_state):
		current_state.enter()
	


# used when its needed to transition into certain state regardless of what state its in
func force_transition(new_state_name : String):
	if(current_state):
		handle_state_transition(current_state, new_state_name)
		

func handle_state_transition(state : State , new_state_name : String) -> void:
	#if the calling state is not the current state current_state 
	# or new_state_name doesn't exist in the states dictionary then return
	#print("from : " + state.name + " to " + new_state_name)
	var new_state = states.get(new_state_name.to_lower());
	if(state != current_state || !new_state):
		return
	
	# else proceed
	current_state.exit()
	new_state.enter()
	current_state = new_state

func process_frame(delta):
	if(current_state):
		current_state.process_frame(delta)

func process_physics(delta):
	if(current_state):
		current_state.process_physics(delta)
