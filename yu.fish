# \  _/\_
#  ><_  _*>   鱼
# /   \/
function yu
    set -l options (fish_opt -s u -l ui)
    set script_path (dirname (status -f))

    # make a list of all files in /core and link to .config/fish/functions
    set categories aliases core tools
    if set -q _flag_ui
        echo "UI flag detected"
        set categories $categories ui
    end
    for category in $categories
        echo "Linking $category scripts"
        for file in $script_path/$category/*.fish
            ln -s $file ~/.config/fish/functions/(basename $file)
            echo "~> $file"
        end
    end

    # add set_profile to ~/.config/fish/config.fish if not already there
    if not grep -q "set_profile" ~/.config/fish/config.fish
        echo "Adding set_profile to ~/.config/fish/config.fish"
        if set -q _flag_ui
            echo "set_profile -u;" >> ~/.config/fish/config.fish
        else 
            echo "set_profile;" >> ~/.config/fish/config.fish
        end
    else 
        echo "set_profile already in ~/.config/fish/config.fish"
    end
end