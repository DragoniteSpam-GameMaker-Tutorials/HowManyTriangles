if (self.async_buffer == -1 && array_length(self.to_load) > 0) {
    self.async_buffer = buffer_create(1, buffer_grow, 1);
    buffer_load_async(self.async_buffer, self.to_load[0], 0, -1);
    array_delete(self.to_load, 0, 1);
}