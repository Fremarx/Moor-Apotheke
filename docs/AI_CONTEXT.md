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
- Eigenständiges Repository `Fremarx/Moor-Apotheke`, öffentlich auf GitHub; Entwicklungsbranch `codex/moor-apotheke`.
- Godot 4.7.2 ist lokal installiert.
- CORE-001 ist umgesetzt: Graybox-Moorfläche, Platzhalterfigur, Kamera, WASD-/Pfeiltastensteuerung und einfache Hindernisse.
- CORE-002 ist umgesetzt: E-Interaktion mit Reichweitenprüfung, Auswahl des nächsten Ziels, kontextuellem HUD-Hinweis und grauer Kräuterprobe.
- Nächster Backlogpunkt: ITEM-001 – Sumpfminze aufnehmen und Inventarbestand anzeigen.
- Erster Kernablauf: Sumpfminze → trocknen → Beruhigungstee → Fenja.
- Nach jedem Backlogpunkt eigener Commit und Push.

## Wissens- und Skillhinweise
- Lokale Projektdokumente dokumentieren getroffene Projektentscheidungen.
- Nutze offizielle Godot-4.7-Seiten statt Versionsmix.
- ECC git-workflow für Branch/Commit; architecture-decision-records für wesentliche Entscheidungen; documentation-lookup, sofern der Kontextdienst verfügbar ist. Godot wird derzeit über offizielle Dokumentationsseiten abgerufen.
- Codex imagegen für Bildentwürfe; finale Rastergrafiken visuell im Spiel prüfen.
- Kein Vektorspeicher oder projektspezifisches Skillpaket, solange Quellenliste und AGENTS.md übersichtlich bleiben.
