import XMonad
import XMonad.Config.Bluetile
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Gaps
import XMonad.Util.Replace
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)

myManageHook = composeAll . concat $
    [ [ className =? "Unity-2d-panel" --> doIgnore ]
    , [ resource =? "Do" --> doIgnore ]
	]

myLayouts = gaps [(U, 24)] $ layoutHook bluetileConfig

main = do
    xmonad $ bluetileConfig
        {
            manageHook = myManageHook <+> manageHook bluetileConfig
        ,   layoutHook = avoidStruts $ layoutHook bluetileConfig
        } `additionalKeys`
        [   ((mod4Mask, xK_b ), sendMessage ToggleStruts)
        ,   ((mod4Mask, xK_p ), spawn "gnome-do")
        ]

