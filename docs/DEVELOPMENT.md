# Entwicklung

## Voraussetzungen
- Godot 4.7.2 Standard (GDScript), portable Anwendung unter C:\Desktop\Tools\Godot\4.7.2.
- Git ist bereits vorhanden.
- Für den Start sind keine weiteren Laufzeitwerkzeuge nötig.

## Projekt öffnen
Projektdatei: C:\Desktop\git\Moor-Apotheke\project.godot.

Godot-Editor starten:

~~~powershell
& 'C:\Desktop\Tools\Godot\4.7.2\Godot_v4.7.2-stable_win64.exe' --editor --path 'C:\Desktop\git\Moor-Apotheke'
~~~

Projekt headless laden (Editor-/Importprüfung):

~~~powershell
& 'C:\Desktop\Tools\Godot\4.7.2\Godot_v4.7.2-stable_win64.exe' --headless --editor --path 'C:\Desktop\git\Moor-Apotheke' --quit
~~~

Der headless Editor-Aufruf wurde beim Einrichten der Projektgrundlage erfolgreich ausgeführt. Er ersetzt keinen visuellen Spieltest.

## Repository und Arbeitseinheiten
- Lokaler Entwicklungsbranch: codex/moor-apotheke.
- Remote: das vom Nutzer freigegebene Remote aus 2DGame.
- main wird nicht direkt verändert.
- Ein Backlogpunkt enthält einen begrenzten Scope, passende Prüfungen und aktualisierte Dokumentation.
- Nach Abschluss: Diff und Status prüfen, genau einen passenden Conventional Commit erstellen und denselben Branch pushen.
- Keine Force-Pushes und keine Commits von .godot/, Export-Caches, privaten Einstellungen oder fremden Änderungen.

## Konventionen und Recherche
- Dateinamen/Verzeichnisse in snake_case; Godot-Knotennamen in PascalCase.
- .godot/ enthält regenerierte lokale Editor-/Importdaten und bleibt ignoriert.
- Add-ons nur bei dokumentiertem konkretem Bedarf.
- Projektdauerregeln stehen in AGENTS.md, Fortschritt in PROJECT_PLAN.md.
- Godot-Fragen zuerst anhand passender offizieller Version-4.7-Dokumentation aus docs/KNOWLEDGE_BASE.md klären.
- Bildentwürfe mit Codex imagegen; endgültige PNGs im Spielmaßstab prüfen.
