--[[
    User patch for Project: Title. Change the layout of the metadata lines in List/Grid views.
    
    Default behavior: Author • Series (on one line or split depending on settings)
    Patched behavior: 
        Series
        Author
    
    This results in a visual stack of:
    1. Title
    2. Series
    3. Author
    4. Tags (if enabled in settings)
--]]

local userpatch = require("userpatch")

local function patchCoverBrowser(plugin)
    local ptutil = require("ptutil")
    local util = require("util")

    function ptutil.formatAuthorSeries(authors, series, series_mode, show_tags)
        local formatted_author_series = ""

        if authors and authors ~= "" then
            local authors_list = util.splitToArray(authors, "\n")
            authors = table.concat(authors_list, ptutil.separator.comma)
        else
            authors = ""
        end

        if series_mode == "series_in_separate_line" and series and series ~= "" then
            if authors ~= "" then
                formatted_author_series = series .. "\n" .. authors
            else
                formatted_author_series = series
            end
        else
            formatted_author_series = authors
        end

        return formatted_author_series
    end
end

userpatch.registerPatchPluginFunc("coverbrowser", patchCoverBrowser)
