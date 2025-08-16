```
   __  ___      __  __   _____
  /  |/  /___ _/ /_/ /__/ ___/____  ____ ______
 / /|_/ / __ `/ __/ // /\__ \/ __ \/ __ `/ ___/
/ /  / / /_/ / /_/ ,< ___/ / /_/ / /_/ (__  )
/_/  /_/\__,_/\__/_/|_/____/ .___/\__,_/____/
                          /_/
        macOS Setup & Personalization (mrk1)
```

# macOS Setup Script

This repository contains a Bash script that configures macOS with a curated set of preferences for security, usability, and performance.

The script automates changes such as:
- Security & privacy hardening
- Finder & Dock customization
- Screenshot storage & behavior
- General UI/UX tweaks
- Activity Monitor settings
- Automatic App Store updates
- Time Machine preferences

---

## 🚀 Usage

1. Clone or download this repository:

   ```bash
   git clone https://github.com/YOUR-USERNAME/macos-setup.git
   cd macos-setup
   ```

2. Make the script executable:

   ```bash
   chmod +x setup-macos.sh
   ```

3. Run the script:

   ```bash
   ./setup-macos.sh
   ```

You’ll be asked to confirm before changes are applied. The script requires **administrator privileges** for system-level settings.

---

## ⚙️ What It Does

### Security & System
- Require password immediately after sleep/screensaver
- Enable the built-in firewall
- Show hidden directories (`~/Library`, `/Volumes`)

### Finder
- Quit Finder with ⌘ + Q
- Default new window location → Desktop
- Show status bar & path bar
- Keep folders on top when sorting by name
- Avoid creating `.DS_Store` files on network/USB volumes
- List view as default
- Allow text selection in Quick Look

### Dock & Mission Control
- Position Dock on the left
- Set icon size to 36px
- Minimize windows into app icon
- Hide recent apps

### Screenshots
- Save to `~/Pictures/Screenshots`
- Disable floating thumbnail preview

### General UI/UX
- Save to disk by default (not iCloud)
- Always show scrollbars
- Expand save/print panels
- Enable fast keyboard repeat
- Disable smart quotes/dashes
- Enable full keyboard access

### Activity Monitor
- Show all processes
- Sort by CPU usage

### App Store
- Enable background update checks
- Auto-download updates
- Auto-install security updates

### Time Machine
- Prevent prompts to use new drives for backup

---

## 🛠 Notes

- Some changes require **logout or restart** to take effect.
- The script is idempotent: running it multiple times won’t break anything.
- You can safely edit the script to suit your personal preferences.

---

## ✅ Example Output

When running, you’ll see sections like:

```
--- Configuring Finder ---
--- Configuring Dock & Mission Control ---
--- Configuring Screenshots ---
...
✅ Done. Some changes may require a logout or restart to take full effect.
```

---

## 📜 License

MIT License. See [LICENSE](LICENSE) for details.
