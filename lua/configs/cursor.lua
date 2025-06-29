require("smear_cursor").setup({
  legacy_computing_symbols_support = true,
  transparent_bg_fallback_color = "#303030",
  hide_target_hack = false,
  never_draw_over_target = true,
  stiffness = 0.8,                      -- 0.6      [0, 1]
  trailing_stiffness = 0.5,             -- 0.4      [0, 1]
  stiffness_insert_mode = 0.7,          -- 0.5      [0, 1]
  trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
  damping = 0.65,                       -- 0.6      [0, 1]
  distance_stop_animating = 0.5,        -- 0.1      > 0
})
