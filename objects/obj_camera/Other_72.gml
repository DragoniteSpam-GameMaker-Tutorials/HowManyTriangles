/*if ds_map_find_value(async_load, "id") == loadid
{
    if ds_map_find_value(async_load, "status") == false
    {
        show_debug_message("Load failed!");
    }
}
*/
var decompressed = buffer_decompress(self.async_buffer);
var vb = vertex_create_buffer_from_buffer(decompressed, FORMAT);

vertex_freeze(vb);
buffer_delete(decompressed);
buffer_delete(self.async_buffer);
self.async_buffer = -1;
array_push(self.vertex_buffers, vb);
self.vertices += vertex_get_number(vb);