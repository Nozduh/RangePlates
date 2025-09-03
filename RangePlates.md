# RangePlates

RangePlates is a lightweight World of Warcraft addon for Project Ascension (or any 3.3.5 server) that colors nameplates based on whether your target is in range for a chosen spell. It’s simple, efficient, and customizable with easy in‑game commands.

---

## Installation
1. Download the **RangePlates** folder.
2. Place it in your `World of Warcraft\Interface\AddOns` directory.
3. On the WoW character selection screen, click **AddOns** and make sure **RangePlates** is enabled.

---

## Usage
When targeting a unit with a visible nameplate:
- **Green** = target is in range of your chosen reference spell.
- **Red** = target is out of range.

---

## Commands

- **Set the reference spell**  
  `/rpspell [spell name]`  
  Example: `/rpspell Fireball`

- **Set nameplate colors**  
  `/rpcolor in [color name]`  
  `/rpcolor out [color name]`  
  Example: `/rpcolor in green` and `/rpcolor out red`

- **Available colors:**  
  red, green, blue, yellow, orange, magenta, pink, white, black, gray, purple, brown,  
  light red, light green, light blue, light orange, light magenta, light pink, light gray,  
  light purple, light brown

- **Reset settings**  
  `/rpreset` *(reloads your UI and restores defaults)*

- **Show help**  
  `/rphelp`

---

## Notes
- The chosen spell **must** be on your action bars for range detection to work.
- Works for both friendly and enemy targets.
- Great for casters and Hunters (e.g., `/rpspell Fireball` for Mage, `/rpspell Lightning Bolt` for Shaman).
- To disable, remove the **RangePlates** folder from your AddOns directory.

---

Enjoy