# KI-Kontext

## Projekt
Die Moor-Apotheke: ruhiges 2D-Top-down-Pixelartspiel in Godot 4.7.2 Standard mit GDScript.

## Maßgebliche Projektdateien
- AGENTS.md: Arbeitsregeln
- PROJECT_PLAN.md: Status, Backlog und Definition of Done
- GAME_PLAN.md: Spielidee und Grafikrichtung
- docs/ARCHITECTURE.md: derzeitige Architekturannahmen
- docs/KNOWLEDGE_BASE.md: versionierte offizielle Godot-Quellen
- docs/TESTING.md: Prüfstrategie
- docs/adr/: nummerierte Architekturentscheidungen

## Stand
- Eigenständiges Repository unter C:\\Desktop\\git\\Moor-Apotheke.
- Remote ist das vom Nutzer freigegebene 2DGame-Remote; Branch codex/moor-apotheke, main bleibt unangetastet.
- Godot liegt separat unter C:\\Desktop\\Tools\\Godot\\4.7.2.
- Die leere scenes/main.tscn existiert; keine Gameplayskripte oder finalen Assets.
- Aktiver Backlogpunkt: CORE-001 – Graybox-Testkarte, Platzhalterfigur und Bewegung.
- Erster Kernablauf: Sumpfminze → trocknen → Beruhigungstee → Fenja.
- Nach jedem Backlogpunkt eigener Commit und Push.

## Wissens- und Skillhinweise
- Lokale Projektdokumente dokumentieren getroffene Projektentscheidungen.
- Nutze offizielle Godot-4.7-Seiten statt Versionsmix.
- ECC git-workflow für Branch/Commit; architecture-decision-records für wesentliche Entscheidungen; documentation-lookup, sofern der Kontextdienst verfügbar ist. Godot wird derzeit über offizielle Dokumentationsseiten abgerufen.
- Codex imagegen für Bildentwürfe; finale Rastergrafiken visuell im Spiel prüfen.
- Kein Vektorspeicher oder projektspezifisches Skillpaket, solange Quellenliste und AGENTS.md übersichtlich bleiben.
