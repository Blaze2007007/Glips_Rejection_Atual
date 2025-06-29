// obj_game_over_transition - Draw GUI Event
if (transitioning) {
    var gui_width = display_get_gui_width();
    var gui_height = display_get_gui_height();
    
    // Desenhar overlay escuro
    draw_set_alpha(alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_width, gui_height, false);
    
    // Desenhar título "FIM DO JOGO"
    if (phase >= 1) {
        draw_set_alpha(text_alpha);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_font(-1); // Font padrão ou definir uma específica
        draw_text_transformed(gui_width/2, gui_height/2 - 50, game_over_text, 2, 2, 0);
    }
    
    // Desenhar botões
    if (phase >= 2) {
        draw_set_alpha(button_alpha);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        
        // Botão Reiniciar
        if (selected_button == 0) {
            draw_set_color(c_yellow); // Destacar botão selecionado
            draw_text_transformed(gui_width/2, button_restart_y, button_restart_text, 1.2, 1.2, 0);
        } else {
            draw_set_color(c_white);
            draw_text(gui_width/2, button_restart_y, button_restart_text);
        }
        
        // Botão Menu
        if (selected_button == 1) {
            draw_set_color(c_yellow); // Destacar botão selecionado
            draw_text_transformed(gui_width/2, button_menu_y, button_menu_text, 1.2, 1.2, 0);
        } else {
            draw_set_color(c_white);
            draw_text(gui_width/2, button_menu_y, button_menu_text);
        }
        
        // Instruções (opcional)
        draw_set_color(c_gray);
        draw_text_transformed(gui_width/2, gui_height - 50, "Use W/S ou Rato para navegar, Enter/Clique para selecionar", 0.8, 0.8, 0);
    }
    
    // Reset das configurações de desenho
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}