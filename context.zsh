#!/bin/zsh

CONTEXT_FILE=$(find "${SCRIPT_DIR}/.tmp/" -name ".context_${pid}_??????" | head -n 1)
# Determine the current operating system for platform-specific handling
OS=$(uname)

# Update the context file
update_context() {
    local his=$(history | grep -v '^[[:space:]]*[0-9]\+\*' | tail -16)

    print -r "$BUFFER" > $CONTEXT_FILE
    pwd >> $CONTEXT_FILE
    print -r "$his" >> $CONTEXT_FILE
    ls -p >> $CONTEXT_FILE
}

# Update the context file with current line buffer
update_context_buffer() {
    if [[ "$OS" == "Darwin" ]]; then
        sed -i '' "1s|.*|$(_zsh_autosuggest_escape_command "${BUFFER:-}")|" "$CONTEXT_FILE"
        #sed -i '' "1s/.*/$(printf "%s" "${BUFFER:-}" | sed 's/[\/&]/\\&/g')/" "$CONTEXT_FILE"
    else
        sed -i "1s|.*|$(_zsh_autosuggest_escape_command "${BUFFER:-}")|" "$CONTEXT_FILE"
        #sed -i "1s/.*/$(printf "%s" "${BUFFER:-}" | sed 's/[\/&]/\\&/g')/" "$CONTEXT_FILE"
    fi
}


# Set up hooks to update suggestions as you type
autoload -U add-zle-hook-widget
add-zle-hook-widget line-init update_context
add-zle-hook-widget zle-line-pre-redraw update_context_buffer
