@echo off

set argCount=0
for %%x in (%*) do set /A argCount+=1

if "%argCount%" == "1" (
    .\build\Debug\spec\parser\Debug\spec-parser.exe --only="%1%"
) else (
    .\build\Debug\spec\parser\Debug\spec-parser.exe %*
)
