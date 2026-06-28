return {
    "FrancescoDerme/tuna.nvim",
    dir = "~/projects/tuna.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("tuna").setup({})
    end,
}
