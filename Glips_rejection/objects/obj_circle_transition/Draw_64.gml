if (transitioning) {
    // Método 1: Usando draw_circle com outline grosso
    var outline_width = max_radius - circle_radius;
    if (outline_width > 0) {
        // Desenhar círculo preto grosso que cobre tudo exceto o centro
        for (var i = 0; i < outline_width; i++) {
            draw_set_color(c_black);
            draw_set_alpha(0.1); // Alpha baixo para fazer várias camadas
            draw_circle(center_x, center_y, circle_radius + i, true);
        }
        draw_set_alpha(1);
    }
    
    // Se o raio for muito pequeno, cobrir tudo de preto
    if (circle_radius <= 5) {
        draw_set_color(c_black);
        draw_set_alpha(1);
        draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    }
    
    // Reset
    draw_set_color(c_white);
    draw_set_alpha(1);
}