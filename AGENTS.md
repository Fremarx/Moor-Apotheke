# Projektregeln für KI-gestützte Arbeit

- Lies vor einem neuen Backlogpunkt PROJECT_PLAN.md, GAME_PLAN.md und bei Bedarf docs/AI_CONTEXT.md.
- Ändere pro Arbeitseinheit nur den Scope eines Backlogpunkts.
- Nutze Godot 4.7.2 Standard mit GDScript. Für versionsabhängiges Verhalten verwende offizielle Dokumentation unter /en/4.7/.
- Halte Szenen eigenständig und lose gekoppelt; nutze Signale, wenn ein Kind an den Elternkontext melden muss.
- Verwende snake_case für Dateinamen und PascalCase für Godot-Knotennamen.
- Halte .godot/ und andere Import-/Build-Caches aus Git heraus.
- Ziehe keine Add-ons oder neuen Laufzeitabhängigkeiten ein, solange kein konkreter Bedarf dokumentiert ist.
- Prüfe Pixelgrafiken im Spielmaßstab; dokumentiere Quelle und Lizenz für endgültige Assets.
- Rufe vor Implementierung passende offizielle Godot-Dokumentation über docs/KNOWLEDGE_BASE.md ab. Kopiere keine vollständigen Handbuchseiten ins Repository.
- Aktualisiere PROJECT_PLAN.md, Tests und betroffene Dokumentation im selben Backlogpunkt.
- Prüfe den Diff, führe vorgesehene Prüfungen aus und dokumentiere nicht ausgeführte Prüfungen ehrlich.
- Nach jedem abgeschlossenen Backlogpunkt genau einen passenden Commit erstellen und auf origin pushen. Verwende codex/moor-apotheke; pushe nicht nach main, nutze kein Force-Push und stage keine sachfremden Änderungen.
- Schreibe kurze, beschreibende Commit-Nachrichten im Conventional-Commit-Stil.
