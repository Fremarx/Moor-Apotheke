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
- docs/RELEASE_CHECKLIST.md: Windows-Build und offene Release-Schritte
- docs/adr/: nummerierte Architekturentscheidungen

## Stand
- Eigenständiges öffentliches Repository Fremarx/Moor-Apotheke; Entwicklungsbranch codex/moor-apotheke.
- Godot 4.7.2 ist lokal installiert.
- CORE-001 und CORE-002 sind umgesetzt: Moor-Testkarte, Spielfigur, Kamera, Steuerung, Hindernisse und E-Interaktion.
- ITEM-001 und LOOP-001/002 sind umgesetzt: Sumpfminze sammeln, trocknen und zu Beruhigungstee verarbeiten.
- QUEST-001 und UX-001 sind abgeschlossen; Fenjas Kernauftrag führt vom Sammeln bis zur Abgabe.
- CONTENT-001a, LOOP-003/004 und QUEST-002 ergänzen Schilfwurzel, stärkenden Aufguss und Martens Auftrag.
- CONTENT-001b, LOOP-005/006 und QUEST-003 ergänzen Nachtmoos, Nachttrank und Lenes Auftrag.
- BOARD-001 und ECON-001 ergänzen das Auftragsbrett sowie Münzbelohnungen.
- SAVE-001 speichert und lädt Position, Inventar, Auftragsstatus und abgeerntete Pflanzen in user://.
- VIS-001 bis VIS-003 integrieren die warme Moor-Pixelart für Karte, Spieler, Stationen, Bewohner und Sammelpflanzen.
- REL-001 ist abgeschlossen: Windows Desktop x86_64 ist das erste Exportziel; Profil und Release-Checkliste sind versioniert, passende Vorlagen sind lokal installiert.
- PLAY-001 ist abgeschlossen: HUD-Kontrast wurde verbessert; Richtungsbewegung und Kollisionen sind automatisiert geprüft, die Hauptszene wurde bei 480 × 270 gerendert. Subjektives Gefühl echter Hardwareeingaben ist nicht bewertet.
- Nächster Backlogpunkt: INV-001 – ein Inventarfenster mit Taste I öffnen und schließen.
- Nach jedem Backlogpunkt eigener Commit und Push.

## Wissens- und Skillhinweise
- Lokale Projektdokumente dokumentieren getroffene Projektentscheidungen.
- Nutze offizielle Godot-4.7-Seiten statt Versionsmix.
- ECC git-workflow für Branch/Commit; architecture-decision-records für wesentliche Entscheidungen; documentation-lookup, sofern der Kontextdienst verfügbar ist. Godot wird derzeit über offizielle Dokumentationsseiten abgerufen.
- Codex imagegen für Bildentwürfe; finale Rastergrafiken visuell im Spiel prüfen.
- Kein Vektorspeicher oder projektspezifisches Skillpaket, solange Quellenliste und AGENTS.md übersichtlich bleiben.
