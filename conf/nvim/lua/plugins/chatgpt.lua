return {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
        if os.getenv("OPENAI_API_KEY") then
            require("chatgpt").setup()
            vim.keymap.set('n', '`', '<CMD>ChatGPT<CR>', {})
        end
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
    }
}
