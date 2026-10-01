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
- design/: maßgeblicher neuer Weltentwurf, Gebietsmaßstab, Ressourcen-, Gegner- und Fortschrittsplanung

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
- VIS-001 bis VIS-004 integrieren die warme Moor-Pixelart für Karte, Spieler, Stationen, Bewohner, Sammelpflanzen, Apotheke und Moorvegetation.
- REL-001 ist abgeschlossen: Windows Desktop x86_64 ist das erste Exportziel; Profil und Release-Checkliste sind versioniert, passende Vorlagen sind lokal installiert.
- PLAY-001 ist abgeschlossen: HUD-Kontrast wurde verbessert; Richtungsbewegung und Kollisionen sind automatisiert geprüft, die Hauptszene wurde bei 480 × 270 gerendert. Subjektives Gefühl echter Hardwareeingaben ist nicht bewertet.
- INV-001 ist abgeschlossen: Das Inventarfenster zeigt zehn Bestände in Kategorien; I und Escape schließen es, während das Spiel pausiert. Detaillierte Bestände sind aus dem permanenten HUD entfernt.
- PLAYTEST-001 zeigte die Ressourcenknappheit; RESOURCE-001 ist abgeschlossen: Fenja, Marten und Lene lassen sich frisch nacheinander erfüllen und bringen zusammen 30 Münzen.
- AREA-001 ist abgeschlossen: Schilfufer ist über Hin- und Rückweg erreichbar und ergänzt je eine Sumpfminz-, Schilfwurzel- und Nachtmoosstelle.
- MAP-01 ist abgeschlossen: Der bestehende TestMap-Knoten stellt logisch den Dorfplatz dar; Apotheke, Brett und Brunnen sind sichtbar. MAP-02 ergänzt fünf Richtungswege mit offenem NW-Übergang zum Schilfufer sowie vier sichtbar und physisch gesperrten Zukunftswegen. MAP-03 und VIS-005 stellen einen gemeinsamen 16×16-Terrainatlas mit abgestimmten Grundvarianten in allen drei Gebieten bereit. Alle 29 Headless-Tests, Editorimport und 60-Frame-Start bestehen.
- VIS-004 ersetzt das flach gezeichnete Apothekenmotiv und ergänzt passende größere Schilf- und Moosgruppen in beiden Startkarten; die Wege und Kollisionsflächen blieben unverändert.
- Maßgebliche Entwurfsquellen: `design/world_design_plan.md`, `design/world_backlog.md`, `design/progression_roadmap.md`, `design/resource_economy.md`, `design/enemy_roster.md`, `design/agent_workflow.md` und `design/world_map_mockup.png`.
- SCALE-01 ist abgeschlossen: `design/world_backlog.md` enthält für alle fünf Gebiete ein 5×4-Raster, den verbindlichen 4×3-Mindestkern und konkrete Routen, Fundstellen, Landmarken, optionale Begegnungen und Geheimnisse. REG-01 und REG-02 sind mit je 150×68 Kacheln technisch umgesetzt; die blinden Erstbesuche bleiben vor Veröffentlichung offen. SYS-01 ist abgeschlossen: 18 Fundstellen haben feste Gebiets-, Ressourcen- und Ortsdaten; Rückkehr ins Dorf erneuert Pflanzen und optionale Gegner. Taste H öffnet das Basis-Kräuterbuch. Entdeckungen überleben Ernten, Speichern und Laden; alte Version-1-Spielstände bleiben gültig. Nächster Backlogpunkt ist SYS-02, sichere Begegnungen mit Gegnern.
- Nach jedem Backlogpunkt eigener Commit und Push.

## Wissens- und Skillhinweise
- Lokale Projektdokumente dokumentieren getroffene Projektentscheidungen.
- Nutze offizielle Godot-4.7-Seiten statt Versionsmix.
- ECC git-workflow für Branch/Commit; architecture-decision-records für wesentliche Entscheidungen; documentation-lookup, sofern der Kontextdienst verfügbar ist. Godot wird derzeit über offizielle Dokumentationsseiten abgerufen.
- Codex imagegen für Bildentwürfe; finale Rastergrafiken visuell im Spiel prüfen.
- Kein Vektorspeicher oder projektspezifisches Skillpaket, solange Quellenliste und AGENTS.md übersichtlich bleiben.
