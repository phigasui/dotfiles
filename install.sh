#!/bin/bash

for f in .??*
do
    [[ $f == ".git" ]] && continue
    [[ $f == ".DS_Store" ]] && continue
    [[ $f == ".claude" ]] && continue

    ln -sf $(echo $(pwd))/$f $HOME/$f
done

# ~/.claude: migrate real directory to symlink if needed
CLAUDE_SRC="$(pwd)/.claude"
CLAUDE_DEST="$HOME/.claude"
if [ -d "$CLAUDE_DEST" ] && [ ! -L "$CLAUDE_DEST" ]; then
    echo "Migrating ~/.claude to symlink..."
    # Carry over runtime data that is gitignored
    for item in backups cache debug file-history history.jsonl ide mcp-needs-auth-cache.json paste-cache plans policy-limits.json projects session-env shell-snapshots stats-cache.json statsig tasks telemetry todos usage-data memory; do
        [ -e "$CLAUDE_DEST/$item" ] && cp -a "$CLAUDE_DEST/$item" "$CLAUDE_SRC/$item"
    done
    for item in plugins/cache plugins/repos plugins/marketplaces plugins/install-counts-cache.json; do
        [ -e "$CLAUDE_DEST/$item" ] && cp -a "$CLAUDE_DEST/$item" "$CLAUDE_SRC/$item"
    done
    rm -rf "$CLAUDE_DEST"
fi
ln -sf "$CLAUDE_SRC" "$CLAUDE_DEST"

ln -sf $(echo $(pwd))/aquaskk/keymap.conf $HOME/Library/Application\ Support/AquaSKK/
