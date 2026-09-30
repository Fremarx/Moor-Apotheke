# Die Moor-Apotheke

Ein gemütliches 2D-Pixelart-Spiel über eine Apotheke am Rand eines geheimnisvollen Moors.

## Entwicklungsumgebung
- Godot 4.7.2 Standard mit GDScript
- Godot 4.7.2 Editor lokal installiert
- Projektdatei: project.godot
- GitHub-Repo: [Fremarx/Moor-Apotheke](https://github.com/Fremarx/Moor-Apotheke) (öffentlich)
- Entwicklungsbranch: codex/moor-apotheke

## Öffnen
Öffne Godot 4.7.2 und importiere die Datei `project.godot` aus dem geklonten Repository.

Der aktuelle Graybox-Prototyp startet in einer kleinen Moor-Testkarte. Die Figur bewegt sich mit **WASD** oder den **Pfeiltasten**; Grafik und Umgebung sind Platzhalter.

Headless-Projektprüfung im Repository-Ordner (Passe den Godot-Aufruf an deine Installation an):

~~~powershell
godot --headless --editor --path . --quit
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
