require('flash').setup({
        modes = {
          char = {
            jump_labels = true,
          },
          search = {
            highlight = {
              groups = {
                match = "FlashMatch",
              },
            },
          },
        },
      })
