-- Config file for gear system
config = {
    gearText = "R N [1] 2 3 4 5 6", -- Updated gear display to include Reverse (R) and Neutral (N)
    maxGear = 6, -- Maximum number of gears
    minGear = 0, -- Reverse gear
    neutralGear = -1, -- Neutral gear
    
    keyShiftUp = "E", -- Key to shift up gears
    keyShiftDown = "Q", -- Key to shift down gears
    keyToggleManual = "G", -- Key to toggle manual gear system
    
    maxSpeeds = {-15, 0, 15, 30, 50, 80, 110, 150}, -- Speed limits per gear (Reverse, Neutral, 1-6)
    rpmMultiplier = {0.3, 0.0, 0.3, 0.5, 0.7, 0.85, 1.0, 1.2}, -- RPM scaling per gear (Neutral = 0 RPM)
    
    enableCarAutoRollOnDrive = false -- Prevent automatic rolling on drive
}
