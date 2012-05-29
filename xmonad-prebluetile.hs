import XMonad
import XMonad.Config.Gnome
import XMonad.Config.Bluetile
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Replace
import System.IO

myManageHook = composeAll . concat $
    [ [ className =? "Unity-2d-panel" --> doIgnore ]
    , [ resource =? "Do" --> doIgnore ]
    ]

myLayouts = gaps [(U, 24)] $ layoutHook gnomeConfig

main = do
		replace >> xmonad bluetileConfig
    xmonad $ gnomeConfig
        {
            manageHook = myManageHook <+> manageHook gnomeConfig
				,   startupHook = setWMName "LG3D"
        ,   layoutHook = avoidStruts $ smartBorders $ layoutHook defaultConfig
        ,   focusFollowsMouse = False
        ,   modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        [   ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        ,   ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        ,   ((0, xK_Print), spawn "scrot")
        ,   ((mod4Mask, xK_b ), sendMessage ToggleStruts)
        ,   ((mod4Mask, xK_p ), spawn "gnome-do")
        ]
