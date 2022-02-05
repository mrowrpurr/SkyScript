# SkyScript

## Special Folders:

```
Data\SkyScript\Startup\*.json
Data\SkyScript\RunOnce\*.json
```

## Event Folders

> _Like Dynamic Animation Replacer but for arbitrary simple actions_

```
Data\SkyScript\Player\ItemAdded\*.json
Data\SkyScript\Player\EnterSneak\*.json
Data\SkyScript\Player\LeaveSneak\*.json
Data\SkyScript\Player\EnterCombat\*.json
```

## TODO

- [ ] Change variable interpolation to use `${ }` instead of `<var:>`
- [ ] ItemAdded via file
- [ ] If it's a potion... then drink it
- [ ] If it's a potion... duplicate it
- [ ] Switch from "action" to "[unique key]" based matching
- [ ] Be able to print the name of the item that was added
- [ ] Variables
- [ ] Simplest of Conditionals
- [ ] Error Handling of some variety

- [ ] Item chooser (can specify one or multiple)
- [ ] Spell chooser (can specify one or multiple)
- [ ] Logging which can be set to INFO/DEBUG/ERROR/WARN separately for Console and Papyrus Logs
- [x] Scripts can run scripts by filename
- [x] Scripts can be paused and resumed
- [ ] Scripts resume after game crash/quit when running
- [x] MessageBox on game load
- [ ] Can run MCM recording actions (TODO)
- [ ] Prompt for option (arbitrary list)
- [ ] Prompt for confirmation (buttons)
- [x] Fade screen to black & back
- [ ] Give player items
- [ ] Do something on save game load
- [ ] Do something when RaceMenu closes
- [ ] Open RaceMenu
- [ ] Load RaceMenu preset
