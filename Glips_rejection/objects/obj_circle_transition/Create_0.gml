circle_radius = display_get_gui_width(); // Começar com círculo grande (visível)
min_radius = 0; // Raio mínimo (tela preta)
max_radius = display_get_gui_width(); // Raio máximo (tela visível)
radius_speed = 15; // Velocidade da transição
transitioning = false;
target_room = -1;
target_x = 170;
target_y = 600;
closing = true; // true = fechando círculo, false = abrindo
center_x = display_get_gui_width() / 2;
center_y = display_get_gui_height() / 2;