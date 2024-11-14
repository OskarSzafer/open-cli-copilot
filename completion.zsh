#!/bin/zsh

OPTIONS_FILE=$(find "${SCRIPT_DIR}/.tmp/" -name ".options_${pid}_??????" | head -n 1)
previous_suggestion=""

# Define a custom strategy for zsh-autosuggest
_zsh_autosuggest_strategy_my_custom_suggestion() {
    # Temporary solution for the handling of special characters

    # returns error if $BUFFER contains \ or [
    typeset -g suggestion=$(grep -i "^$BUFFER" "$OPTIONS_FILE" 2>/dev/null | head -n 1)
    
    # returns error if $BUFFER contains ( or )
    # typeset -g suggestion=$(grep -i "^$(_zsh_autosuggest_escape_command "$BUFFER")" "$OPTIONS_FILE" | head -n 1)
}

_update_postdisplay() {
    POSTDISPLAY="${suggestion#$BUFFER}"
    zle redisplay
}
zle -N _update_postdisplay_widget _update_postdisplay

TRAPALRM() {
    _zsh_autosuggest_strategy_my_custom_suggestion
    if [[ -n "$suggestion" && "$suggestion" != "$previous_suggestion" ]]; then
        zle _update_postdisplay_widget
        previous_suggestion="$suggestion"
    fi
}
# Set the timer interval to 1 second
TMOUT=1


# Add as the first strategy to zsh-autosuggest plugin
export ZSH_AUTOSUGGEST_STRATEGY=(my_custom_suggestion $ZSH_AUTOSUGGEST_STRATEGY)
