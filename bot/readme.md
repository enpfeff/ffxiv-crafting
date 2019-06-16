# Bot
## Install
1.  Get auto hot key
2.  set up configuration in `config.ahk`
3.  run command `/path/to/autohotkey.exe entry.ahk`
4.  Press Ctrl + F1 to start craft, Ctrl + F2 to stop the craft gracefully, Ctrl + Esc to Interrupt stop
5.  tail the log.log in this directory to see whats going on

## Dev
Been using visual studio code, with the auto hot key syntax highlighter and the run plugin as well as a log watcher
settings.json example
```
"code-runner.executorMap": { 
    "ahk": "\"C:\\Program Files\\AutoHotkey\\AutoHotkey.exe\"" 
},
"code-runner.executorMapByFileExtension": {
    ".ahk": "\"C:\\Program Files\\AutoHotkey\\AutoHotkey.exe\"" 
},
"files.autoSave": "afterDelay",
"logViewer.watch": [{
    "title": "Auto Hot Key",
    "pattern": "C:\\Users\\ianpf\\Documents\\code\\ffxiv-crafting\\bot\\*.log"
}]
```
