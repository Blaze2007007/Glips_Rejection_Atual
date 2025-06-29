function validate_player_data_structure(data) {
    // Se não é struct, retorna dados padrão
    if (!is_struct(data)) {
        show_debug_message("Dados não são uma estrutura válida");
        return Init_player_data();
    }
    
    var defaults = Init_player_data();
    var validated_data = {};
    
    // Validar e corrigir cada campo obrigatório
    
    // Vida (deve ser número entre 0 e 3 - permitir 0 para morte)
    if (variable_struct_exists(data, "vida") && is_numeric(data.vida) && 
        data.vida >= 0 && data.vida <= 3) {
        validated_data.vida = int64(data.vida);
    } else {
        validated_data.vida = defaults.vida;
        show_debug_message("Campo 'vida' inválido (deve ser 0-3), a usar valor padrão");
    }
    
    // Pontos (deve ser número entre 0 e 100)
    if (variable_struct_exists(data, "pontos") && is_numeric(data.pontos) && 
        data.pontos >= 0 && data.pontos <= 100) {
        validated_data.pontos = int64(data.pontos);
    } else {
        validated_data.pontos = defaults.pontos;
        show_debug_message("Campo 'pontos' inválido (deve ser 0-100), a usar valor padrão");
    }
    
    // Posição (deve ter _x e _y válidos)
    if (variable_struct_exists(data, "posicao") && is_struct(data.posicao)) {
        validated_data.posicao = {};
        
        if (variable_struct_exists(data.posicao, "_x") && is_numeric(data.posicao._x)) {
            validated_data.posicao._x = int64(data.posicao._x);
        } else {
            validated_data.posicao._x = defaults.posicao._x;
        }
        
        if (variable_struct_exists(data.posicao, "_y") && is_numeric(data.posicao._y)) {
            validated_data.posicao._y = int64(data.posicao._y);
        } else {
            validated_data.posicao._y = defaults.posicao._y;
        }
    } else {
        validated_data.posicao = defaults.posicao;
        show_debug_message("Campo 'posicao' inválido, a usar valor padrão");
    }
    
    // Slime (deve ser número válido)
    if (variable_struct_exists(data, "slime") && is_numeric(data.slime) && data.slime >= 0) {
        validated_data.slime = int64(data.slime);
    } else {
        validated_data.slime = defaults.slime;
        show_debug_message("Campo 'slime' inválido, a usar valor padrão");
    }
    
    // Validar campos boolean
    var boolean_fields = ["niv1", "niv2", "niv3", "ini1_morto", "ini2_morto", "ini3_morto", "conv_1"];
    
    for (var i = 0; i < array_length(boolean_fields); i++) {
        var field = boolean_fields[i];
        
        if (variable_struct_exists(data, field) && is_bool(data[$ field])) {
            validated_data[$ field] = data[$ field];
        } else {
            validated_data[$ field] = defaults[$ field];
            show_debug_message("Campo '" + field + "' inválido, a usar valor padrão");
        }
    }
    
    return validated_data;
}