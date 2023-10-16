return {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
        if os.getenv("OPENAI_API_KEY") then
            require("chatgpt").setup()
        end
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
    }
}
