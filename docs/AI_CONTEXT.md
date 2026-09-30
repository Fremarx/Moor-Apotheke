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
- ITEM-001 ist umgesetzt: Sumpfminze einmalig sammeln, Bestand im Inventar führen und im HUD anzeigen.
- LOOP-001 ist umgesetzt: E am Trockengestell wandelt eine frische Sumpfminze in getrocknete Minze um.
- LOOP-002 ist umgesetzt: Der Braukessel wandelt eine getrocknete Sumpfminze in Beruhigungstee um; Wasser steht dort unbegrenzt bereit.
- QUEST-001 und UX-001 sind abgeschlossen; Fenjas Kernauftrag führt vom Sammeln bis zur Abgabe.
- CONTENT-001a ist abgeschlossen: Schilfwurzel als eigenständiges Pickup mit Inventarbestand und HUD-Zähler.
- LOOP-003 ist abgeschlossen: Das Trockengestell verarbeitet Schilfwurzel und zählt die getrocknete Zutat separat.
- LOOP-004 ist abgeschlossen: Der Stärkende Aufguss nutzt beide getrockneten Zutaten und wird nach Fenjas Auftrag freigeschaltet.
- QUEST-002 ist abgeschlossen: Marten nimmt nach Fenjas Abschluss einen Stärkenden Aufguss an; die Quest-HUD führt zu den Zutaten und bleibt nach Abgabe abgeschlossen.
- CONTENT-001b ist abgeschlossen: Nachtmoos ist als seltenes, einmalig sammelbares Pickup am schattigen Torfsteg ergänzt und wird separat im HUD gezählt.
- LOOP-005 ist abgeschlossen: Das Trockengestell verarbeitet Nachtmoos nach Sumpfminze und Schilfwurzel; frischer und getrockneter Bestand haben getrennte HUD-Zähler.
- Nächster Backlogpunkt: LOOP-006 – Nachttrank aus getrockneter Schilfwurzel und Nachtmoos brauen.
- Erster Kernablauf: Sumpfminze → trocknen → Beruhigungstee → Fenja.
- Nach jedem Backlogpunkt eigener Commit und Push.

## Wissens- und Skillhinweise
- Lokale Projektdokumente dokumentieren getroffene Projektentscheidungen.
- Nutze offizielle Godot-4.7-Seiten statt Versionsmix.
- ECC git-workflow für Branch/Commit; architecture-decision-records für wesentliche Entscheidungen; documentation-lookup, sofern der Kontextdienst verfügbar ist. Godot wird derzeit über offizielle Dokumentationsseiten abgerufen.
- Codex imagegen für Bildentwürfe; finale Rastergrafiken visuell im Spiel prüfen.
- Kein Vektorspeicher oder projektspezifisches Skillpaket, solange Quellenliste und AGENTS.md übersichtlich bleiben.
