/// @param target_room_id
/// @param [target_x]
/// @param [target_y]
/// @param [destroy_player_on_transition]
function start_circle_transition(target_room_id, target_x, target_y, destroy_player_on_transition) {
    // Verificar se já existe uma transição ativa
    if (instance_exists(obj_circle_transition)) {
        return false;
    }
    
    // Verificar se a sala destino é válida
    if (!room_exists(target_room_id)) {
        return false;
    }
    
    // Criar objeto de transição
    var transition = instance_create_depth(0, 0, -9999, obj_circle_transition);
    transition.target_room = target_room_id;
    transition.target_x = target_x;
    transition.target_y = target_y;
    transition.transitioning = true;
    transition.closing = true;
    transition.circle_radius = transition.max_radius; // Começar com tela visível
    
    // Pausar temporariamente o controlo do jogador durante a transição
    if (instance_exists(obj_slime_pai)) {
        obj_slime_pai.inmenu = true;
    }
    
    // Para salas que não precisam de jogador (como menus), não criar slime
    transition.create_player = (target_x != -1 && target_y != -1);
    
    // Flag para destruir jogador durante a transição (quando está tudo preto)
    transition.destroy_player_on_transition = destroy_player_on_transition;
    
    return true;
}