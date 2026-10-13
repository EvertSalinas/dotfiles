return {
  "3rd/image.nvim",
  build = false, -- use the magick_cli processor instead of building the Lua rock
  opts = {
    backend = "kitty", -- Ghostty implements Kitty's graphics protocol
    processor = "magick_cli",
    integrations = {
      markdown = {
        enabled = true,
        only_render_image_at_cursor = false,
      },
    },
    max_width = 100,
    max_height = 12,
    -- hijack_file_patterns defaults to png/jpg/jpeg/gif/webp/avif, so opening
    -- one of those files renders it directly.
  },
}
