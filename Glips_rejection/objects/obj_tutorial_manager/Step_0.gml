if (!moved) {
    obj_bg.image_alpha = 0.75;
    if (keyboard_check_pressed(ord("A")) or keyboard_check_pressed(ord("D")) or 
        keyboard_check_pressed(vk_left) or keyboard_check_pressed(vk_right)) {
        moved = true;
        obj_bg.image_alpha = 0;
    }
}

if (moved && !jumped) {
    obj_bg.image_alpha = 0.75;
    if (keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up) or 
        keyboard_check_pressed(vk_space)) {
        jumped = true;
        obj_bg.image_alpha = 0;
    }
}

// HOLLOW - SEM PAUSAR O JOGO
if (instance_exists(obj_hollow)) {
    if (collision_circle(obj_hollow.x, obj_hollow.y, 100, obj_slime_pai, false, true) && !attacked) {
        global.gamepaused = true;  // PAUSA o jogo aqui!
        obj_bg.image_alpha = 0.75;
        
        // Anula velocidades do jogador e inimigo
        obj_slime_pai.salto = 0;
        obj_slime_pai.slimevel = 0;
        obj_hollow.movex = 0;
        
        if (keyboard_check_pressed(ord("E"))) {
            attacked = true;
            obj_bg.image_alpha = 0;
            global.gamepaused = false;  // Retoma o jogo
            
            // Restaura velocidades do jogador
            obj_slime_pai.salto = -35;
            obj_slime_pai.slimevel = 5;
        }
    }
    if (collision_circle(x, y, 32, obj_slime_pai, false, true) && global.vida < 3 && !warned) {
        if (count >= 180) {
            warned = true;
        } else {
            count++;
            // NÃO pausa o jogo aqui também!
            obj_bg.image_alpha = 0.75;
            global.vida = 2;
        }
    }
}

// MENU - mantém como está
if (keyboard_check_pressed(vk_escape) && image_alpha == 0) {
    image_alpha = 0.75;
    instance_create_depth(obj_slime_pai.x, yto, -100, obj_menu);
} else if (keyboard_check_pressed(vk_escape) && image_alpha == 0.75) {
    image_alpha = 0;
    instance_destroy(obj_menu);
}