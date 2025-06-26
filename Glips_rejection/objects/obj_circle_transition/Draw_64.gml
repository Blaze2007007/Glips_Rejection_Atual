if (transitioning) {
    // Desenhar máscara circular preta usando surface para melhor performance
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    
    // Criar surface se não existir
    if (!surface_exists(circle_surface)) {
        circle_surface = surface_create(gui_w, gui_h);
    }
    
    // Desenhar na surface
    surface_set_target(circle_surface);
    draw_clear_alpha(c_black, 1.0); // Preencher tudo de preto
    
    // Desenhar círculo transparente no centro (área visível)
    gpu_set_blendmode(bm_subtract);
    draw_set_color(c_white);
    draw_circle(center_x, center_y, circle_radius, false);
    gpu_set_blendmode(bm_normal);
    
    surface_reset_target();
    
    // Desenhar a surface na tela
    draw_surface(circle_surface, 0, 0);
    
    // Reset das configurações
    draw_set_color(c_white);
    draw_set_alpha(1);
}