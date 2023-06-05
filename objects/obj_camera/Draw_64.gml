var string_format_commas = function(str) {
	str = string(str);
    for (var i = string_length(str) - 2; i > 0; i -= 3) {
        str = string_insert(",", str, i);
    }
    if (string_char_at(str, 1) == ",") {
        str = string_delete(str, 1, 1);
    }
    return str;
};

draw_set_colour(c_black);
draw_set_alpha(0.5);
draw_rectangle(0, 0, 400, 172, false);
draw_set_alpha(1);
draw_set_colour(c_orange);
draw_set_font(fnt_default);
draw_text(32, 32, "FPS: " + string(fps));
draw_text(32, 64, "fps_real: " + string(fps_real));
draw_text(32, 96, "Vertices: " + string_format_commas(self.vertices));
draw_text(32, 128, "Triangles: " + string_format_commas(self.vertices / 3));

draw_set_colour(c_black);
draw_set_alpha(0.5);
draw_rectangle(0, window_get_height() - 96, 960, window_get_height(), false);
draw_set_alpha(1);
draw_set_colour(c_white);
draw_text(32, window_get_height() - 48, $"GameMaker version: {GM_runtime_version}");
draw_text(32, window_get_height() - 80, $"GPU model: {self.gpu_data}");