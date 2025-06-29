function reset_enemy_to_spawn() {
    x = spawn_x;
    y = spawn_y;
    vely = 0;
    movex = 0;
    state = ENEMYSTATES.IDLE;
    global.vida_inimigo = spawn_hp;
    count1 = 0;
    count2 = 0;
    count3 = 0;
    pode_mudar = false;
    opcao = 0;
    
    // Reset sprite para idle
    if (enemy_id == 1) {
        sprite_index = sprite_ini_idle;
        image_xscale = 1.5;
    } else {
        sprite_index = sprite_ini_idle;
    }
}

function reset_all_enemies() {
    // Reset hollow inimigos
    with (obj_hollow) {
        reset_enemy_to_spawn();
    }
    
    // Reset boomba inimigos  
    with (obj_boomba) {
        reset_enemy_to_spawn();
    }
    
    // Reset qualquer outro tipo de inimigo que herde de obj_inimigo
    with (obj_inimigo) {
        reset_enemy_to_spawn();
    }
}