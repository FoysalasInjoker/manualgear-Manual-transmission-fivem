🚗 FiveM Manual Gear System
A fully functional manual gear system for FiveM, allowing players to shift gears manually for a more immersive driving experience.


📦 Features
✅ Manual Gear System (1-6, Neutral, Reverse)
✅ Gear Display & Notifications using ox_lib
✅ Configurable Max Gears & Speed Limits
✅ Supports Toggle Between Manual & Automatic
✅ Realistic Speed & RPM Scaling Per Gear
✅ Proper Neutral (N) & Reverse (R) Mechanics

🛠️ Dependencies
This script requires:

ox_lib (For notifications)
Ensure ox_lib is running in your server.cfg:


ensure ox_lib



🎮 Controls & Commands
Action	Default Keybind	Command	Description
Shift Up Gear	E	/shift_up	Move up one gear (if not at max gear)
Shift Down Gear	Q	/shift_down	Move down one gear (includes Neutral & Reverse)
Toggle Manual Gears	G	/toggle_manual_gears	Enable or disable manual gear shifting
🔧 Keybinds can be changed via FiveM's RegisterKeyMapping feature in settings.

⚙️ Configuration (config.lua)
Customize the gear system by editing config.lua.


config = {
    gearText = "R N [1] 2 3 4 5 6", -- Display format for gears
    maxGear = 6, -- Maximum number of forward gears
    minGear = 0, -- Reverse gear (R)
    neutralGear = -1, -- Neutral gear (N)
    
    keyShiftUp = "E", -- Key to shift up
    keyShiftDown = "Q", -- Key to shift down
    keyToggleManual = "G", -- Key to toggle manual gears
    
    maxSpeeds = {-15, 0, 15, 30, 50, 80, 110, 150}, -- Speed per gear
    rpmMultiplier = {0.3, 0.0, 0.3, 0.5, 0.7, 0.85, 1.0, 1.2}, -- RPM adjustments per gear
    
    enableCarAutoRollOnDrive = false -- Prevents car from rolling forward automatically in Drive
}
📢 Notifications
All gear changes and toggles use ox_lib notifications:

Shift Up (E) → Red Notification (Bottom Center)
Shift Down (Q) → Green Notification (Bottom Center)
Neutral (N) Selected → "Neutral" Notification (Locks Speed)
Reverse (R) Selected → "Reverse" Notification (Allows Reverse Movement)
Manual Gears Toggled (G) → "Manual Gears Enabled/Disabled"
📌 Installation
Step 1: Download & Install
Download & Extract the script into your resources folder.
Ensure ox_lib is installed & running.
Add the resource to your server.cfg:

ensure manual-gears
Restart your server & enjoy the manual gear experience! 🚗💨
🚀 Future Updates
 GUI for Gear Display
 Clutch & RPM Simulation
 Custom Sounds for Shifting
📩 Support & Contributions
🤝 Contributing
Feel free to fork, submit pull requests, or suggest features via Issues.



📜 License: MIT License - Use, modify, and distribute freely! 🚗⚙️
🔥 Enjoy the road with full control! Let us know if you have any feedback. 😊
