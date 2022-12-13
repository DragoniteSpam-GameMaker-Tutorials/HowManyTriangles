#macro FROM_X                               0
#macro FROM_Y                               0
#macro FROM_Z                               (1000 / 4)
#macro TO_X                                 (1000 / 2)
#macro TO_Y                                 (1000 / 2)
#macro TO_Z                                 (-1000 / 4)

#macro large_terrain:FROM_X                 0
#macro large_terrain:FROM_Y                 0
#macro large_terrain:FROM_Z                 (5000 / 4)
#macro large_terrain:TO_X                   (5000 / 2)
#macro large_terrain:TO_Y                   (5000 / 2)
#macro large_terrain:TO_Z                   (-5000 / 4)

#macro large_terrain_simple_shader:FROM_X   0
#macro large_terrain_simple_shader:FROM_Y   0
#macro large_terrain_simple_shader:FROM_Z   (5000 / 4)
#macro large_terrain_simple_shader:TO_X     (5000 / 2)
#macro large_terrain_simple_shader:TO_Y     (5000 / 2)
#macro large_terrain_simple_shader:TO_Z     (-5000 / 4)

#macro SHADER                               shd_demo
#macro simple_shader:SHADER                 shd_demo_simple
#macro large_terrain_simple_shader:SHADER   shd_demo_simple

var cam = camera_get_active();

camera_set_view_mat(cam, matrix_build_lookat(FROM_X, FROM_Y, FROM_Z, TO_X, TO_Y, TO_Z, 0, 0, 1));
camera_set_proj_mat(cam, matrix_build_projection_perspective_fov(-60, -16 / 9, 1, 16000));
camera_apply(cam);

gpu_set_cullmode(cull_counterclockwise);
gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
shader_set(SHADER);

shader_set_uniform_f(shader_get_uniform(SHADER, "u_LightAmbient"), 0.1, 0.1, 0.1);

var ir3 = 1 / sqrt(3);

var directional_lights = [
    ir3, ir3, -ir3,
    -ir3, ir3, -ir3
];

var directional_light_colors = [
    0.5, 0.5, 0.5,
    0.3, 0.3, 0.3,
];

shader_set_uniform_f_array(shader_get_uniform(SHADER, "u_DirectionalLights"), directional_lights);
shader_set_uniform_f_array(shader_get_uniform(SHADER, "u_DirectionalLightColors"), directional_light_colors);

self.vertices = 0;

for (var i = 0, n = array_length(self.vertex_buffers); i < n; i++) {
    vertex_submit(self.vertex_buffers[i], pr_trianglelist, sprite_get_texture(spr_terrain, 0));
    self.vertices += vertex_get_number(self.vertex_buffers[i]);
}

// If you want to run the example by recycling the same chunk several times,
// comment out the above loop and uncomment this one. (It'll still take a few
// seconds to load in all of the chunks, however.)
/*
for (var i = 0; i < 6; i++) {
    for (var j = 0; j < 6; j++) {
        matrix_set(matrix_world, matrix_build(i * 1024, j * 1024, 0, 0, 0, 0, 1, 1, 1));
        vertex_submit(self.vertex_buffers[0], pr_trianglelist, sprite_get_texture(spr_terrain, 0));
        self.vertices += vertex_get_number(self.vertex_buffers[0]);
    }
}
*/

gpu_set_cullmode(cull_noculling);
gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);
shader_reset();
matrix_set(matrix_world, matrix_build_identity());