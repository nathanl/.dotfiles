#!/usr/bin/env bash
# Organize audio files into Artist/Album subfolders based on tags.
#
# Usage: ./organize.sh [source_dir]
# Default: source_dir=.
#
# Requires: ffprobe (brew install ffmpeg)

set -euo pipefail

SRC="${1:-.}"
DRY_RUN="${DRY_RUN:-true}"   # Override with: DRY_RUN=false ./organize.sh

moved=0 skipped=0 errors=0

sanitize() {
    echo "$1" | sed 's/[<>:"\/\\|?*]/_/g; s/[. ]*$//' | sed 's/^$/Unknown/'
}

get_tag() {
    ffprobe -v quiet -show_entries format_tags="$1" -of default=noprint_wrappers=1:nokey=1 "$2" 2>/dev/null || true
}

find "$SRC" -maxdepth 1 -type f \( \
    -iname '*.mp3' -o -iname '*.m4a' -o -iname '*.flac' -o -iname '*.ogg' \
    -o -iname '*.opus' -o -iname '*.wma' -o -iname '*.aac' -o -iname '*.wav' \
    -o -iname '*.aiff' -o -iname '*.ape' -o -iname '*.mpc' -o -iname '*.wv' \
\) | while read -r f; do
    artist=$(get_tag "artist" "$f")
    album=$(get_tag "album" "$f")

    artist=$(sanitize "${artist:-Unknown Artist}")
    album=$(sanitize "${album:-Unknown Album}")

    filename=$(basename "$f")
    dest_dir="$SRC/$artist/$album"
    dest_path="$dest_dir/$filename"

    if [ -e "$dest_path" ]; then
        echo "  SKIP (exists): $filename"
        ((skipped++)) || true
        continue
    fi

    if [ "$DRY_RUN" = true ]; then
        echo "  [DRY RUN] $filename  →  $dest_dir/"
    else
        mkdir -p "$dest_dir"
        mv "$f" "$dest_path"
        echo "  MOVED: $filename  →  $dest_dir/"
    fi
    ((moved++)) || true
done

echo ""
echo "Done! Moved: $moved, Skipped: $skipped, Errors: $errors"
[ "$DRY_RUN" = true ] && echo "(Dry run. Set DRY_RUN=false to actually move files.)"
