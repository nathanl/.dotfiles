# Configuration

The "SmartSet" key looks like a rotating gear, top left on the right side.
The hotkeys have numbers with circles; hotkey 3 is just below SmartSet.

- To open the v-drive where config is stored, SmartSet + HotKey 3
- Change any config
- Eject the drive in finder
- SmartSet + HotKey 3 to close the drive
- SmartSet + HotKey 4 to reload config from v-drive

# Thumb clusters

The older Kinesis Advantage had the top row of thumb cluster keys in the following order, left to right:
Left hand: Command/Windows, Alt; Right hand: Control, Command/Windows
The Kinesis Advantage 360 shipped with this instead:
Left hand: Control, Alt; Right hand: Command/Windows, Ctrl

I have remapped it to use the older layout to which I'm accustomed and physically changed the keycaps to match.

## Tmux

At one point, I had used vdrive to map "command + m" to send "control + b" for Tmux.
This stopped working inexplicably.
But since I only want this in iTerm2 anyway, I did the following:

- iTerm 2 Settings
- Keybindings > Keys
- Plus to add one
- keyboard shortcut command + m
- action "send text with "vim" Special Chars
- `\<C-b>`

## Comments

Support says: "You can annotate with text *in between asterisks* it will be ignored!"
