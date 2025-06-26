if (transitioning) {
    if (closing) {
        // Círculo a fechar (raio diminui = fica mais escuro)
        circle_radius -= radius_speed;
        if (circle_radius <= min_radius) {
            circle_radius = min_radius;
            closing = false;
            
            // Mudar de sala quando está totalmente escuro
            room_goto(target_room);
            
            // Limpeza de instâncias
            if(instance_exists(obj_slimepegajoso))
                instance_destroy(obj_slimepegajoso);
            if(instance_exists(obj_limite))
                instance_destroy(obj_limite);
                
            // Posicionar jogador
            if(instance_exists(obj_slime_pai)) {
                obj_slime_pai.x = target_x;
                obj_slime_pai.y = target_y;
            }
        }
    } else {
        // Círculo a abrir (raio aumenta = fica mais claro)
        circle_radius += radius_speed;
        if (circle_radius >= max_radius) {
            circle_radius = max_radius;
            transitioning = false;
            instance_destroy();
        }
    }
}