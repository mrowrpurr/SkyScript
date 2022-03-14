# `SkyScript`

> 🐉 SKSE Skyrim Plugin
>
> 👩‍💻 _Work in Progress_
>
> 🎓 _C++ learning project!_

# 📂 Project Layout

| | |
|-|-|
| `parser`       | Read YAML and JSON files into `SkyScript::ScriptNode` wrappers of std:: library types (_unordered_map, vector, and simple types_) |
| `interpreter`  | Evaluate `SkyScript::ScriptNode` parsed from YAML or JSON files (_includes both type definitions and procedural code_) |
| `api`          | Dynamically link from other .dlls to extend the `SkyScript` scripting language with native functions |
| `stdlib`       | Standard library of provided types and functions (_agnostic to runtime environment_) |
| `skyrim`       | Standard library of provided types and functions (_specifically created for Skyrim_) |
| `skse`         | Skyrim SKSE plugin runtime |
| `papyrus`      | Papyrus scripts for running SkyScripts as well as expending the language with Papyrus functions |
| `runner`       | Run .yaml and .json scripts on the Desktop for testing outside of Skyrim |
