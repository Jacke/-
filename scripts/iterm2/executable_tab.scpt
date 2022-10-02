tell application "iTerm2"
  tell current window
  set newWindow to (create tab with default profile)
    tell current session of newWindow
        write text "cd ~/Dev/"
    end tell
  end tell
end tell
