import XMonad
import XMonad.Actions.WindowGo
import XMonad.Hooks.DynamicLog hiding (shorten)
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import XMonad.Layout.IM
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.LayoutHints
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.Reflect
import XMonad.Util.Run (spawnPipe)
import Data.Ratio
import Data.List (isPrefixOf)
import System.IO
import System.Exit
 
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

xmobarStrip :: String -> String
xmobarStrip = strip [] where
    strip keep x
      | null x                 = keep
      | "<fc="  `isPrefixOf` x = strip keep (drop 1 . dropWhile (/= '>') $ x)
      | "</fc>" `isPrefixOf` x = strip keep (drop 5  x)
      | '<' == head x          = strip (keep ++ "<") (tail x)
      | otherwise              = let (good,x') = span (/= '<') x
                                 in strip (keep ++ good) x'
main = do
       xmobar <- spawnPipe "xmobar"  -- spawns xmobar and returns a handle
       xmonad $ withUrgencyHook NoUrgencyHook defaultConfig { terminal = "urxvt"
                                                            , workspaces = ["1: music", "2: web", "3: chat", "4: misc", "5: code", "6: gimp", "7", "8", "9", "10"]
                                                            , normalBorderColor = "#303030"
                                                            , focusedBorderColor = "#66CCFF"
                                                            , modMask = mod4Mask
                                                            , keys = keyBindings
                                                            , logHook = dynamicLogWithPP $ xmobarPP { ppOutput = hPutStrLn xmobar
                                                                                                    , ppUrgent = xmobarColor "#E5E554" "#AB0000" . xmobarStrip
                                                                                                    , ppTitle = xmobarColor "#66CCFF" "" . xmobarStrip
                                                                                                    , ppCurrent = xmobarColor "#B1F36F" "" . xmobarStrip
                                                                                                    , ppVisible = xmobarColor "#FFFF8B" "" . xmobarStrip
                                                                                                    , ppLayout = const ""
                                                                                                    , ppSep = " | "
                                                                                                    }
                                                            , layoutHook = smartBorders . avoidStruts . layoutHints $
                                                                           onWorkspace "1: music" (Mirror (Tall 1 (3/100) (67/100))) $
                                                                           onWorkspace "2: web" (Mirror (Tall 1 (3/100) (80/100)))  $
                                                                           onWorkspace "3: chat" (Mirror (Tall 1 (3/100) (51/100))) $
                                                                           onWorkspace "5: code" (Mirror (Tall 1 (3/100) (90/100))) $
                                                                           onWorkspace "6: gimp" (withIM (0.11) (Role "gimp-toolbox") $ reflectHoriz $ withIM (0.15) (Role "gimp-dock") Full) $
                                                                           layoutHook defaultConfig
                                                            , manageHook = myManageHook <+> manageDocks
                                                            }

myManageHook = composeAll . concat $ [ [className =? c --> doFloat | c <- myFloats]
                                     , [title =? t --> doFloat | t <- myTitleFloats]
                                     , [resource =? r --> doIgnore | r <- myIgnores]
                                     , [className =? "Minefield" --> doShift "2: web"]
                                     , [className =? "Photoshop.exe" --> doShift "4: misc"]
                                     ]
               where
                   myFloats = ["MPlayer"]
                   myTitleFloats = ["Downloads", "Save As...", "File Upload", "Getting directory listings", "Transfer Files"]
                   myIgnores = []

keyBindings conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
 
    -- launch a terminal
    [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
 
    -- launch dmenu
    , ((modMask, xK_p), spawn "exe=`dmenu_path | yeganesh -- -fn \"-*-profont-*-*-*-*-11-*-*-*-*-*-*-*\" -nb \"#151515\" -nf \"#e6e6e6\" -sb \"#66CCFF\" -sf \"#303030\" -p \"Run:\"` && eval \"exec $exe\"")

    -- focus urgent window
    , ((modMask, xK_u), focusUrgent)
 
    -- close focused window 
    , ((modMask, xK_x), kill)
 
     -- Rotate through the available layout algorithms
    , ((modMask, xK_space), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    , ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    , ((modMask, xK_n), refresh)
 
    -- Move focus to the next window
    , ((modMask, xK_Tab), windows W.focusDown)
 
    -- Move focus to the next window
    , ((modMask, xK_j), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modMask, xK_k), windows W.focusUp  )
 
    -- Move focus to the master window
    , ((modMask, xK_m), windows W.focusMaster  )
 
    -- Swap the focused window and the master window
    , ((modMask, xK_Return), windows W.swapMaster)
 
    -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_j), windows W.swapDown  )
 
    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_k), windows W.swapUp    )
 
    -- Shrink the master area
    , ((modMask, xK_h), sendMessage Shrink)
 
    -- Expand the master area
    , ((modMask, xK_l), sendMessage Expand)
 
    -- Push window back into tiling
    , ((modMask, xK_t), withFocused $ windows . W.sink)
 
    -- Increment the number of windows in the master area
    , ((modMask, xK_comma), sendMessage (IncMasterN 1))
 
    -- Deincrement the number of windows in the master area
    , ((modMask, xK_period), sendMessage (IncMasterN (-1)))
 
    -- Quit xmonad
    , ((modMask .|. shiftMask, xK_q), io (exitWith ExitSuccess))
 
    -- Restart xmonad
    , ((modMask, xK_q),
          broadcastMessage ReleaseResources >> restart "xmonad" True)
    ]
    ++
 
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
 
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
