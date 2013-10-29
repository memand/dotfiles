import XMonad

import System.IO

import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders  
import XMonad.Layout.PerWorkspace

import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog  
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops

import Graphics.X11.ExtraTypes.XF86 

import XMonad.Util.Run
import XMonad.Util.EZConfig  

defaultLayouts = tiled ||| Mirror tiled ||| Full
    where
        -- default tiling algorithm partitions the screen into two panes  
        tiled = spacing 4 $ Tall nmaster delta ratio  

        -- The default number of windows in the master pane  
        nmaster = 1  

        -- Default proportion of screen occupied by master pane  
        ratio = 5/8  

        -- Percent of screen to increment by when resizing panes  
        delta = 5/100

-- Define layout for specific workspaces
nobordersLayout = noBorders $ Full

-- Put all layouts together 
myLayout = onWorkspace "4:fullscreen" nobordersLayout $ defaultLayouts

-- Terminal
myTerminal = "terminator"

-- Mod key (mod1Mask == Alt | mod4Mask == Super
myModMask = mod4Mask

-- Workspaces
myWorkspaces = ["1:chat","2:web","3:work","4:fullscreen","5","6","7","8","9:rt"]

-- Send programs to workspaces
myManageHook = composeAll
    [ className =? "weechat"  --> doShift "1:chat"
    , className =? "rtorrent" --> doShift "9:rt"
    , className =? "Gimp"     --> doFloat
    ]
  
main = do  
    xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobar.hs"
    xmonad $ defaultConfig
        { manageHook = myManageHook <+> manageDocks <+> manageHook defaultConfig 
        , layoutHook = avoidStruts $ myLayout ||| layoutHook defaultConfig
        , terminal           = myTerminal
        , borderWidth        = 1
        , normalBorderColor  = "black"
        , modMask            = myModMask
        , focusedBorderColor = "gray"
        , focusFollowsMouse  = False
        , workspaces         = myWorkspaces
        , logHook            = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle  = xmobarColor "green" "" . shorten 50
            }
            >> ewmhDesktopsLogHook
            >> setWMName "LG3D"
        }`additionalKeys`
        [ ((myModMask .|. shiftMask, xK_c), return ())                                           -- return() means to do nothing
        , ((myModMask .|. shiftMask, xK_F4), spawn "sudo shutdown -h now")                       -- window key + Shift + F4 to shutdown system
        , ((myModMask .|. shiftMask , xK_z), spawn "xscreensaver-command -lock")                 -- lock screen, with screensaver
        , ((myModMask, xK_p), spawn "dmenu_run -i -l 10 -nb black -nf gray -sb black -sf green") -- dmenu, now with colors ;)
        , ((mod1Mask, xK_F4), kill)                                                              -- to kill applications
        , ((myModMask, xK_f), sendMessage ToggleStruts)                                          -- toggle xmobar on current workspace
        , ((myModMask, xK_w), spawn "feh --bg-scale ~/walls/$(ls ~/walls/ | shuf -n1)")          -- Change the wallpaper
        -- XF86AudioLowerVolume
        , ((0, 0x1008FF11), spawn "amixer set Master 2%-")                                       -- volume down
        -- XF86AudioRaiseVolume
        , ((0, 0x1008FF13), spawn "amixer set Master 2%+")                                       -- volume up
        -- XF86AudioMute
        , ((0, 0x1008FF12), spawn "amixer set Master toggle")                                    -- volume toggle
        ]
