function safe_json_parse(json_string) {
    try {
        var parsed = json_parse(json_string);
        return validate_player_data_structure(parsed);
    } catch (e) {
        show_debug_message("JSON corrupto detectado: " + string(e));
        show_debug_message("A usar dados padrão...");
        return Init_player_data();
    }
}