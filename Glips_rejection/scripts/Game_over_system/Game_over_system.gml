function get_checkpoint_data() {
    // Retorna dados de checkpoint baseado no nível atual
    var checkpoint_data = Init_player_data();
    
    switch(room) {
        case rm_nivel1:
            checkpoint_data.vida = 3;
            checkpoint_data.pontos = 0;
            checkpoint_data.posicao._x = 200;
            checkpoint_data.posicao._y = 420;
            checkpoint_data.niv1 = false; // Reset progresso do nível atual
            break;
            
        case rm_nivel2:
            checkpoint_data.vida = 3;
            checkpoint_data.pontos = 0;
            checkpoint_data.posicao._x = 170;
            checkpoint_data.posicao._y = 600;
            checkpoint_data.niv1 = true; // Mantém progresso anterior
            checkpoint_data.niv2 = false; // Reset progresso do nível atual
            break;
            
        case rm_nivel3:
            checkpoint_data.vida = 3;
            checkpoint_data.pontos = 0;
            checkpoint_data.posicao._x = 170;
            checkpoint_data.posicao._y = 600;
            checkpoint_data.niv1 = true; // Mantém progresso anterior
            checkpoint_data.niv2 = true; // Mantém progresso anterior
            checkpoint_data.niv3 = false; // Reset progresso do nível atual
            break;
            
        default:
            // Caso padrão para outras salas
            break;
    }
    
    return checkpoint_data;
}

function start_game_over_transition() {
    // Impede múltiplas chamadas
    if (instance_exists(obj_game_over_transition)) {
        return false;
    }
    
    // Criar objeto de transição "Game Over"
    var transition = instance_create_depth(0, 0, -10000, obj_game_over_transition);
    transition.transitioning = true;
    transition.phase = 0; // 0=fade in, 1=mostrar texto, 2=fade out, 3=respawn
    transition.timer = 0;
    
    return true;
}