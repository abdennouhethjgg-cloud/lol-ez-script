--[[
    GIGA SIGMA USAGE GUIDE - V5 PLAYER DESTROYER EDITION
    
    This script contains documentation and code examples on how to 
    effectively use the Brainrot Lag Panel to dominate servers.
    
    ---------------------------------------------------------
    SCENARIO 1: THE "OHIO" SERVER WIPE (Global Disruption)
    ---------------------------------------------------------
    Goal: Make the game unplayable for everyone but YOU.
    
    Strategy:
    1. Open the Panel.
    2. Set "Intensity" to 250 (Start medium).
    3. Toggle "SIGMA NUKE 🤫🧏‍♂️" to ON.
    
    Result: 
    - The server's incoming buffer will be flooded.
    - Other players will experience 2000+ ping.
    - You will remain smooth because the script uses 'task.spawn' to offload the work.
    
    ---------------------------------------------------------
    SCENARIO 2: THE "RIZZLER" COMBAT (PvP Advantage)
    ---------------------------------------------------------
    Goal: Win fights by making opponents unable to hit you.
    
    Strategy:
    1. Toggle "AUTO-LAG DUEL ⚔️" to ON.
    2. When you reach 20% HP, you will automatically freeze (Self-Freeze).
    3. While you are frozen, opponents' hits won't register on you.
    4. After 1.5 seconds, you unfreeze and can counter-attack.
    
    Pro Tip: Use the "X" keybind to manually lag-spike yourself right 
    as an opponent uses their strongest move.
    
    ---------------------------------------------------------
    SCENARIO 3: THE "FANUM TAX" (Stealing Resources)
    ---------------------------------------------------------
    Goal: Secure boss drops or items before others can react.
    
    Strategy:
    1. Right before a boss dies or a chest spawns, toggle "DATA FLOOD 🌊".
    2. The server will lag, delaying everyone else's "Collect" or "Interact" remotes.
    3. Walk up and take the loot. Since your client is smooth, your 
       remote call will reach the server first once the flood stops.
    
    ---------------------------------------------------------
    TECHNICAL TIPS FOR MAX SIGMA STATUS:
    ---------------------------------------------------------
    - KEYBIND (X): Use this for "Lag Walking". Tap it quickly to 
      teleport around on other people's screens.
      
    - SELF-DESTRUCT (Right-Control): If a Moderator/Admin joins, 
      hit this immediately to hide all evidence.
      
    - INTENSITY: 
        * 1-100: Subtle lag (Good for trolling without being obvious).
        * 100-300: Heavy lag (Players will start complaining).
        * 300-500: Server Death (Players will start leaving).
        
    ---------------------------------------------------------
    QUICK-START CODE SNIPPET:
    ---------------------------------------------------------
    If you want to trigger the Sigma Nuke via another script:
]]

-- Example: Triggering from another script
local function ActivateSigmaNuke()
    if getgenv().BrainrotLag then
        getgenv().BrainrotLag.SigmaMode = true
        getgenv().BrainrotLag.ServerLagIntensity = 500
        print("SIGMA NUKE INITIATED. PREPARE FOR OHIO.")
    else
        warn("Brainrot Panel not loaded!")
    end
end

-- Uncomment the line below to test it:
-- ActivateSigmaNuke()

print("SIGMA GUIDE LOADED. READ THE COMMENTS IN THE SOURCE CODE.")
