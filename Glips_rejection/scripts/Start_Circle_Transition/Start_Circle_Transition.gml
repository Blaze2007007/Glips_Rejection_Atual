function start_circle_transition(target_room_id) {
    // Verificar se já existe uma transição ativa
    if (instance_exists(obj_circle_transition)) {
        return false;
    }
    
    // Criar objeto de transição
    var transition = instance_create_depth(0, 0, -9999, obj_circle_transition);
    transition.target_room = target_room_id;
    transition.transitioning = true;
    transition.closing = true;
    transition.circle_radius = 0;
    
    return true;
}