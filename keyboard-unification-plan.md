# Keyboard Unification Plan — Corne (ZMK) + macOS + Linux

## Goal

One consistent mental model across every keyboard and OS:

- **Ctrl** → always Ctrl (and, via the existing Karabiner rule, doubles as Cmd for
  copy/paste-style shortcuts outside terminals).
- **Left Option/Alt** → always Meta in Emacs (`emacsclient` in Ghostty), on the Corne
  and on a stock Apple keyboard, on macOS and Linux. Never touched by window-manager
  bindings.
- **The WM/navigation key** (thumb key on the Corne, right Option on a stock keyboard) →
  always triggers window navigation: Hyprland on Linux, AeroSpace on macOS. Never
  collides with app shortcuts (Cmd+C/V/H/F/M, browser Cmd+1-9, etc.) or with Emacs Meta.

## Why this shape (context for future-you)

- AeroSpace **cannot** distinguish left vs right Option in its own config — confirmed
  via upstream issues ([#579](https://github.com/nikitabobko/AeroSpace/issues/579),
  [#28](https://github.com/nikitabobko/AeroSpace/issues/28)). If AeroSpace binds plain
  `alt-h` etc., it intercepts that combo system-wide from *either* Option key, which
  would eat Emacs's `M-h`/`M-f`/`M-v`/etc. before Emacs ever sees them.
- Plain **Cmd** can't be AeroSpace's trigger either — it collides with native macOS
  shortcuts already in daily use (`Cmd+H` hide, `Cmd+V` paste, `Cmd+F` find, `Cmd+M`
  minimize, `Cmd+1..9` tab switching).
- Ghostty *can* distinguish left/right Option (`macos-option-as-alt = left|right|true|false`),
  and Karabiner *can* distinguish left/right Option and left/right Cmd. So the fix is to
  route AeroSpace's trigger through Karabiner as a translator into a synthetic,
  nothing-else-uses-it chord (`right_control+right_command`), rather than relying on
  AeroSpace to understand sides.
- The Corne's thumb key (`gui_layer4`) and the plain `&kp LGUI` pinky key currently both
  emit the same `LGUI` code, so Karabiner can't tell them apart. Changing the thumb
  macro to emit `RGUI` instead makes it a uniquely identifiable signal, and lets a
  Karabiner rule target *only* the thumb key without also breaking the pinky Cmd key.
- Today's Karabiner setup swaps `LALT ⇄ LGUI` for the Corne device. That's what makes
  AeroSpace work today (since `aerospace.toml` listens on `alt-`), but it also flips
  your intended Meta key into Cmd — which is the original bug report this plan fixes.

## Prerequisite

This plan requires reflashing the Corne with a firmware change. Do the ZMK step on
the machine where you can actually build/flash it (per your note, not this machine).

---

## Step 1 — ZMK firmware: `config/corne.keymap`

Change the `gui_layer4` macro to emit **`RGUI`** instead of `LGUI`, so the thumb key's
signal is unique on the wire (nothing else on the board sends `RGUI`).

```dts
macros {
    gui_layer4: gui_layer4 {
        compatible = "zmk,behavior-macro-one-param";
        #binding-cells = <1>;
        bindings =
            <&macro_press>,
            <&mo 4 &kp RGUI>,
            <&macro_pause_for_release>,
            <&macro_release>,
            <&kp RGUI &mo 4>;
    };
};
```

Only the two `LGUI` occurrences inside this macro change. Everything else in the
keymap (the plain `&kp LGUI` pinky key on the default layer, both `&kp LALT` keys,
`&kp LCTRL`, the `super_layer` numbers, etc.) stays exactly as-is.

Flash it, confirm via Karabiner-EventViewer (or `dmesg`/`evtest` on Linux) that holding
the thumb key now reports `right_gui`, not `left_gui`.

---

## Step 2 — Karabiner: `macos/.config/karabiner/karabiner.json`

### 2a. Remove the existing blind swap

Delete the `LALT ⇄ LGUI` / `RALT ⇄ RGUI` `simple_modifications` entries from the Corne's
device block (the one with `"product_id": 24926, "vendor_id": 7504` — confirm this is
really the Corne via Karabiner-EventViewer before deleting; `7504` = `0x1D50`, ZMK's
default USB vendor ID, which is why I believe this is it). You can keep the device
entry itself (e.g. for `treat_as_built_in_keyboard: false`) but its
`simple_modifications` array should end up empty or removed.

### 2b. Add a device-scoped rule: Corne's thumb key → AeroSpace chord

Add a `complex_modifications` rule scoped to the Corne's device identifiers, converting
`right_gui` (only ever produced by the thumb key) into the synthetic chord:

```json
{
    "description": "Corne thumb key (RGUI) -> AeroSpace trigger chord",
    "manipulators": [
        {
            "conditions": [
                {
                    "type": "device_if",
                    "identifiers": [
                        { "vendor_id": 7504, "product_id": 24926 }
                    ]
                }
            ],
            "from": {
                "key_code": "right_gui",
                "modifiers": { "optional": ["any"] }
            },
            "to": [
                { "key_code": "right_control", "modifiers": ["right_command"], "lazy": true }
            ],
            "type": "basic"
        }
    ]
}
```

Note: Karabiner modifier remaps are usually expressed by remapping the modifier key
itself (`from.key_code: right_gui` → `to: [{key_code: right_control, modifiers:
[right_command]}]`) so that holding it plus any other key produces
`right_control+right_command+<key>`. Test this in Karabiner-EventViewer and adjust to
whatever exact JSON shape actually produces `right_control+right_command` held
together — the "modifier remap" pattern (`simple_modifications` with two modifier key
codes) may end up simpler than a `complex_modifications` rule; use whichever Karabiner
accepts cleanly.

### 2c. Add a general (non-device-scoped) rule: stock keyboard fallback

Add a second rule, with **no** device condition, so it applies to any keyboard
(built-in, Bluetooth, conference-room Mac, etc.):

```json
{
    "description": "Right Option -> AeroSpace trigger chord (any keyboard)",
    "manipulators": [
        {
            "from": {
                "key_code": "right_alt",
                "modifiers": { "optional": ["any"] }
            },
            "to": [
                { "key_code": "right_control", "modifiers": ["right_command"], "lazy": true }
            ],
            "type": "basic"
        }
    ]
}
```

Left Option (`left_alt`) is never touched by any rule — it stays pure Meta everywhere.

### 2d. Keep as-is

The existing `Ctrl+letter → Cmd+letter (exceto terminais)` rule is untouched — it
already gives you unified Ctrl-based copy/paste and already excludes terminals.

---

## Step 3 — Ghostty: `~/.config/ghostty/config`

Change:

```
macos-option-as-alt = false
```

to:

```
macos-option-as-alt = left
```

This makes left Option send the Meta escape sequence `emacsclient` expects, while
leaving right Option free (it's now claimed by Karabiner for AeroSpace anyway, so this
also prevents Ghostty from double-interpreting it).

(Reminder: this file is a real file, not a dotfiles-managed symlink — `~/.config/kitty`
is a dangling symlink into an empty `dotfiles/terminal/`, unrelated leftover worth
cleaning up separately, not part of this plan.)

---

## Step 4 — AeroSpace: `~/.config/aerospace/aerospace.toml`

Replace every `alt-` prefix in `[mode.main.binding]` with `ctrl-cmd-` (matching the
`right_control+right_command` chord from Karabiner). Example diff shape:

```
- alt-h = 'focus left'
+ ctrl-cmd-h = 'focus left'
- alt-shift-h = 'move left'
+ ctrl-cmd-shift-h = 'move left'
- alt-1 = 'workspace 1'
+ ctrl-cmd-1 = 'workspace 1'
...
```

Apply this to all bindings currently prefixed `alt-` (h/j/k/l, tab, shift-tab,
shift-h/j/k/l, 1-9/0, shift-1..0, f, esc, shift-minus, shift-equal, m, shift-m, v,
shift-v, a, shift-s). Leave `[key-mapping]`, gaps, workspace-to-monitor assignment, and
`on-window-detected` sections untouched.

---

## Step 5 — Linux (Hyprland) — verify only, no changes expected

- Thumb key still sends `RGUI` (right Super) after the firmware change. Hyprland's
  generic `$mod = SUPER` binding matches Super from either side by default, so
  existing Hyprland keybinds should keep working unchanged.
- If anything doesn't fire, check whether Hyprland config binds specifically to
  `SUPER_L` anywhere — if so, change that specific bind to `SUPER` or `SUPER_R`.
- Left Alt (`LALT`) is unaffected on Linux — no Karabiner-equivalent runs there, so
  Emacs Meta already works natively; nothing to change.

---

## Testing checklist (after flashing + config changes)

1. Karabiner-EventViewer: confirm Corne thumb key reports `right_gui`.
2. Karabiner-EventViewer: confirm Corne thumb key, when combined with a letter,
   produces `right_control + right_command + <letter>`.
3. AeroSpace: `ctrl-cmd-h/j/k/l` moves focus; `ctrl-cmd-1..0` switches workspaces.
4. In Ghostty + `emacsclient`: left Option + a claimed AeroSpace letter (e.g. `M-f`,
   `M-v`, `M-a`, `M-h`, `M-m`) reaches Emacs as Meta and does **not** trigger AeroSpace.
5. Native macOS shortcuts unaffected: `Cmd+C/V`, `Cmd+H` (hide), `Cmd+F` (find),
   `Cmd+M` (minimize), browser `Cmd+1..9` tab switching all behave normally.
6. Portuguese accents still type correctly via Option dead-keys (`Option+e/i/n/u/\``)
   on a stock keyboard, using either Option side as before Step 2c — recheck this
   specifically since right Option is now also claimed by Karabiner for AeroSpace;
   if accent input on right Option breaks, that's expected (use left Option for
   typing accents, right Option is now WM-only).
7. Stock Apple keyboard fallback (no Corne): right Option + h/j/k/l triggers
   AeroSpace; left Option still works as Emacs Meta.
8. Linux with Corne: Hyprland navigation via thumb key still works.
9. Linux with a stock keyboard: Super key still drives Hyprland as before (unchanged
   baseline, should need no verification but worth a sanity check).

## Rollback

If anything above breaks in a way that's hard to debug live, the fastest rollback is:
revert `karabiner.json` and `aerospace.toml` via git, and reflash the previous
`corne.keymap`. Keep the current working state committed before starting so `git diff`
gives you a clean picture of exactly what changed.
