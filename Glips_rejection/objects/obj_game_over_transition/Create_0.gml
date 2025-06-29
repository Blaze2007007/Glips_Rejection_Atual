// obj_game_over_transition - Create Event
transitioning = false;
phase = 0; // 0=fade in, 1=mostrar texto, 2=mostrar botões, 3=aguardar escolha
timer = 0;
alpha = 0;
text_alpha = 0;
button_alpha = 0;
fade_speed = 0.02;
text_display_time = 90; // 1.5 segundos a 60fps

// Texto a mostrar
game_over_text = "FIM DO JOGO";

// Botões
selected_button = 0; // 0=Reiniciar, 1=Menu
button_restart_text = "REINICIAR";
button_menu_text = "MENU";
button_spacing = 80;

// Posições dos botões
gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
button_restart_y = gui_height/2 + 50;
button_menu_y = gui_height/2 + 130;