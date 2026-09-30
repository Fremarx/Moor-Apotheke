# Die Moor-Apotheke

Ein gemütliches 2D-Pixelart-Spiel über eine Apotheke am Rand eines geheimnisvollen Moors.

## Entwicklungsumgebung
- Godot 4.7.2 Standard mit GDScript
- Godot-Editor separat unter C:\Desktop\Tools\Godot\4.7.2
- Projektdatei: project.godot
- Git-Branch: codex/moor-apotheke auf dem vom Nutzer freigegebenen Remote

## Öffnen
Starte Godot_v4.7.2-stable_win64.exe und importiere C:\Desktop\git\Moor-Apotheke\project.godot.

Der aktuelle Graybox-Prototyp startet in einer kleinen Moor-Testkarte. Die Figur bewegt sich mit **WASD** oder den **Pfeiltasten**; Grafik und Umgebung sind Platzhalter.

Headless-Projektprüfung in PowerShell:

~~~powershell
& 'C:\Desktop\Tools\Godot\4.7.2\Godot_v4.7.2-stable_win64.exe' --headless --editor --path 'C:\Desktop\git\Moor-Apotheke' --quit
~~~

## Projektunterlagen
- Spielidee und Grafik: GAME_PLAN.md
- Status und Backlog: PROJECT_PLAN.md
- Arbeitsregeln: AGENTS.md
- Architektur: docs/ARCHITECTURE.md
- Entwicklung: docs/DEVELOPMENT.md
- Tests: docs/TESTING.md
- Godot-Wissensquellen: docs/KNOWLEDGE_BASE.md
- KI-Kontext: docs/AI_CONTEXT.md
- Architekturentscheidungen: docs/adr/

## Startumfang
Zuerst entsteht eine komplette Schleife: Sumpfminze sammeln, trocknen, Beruhigungstee brauen und Fenja helfen. Weitere Pflanzen, Rezepte und Bewohner kommen nach einem ersten Spieltest.
