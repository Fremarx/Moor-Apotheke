# Die Moor-Apotheke

Ein gemütliches 2D-Top-down-Pixelartspiel über eine Apotheke am Rand eines geheimnisvollen Moors. Der spielbare Ausschnitt verbindet Kräutersammeln, Verarbeitung, Aufträge und einen persistenten Spielstand.

## Entwicklungsumgebung

- Godot 4.7.2 Standard mit GDScript
- Projektdatei: project.godot
- Öffentliches GitHub-Repository: [Fremarx/Moor-Apotheke](https://github.com/Fremarx/Moor-Apotheke)
- Entwicklungsbranch: codex/moor-apotheke

## Projekt öffnen und starten

Öffne Godot 4.7.2 und importiere project.godot aus dem geklonten Repository. Die Spielfigur bewegt sich mit **WASD** oder den **Pfeiltasten**. Mit **E** interagierst du, **F5** speichert und **F9** lädt den Spielstand.

Projekt im Godot-Editor headless laden:

~~~powershell
godot --headless --editor --path . --quit
~~~

## Windows-Testbuild exportieren

Das versionierte Exportprofil erstellt einen Windows-Desktop-Build für x86_64. Installiere die Exportvorlagen, die exakt zu Godot 4.7.2 passen, einmalig in deiner lokalen Godot-Installation. Exportprofile liegen im Repository; private Export-Zugangsdaten bleiben lokal.

~~~powershell
godot --headless --path . --export-release "Windows Desktop" "build/windows/Moor-Apotheke.exe"
~~~

Die Datei wird unter build/windows/ erzeugt; dieser Ordner ist von Git ausgeschlossen. Voraussetzungen, Prüfungen und offene Release-Entscheidungen stehen in [docs/RELEASE_CHECKLIST.md](docs/RELEASE_CHECKLIST.md).

## Spielinhalt

- Sumpfminze, Schilfwurzel und Nachtmoos sammeln und trocknen.
- Beruhigungstee, stärkenden Aufguss und Nachttrank brauen.
- Drei Bewohneraufträge annehmen, erfüllen und Münzen verdienen.
- Position, Inventar, Auftragsstatus und gesammelte Pflanzen speichern und laden.

## Projektunterlagen

- Spielidee und Grafik: [GAME_PLAN.md](GAME_PLAN.md)
- Status und Backlog: [PROJECT_PLAN.md](PROJECT_PLAN.md)
- Arbeitsregeln: [AGENTS.md](AGENTS.md)
- Architektur: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)
- Entwicklung: [docs/DEVELOPMENT.md](docs/DEVELOPMENT.md)
- Tests: [docs/TESTING.md](docs/TESTING.md)
- Release-Checkliste: [docs/RELEASE_CHECKLIST.md](docs/RELEASE_CHECKLIST.md)
- Godot-Wissensquellen: [docs/KNOWLEDGE_BASE.md](docs/KNOWLEDGE_BASE.md)
- KI-Kontext: [docs/AI_CONTEXT.md](docs/AI_CONTEXT.md)
- Architekturentscheidungen: [docs/adr/](docs/adr/)
