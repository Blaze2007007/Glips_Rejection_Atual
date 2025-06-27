if (transitioning) {
    if (closing) {
        // Fase 1: Círculo a fechar (raio diminui = área visível diminui até ficar preto)
        circle_radius -= radius_speed;
        
        if (circle_radius <= min_radius) {
            circle_radius = min_radius;
            
            // Destruir jogador se necessário (quando está tudo preto)
            if (destroy_player_on_transition && instance_exists(obj_slime_pai)) {
                instance_destroy(obj_slime_pai);
            }
            
            // Trocar de sala quando está totalmente escuro
            room_goto(target_room);
            
            // Limpeza de instâncias problemáticas
            if(instance_exists(obj_slimepegajoso))
                instance_destroy(obj_slimepegajoso);
            if(instance_exists(obj_limite))
                instance_destroy(obj_limite);
                
            // Posicionar jogador na nova sala (só se necessário)
            if(create_player && target_x != -1 && target_y != -1) {
                if(instance_exists(obj_slime_pai)) {
                    obj_slime_pai.x = target_x;
                    obj_slime_pai.y = target_y;
                    // Resetar estado do jogador
                    obj_slime_pai.vely = 0;
                    obj_slime_pai.velx = 0;
                } else {
                    // Criar jogador se não existir
                    instance_create_depth(target_x, target_y, -1000, obj_slime_pai);
                }
            }
            
            // Aguardar um frame antes de começar a abrir
            closing = false;
        }
    } else {
        // Fase 2: Círculo a abrir (raio aumenta = área visível aumenta)
        circle_radius += radius_speed;
        
        if (circle_radius >= max_radius) {
            circle_radius = max_radius;
            transitioning = false;
            
            // Liberar controlo do jogador quando a transição terminar
            if (instance_exists(obj_slime_pai)) {
                obj_slime_pai.inmenu = false;
            }
            
            // Limpar surface
            if (surface_exists(circle_surface)) {
                surface_free(circle_surface);
            }
            
            // Destruir objeto de transição
            persistent = false; // Remover persistência antes de destruir
            instance_destroy();
        }
    }
}