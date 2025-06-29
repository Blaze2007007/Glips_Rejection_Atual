if (transitioning) {
    timer++;
    
    switch(phase) {
        case 0: // Fade in (escurecer)
            alpha += fade_speed;
            if (alpha >= 0.8) {
                alpha = 0.8;
                phase = 1;
                timer = 0;
            }
            break;
            
        case 1: // Mostrar texto "FIM DO JOGO"
            text_alpha += fade_speed * 2;
            if (text_alpha >= 1) {
                text_alpha = 1;
            }
            
            if (timer >= text_display_time) {
                phase = 2;
                timer = 0;
            }
            break;
            
        case 2: // Mostrar botões e aguardar escolha
            button_alpha += fade_speed * 2;
            if (button_alpha >= 1) {
                button_alpha = 1;
            }
            
            // Navegação com teclado
            if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
                selected_button = 0; // Reiniciar
            }
            if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
                selected_button = 1; // Menu
            }
            
            // Seleção com Enter/Espaço
            if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
                if (selected_button == 0) {
                    // Reiniciar nível
                    restart_level();
                } else {
                    // Ir para menu
                    go_to_menu();
                }
            }
            
            // Seleção com mouse
            var mouse_gui_x = device_mouse_x_to_gui(0);
            var mouse_gui_y = device_mouse_y_to_gui(0);
            
            // Verificar hover nos botões
            if (point_in_rectangle(mouse_gui_x, mouse_gui_y, 
                gui_width/2 - 100, button_restart_y - 20, 
                gui_width/2 + 100, button_restart_y + 20)) {
                selected_button = 0;
                
                if (mouse_check_button_pressed(mb_left)) {
                    restart_level();
                }
            }
            
            if (point_in_rectangle(mouse_gui_x, mouse_gui_y, 
                gui_width/2 - 100, button_menu_y - 20, 
                gui_width/2 + 100, button_menu_y + 20)) {
                selected_button = 1;
                
                if (mouse_check_button_pressed(mb_left)) {
                    go_to_menu();
                }
            }
            break;
    }
}

// Funções dos botões
function restart_level() {
    // Resetar todos os inimigos às posições originais
    reset_all_enemies();
    
    // Resetar dados para checkpoint
    var checkpoint_data = get_checkpoint_data();
    global.player_data = checkpoint_data;
    global.vida = checkpoint_data.vida;
    global.pontos = checkpoint_data.pontos;
    global.dead = false;
    
    // Salvar dados resetados
    if (instance_exists(obj_data_manager)) {
        save_player_data(global.player_data, obj_data_manager.arquivo_dados);
    }
    
    // Posicionar jogador IMEDIATAMENTE (antes de destruir a transição)
    if (instance_exists(obj_slime_pai)) {
        obj_slime_pai.x = checkpoint_data.posicao._x;
        obj_slime_pai.y = checkpoint_data.posicao._y;
        obj_slime_pai.state = STATES.IDLE;
        obj_slime_pai.vely = 0;
        obj_slime_pai.velx = 0;
        
        // Garantir que o jogador fica visível e ativo
        obj_slime_pai.visible = true;
        obj_slime_pai.image_alpha = 1;
    }
    
    // Remover transição (agora o jogador já está reposicionado)
    instance_destroy();
}

function go_to_menu() {
    // Criar transição circular para o menu como outros botões fazem
    start_circle_transition_to_menu(rm_inicio)
    
    // Limpar objetos como obj_menu faz
    if (instance_exists(obj_slime_pai) && !transitioning) {
        instance_destroy(obj_slime_pai);
    }
    
    if (instance_exists(obj_bg)) {
        obj_bg.image_alpha = 0;
    }
    
    // Remover transição de game over
    instance_destroy();
}