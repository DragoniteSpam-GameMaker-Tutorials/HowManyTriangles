#macro BASE_FILE_NAME                               "compressed/Terrain_1024_vntc"
#macro large_terrain:BASE_FILE_NAME                 "compressed/Terrain_5400_vntc"

#macro simple_shader:BASE_FILE_NAME                 "compressed/Terrain_1024_v"
#macro large_terrain_simple_shader:BASE_FILE_NAME   "compressed/Terrain_5400_v"

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_colour();
self.format_vntc = vertex_format_end();

vertex_format_begin();
vertex_format_add_position_3d();
self.format_v = vertex_format_end();

#macro FORMAT                               self.format_vntc
#macro simple_shader:FORMAT                 self.format_v
#macro large_terrain_simple_shader:FORMAT   self.format_v

show_debug_overlay(true);

self.vertex_buffers = [];
self.vertices = 0;

self.to_load = [];

for (var i = 0; i < 100; i++) {
    for (var j = 0; j < 100; j++) {
        var filename = BASE_FILE_NAME + "." + string(i) + "_" + string(j) + ".vbuff";
        if (!file_exists(filename)) break;
        
        array_push(self.to_load, filename);
    }
}

self.async_buffer = buffer_create(1, buffer_grow, 1);
buffer_load_async(self.async_buffer, self.to_load[0], 0, -1);
array_delete(self.to_load, 0, 1);

var info = os_get_info();
// theres a lot of ways this can go wrong lol
try {
    //                      Windows                                *nix
    self.gpu_data = info[? "video_adapter_description"] ?? info[? "gl_renderer_string"];
} catch (e) {
    self.gpu_data = "idk lol";
}