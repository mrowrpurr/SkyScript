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

- [ ] Switch Action Handlers to use Syntax

- [x] Simplest of Conditionals
- [ ] Error Handling of some variety

- [x] Player/ItemAdded via file
- [ ] Player/ItemEquip via file
- [ ] Player/BeginSneak via file
- [ ] Player/EndSneak via file
- [ ] ModEvent
- [ ] MenuOpen via file

- [ ] Can run script by file name
- [ ] Play animation on Player
- [ ] If it's a potion... then drink it
- [ ] If it's a potion... duplicate it

- [ ] MCM Actions (recorder)

- [ ] Handle events on certain NPCs!

- [ ] Switch from "action" to "[unique key]" based matching
- [x] Change variable interpolation to use `${ }` instead of `<var:>`
- [x] Be able to print the name of the item that was added
- [x] Variables

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
