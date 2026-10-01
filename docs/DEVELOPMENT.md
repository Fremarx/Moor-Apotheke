# Entwicklung

## Voraussetzungen
- Godot 4.7.2 Standard (GDScript), lokal installiert.
- Git ist bereits vorhanden.
- Für den Start sind keine weiteren Laufzeitwerkzeuge nötig.

## Projekt öffnen
Projektdatei: project.godot im Repository-Stammverzeichnis.

Godot-Editor starten:

~~~powershell
godot --editor --path .
~~~

Projekt headless laden (Editor-/Importprüfung):

~~~powershell
godot --headless --editor --path . --quit
~~~

Der headless Editor-Aufruf wurde beim Einrichten der Projektgrundlage erfolgreich ausgeführt. Er ersetzt keinen visuellen Spieltest.

## Windows-Export (x86_64)
Das Exportprofil Windows Desktop ist in export_presets.cfg versioniert und erzeugt build/windows/Moor-Apotheke.exe. Installiere in Godot 4.7.2 die passenden Windows-Exportvorlagen; Editor und Vorlagen müssen dieselbe Godot-Version verwenden. Die Vorlagen werden je Rechner lokal installiert und nicht ins Repository gelegt.

~~~powershell
godot --headless --path . --export-release "Windows Desktop" "build/windows/Moor-Apotheke.exe"
~~~

Smoke-Start des erzeugten Programms:

~~~powershell
build/windows/Moor-Apotheke.exe --headless --quit-after 60
~~~

build/ und Godots lokale Export-Credentials bleiben ignoriert. Das versionierte Exportprofil enthält keine Zugangsdaten. Godot speichert Export-Credentials lokal unter .godot/export_credentials.cfg; diese Datei niemals committen. Siehe [Release-Checkliste](RELEASE_CHECKLIST.md).

## Repository und Arbeitseinheiten
- Lokaler Entwicklungsbranch: codex/moor-apotheke.
- GitHub-Remote origin: https://github.com/Fremarx/Moor-Apotheke.git.
- Das Repository ist öffentlich unter https://github.com/Fremarx/Moor-Apotheke erreichbar.
- Ein Backlogpunkt enthält einen begrenzten Scope, passende Prüfungen und aktualisierte Dokumentation.
- Nach Abschluss: Diff und Status prüfen, genau einen passenden Conventional Commit erstellen und denselben Branch pushen.
- Keine Force-Pushes und keine Commits von .godot/, Export-Caches, privaten Einstellungen oder fremden Änderungen.

## Konventionen und Recherche
- Dateinamen/Verzeichnisse in snake_case; Godot-Knotennamen in PascalCase.
- .godot/ enthält regenerierte lokale Editor-/Importdaten und bleibt ignoriert.
- Add-ons nur bei dokumentiertem konkretem Bedarf.
- Projektdauerregeln stehen in AGENTS.md, Fortschritt in PROJECT_PLAN.md.
- Godot-Fragen zuerst anhand passender offizieller Version-4.7-Dokumentation aus docs/KNOWLEDGE_BASE.md klären.
- Bildentwürfe mit Codex imagegen; finale Rastergrafiken visuell im Spiel prüfen.
