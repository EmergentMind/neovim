-- mini.base16 colorscheme configuration
return {
  "mini.base16",
  after = function(plugin)
    local json_path = os.getenv("HOME") .. "/.config/stylix/palette.json"
    local json_file = io.open(json_path, "r")
    local palette
    if not json_file then
      palette = {
        base00 = "#282828", --  ----      background
        base01 = "#212F3D", --  ---       lighter background status bar
        base02 = "#504945", --  --        selection background
        base03 = "#928374", --  -         Comments, Invisibles, Line highlighting
        base04 = "#BDAE93", --  +         dark foreground status bar
        base05 = "#D5C7A1", --  ++        foreground, caret, delimiters, operators
        base06 = "#EBDBB2", --  +++       light foreground, rarely used
        base07 = "#fbf1c7", --  ++++      lightest foreground, rarely used
        base08 = "#D05000", --  red       vars, xml tags, markup link text, markup lists, diff deleted
        base09 = "#FE8019", --  orange    Integers, Boolean, Constants, XML Attributes, Markup Link Url
        base0A = "#FFCC1B", --  yellow    Classes, Markup Bold, Search Text Background
        base0B = "#B8BB26", --  green     Strings, Inherited Class, Markup Code, Diff Inserted
        base0C = "#8F3F71", --  cyan      Support, Regular Expressions, Escape Characters, Markup Quotes
        base0D = "#458588", --  blue      Functions, Methods, Attribute IDs, Headings
        base0E = "#FABD2F", --  purple    Keywords, Storage, Selector, Markup Italic, Diff Changed
        base0F = "#B59B4D", --  darkred   Deprecated Highlighting for Methods and Functions, Opening/Closing Embedded Language Tags
      }
    else
      local json_colors = vim.fn.json_decode(json_file:read("*a"))
      json_file:close()
      palette = vim.tbl_map(function(v)
        return "#" .. v
      end, json_colors)
    end
    require("mini.base16").setup({ palette = palette })
  end,
}
