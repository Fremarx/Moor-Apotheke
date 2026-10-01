# Teststrategie

## Aktueller Stand
Es gibt noch kein Testframework. Godot 4.7.2 hat nach CORE-001 die Graybox-Startszene im Headless-Editor importiert und 60 Laufzeitframes ohne Fehler ausgeführt. Ein sichtbarer Godot-Fenstertest mit echter Tastatur steht noch aus.

Die 27 `SceneTree`-Testskripte überschreiben `_process()` mit `return false`, damit Godot beim Start per `--script` die verzögerten und asynchronen Prüfschritte tatsächlich ausführt. Ohne diesen MainLoop-Hook endete der Prozess nach dem Laden des Skripts, bevor die Tests liefen.

## Pro Backlogpunkt
1. Godot-Editor-/Parserfehlerstand prüfen.
2. Eigenständige Regeln wie Inventar, Rezeptverbrauch und Auftragsstatus automatisiert prüfen, sobald die Logik diese Trennung rechtfertigt.
3. Bewegung, Kollision, Kamera, Pixelbild und Eingaben kurz im Godot-Fenster prüfen.
4. DoD-Ergebnisse festhalten und ausgelassene Prüfungen begründen.

## Manuelle Abnahme der ersten Schleife
- Steuerung mit WASD und Pfeiltasten prüfen.
- Kollisionen an Kartengrenzen und Hindernissen prüfen.
- Reichweite und Eingabe jeder Interaktion prüfen.
- Bestand, Zutatenverbrauch, Rezeptresultat und Abgabe beobachten.
- Fenjas Auftrag von Annahme bis Abschlussmeldung ohne Neustart der Anwendung durchspielen.

## CORE-001 – Graybox, Spieler und Kamera
- Erledigt: Headless-Editorimport der Startszene mit Godot 4.7.2.
- Erledigt: 60-Frame-Laufzeit-Smoke-Check ohne Parser- oder Laufzeitfehler.
- Erledigt: Kurzlebiger Headless-Eingabecheck bestätigt aktive Kamera, Bewegung in alle vier Richtungen sowie Kollision an einem Hindernis und der Westgrenze.
- Noch offen: Bewegung mit echter Tastatureingabe, Kameraeindruck und Kollisionen im sichtbaren Godot-Fenster prüfen.

## CORE-002 – Interaktionsbereich und E-Taste
- Erledigt: tests/core_002_interaction_test.gd prüft die benannte E-Aktion, den Hinweis innerhalb der Reichweite, die Auswahl des nächsten Ziels, das sichtbare HUD-Feedback samt Timer, dessen Fortbestand beim Zielwechsel, das Ausblenden nach Timerablauf und außerhalb der Reichweite sowie die erhaltene Bewegung.
- Prüfbefehl: godot --headless --path . --script tests/core_002_interaction_test.gd
- Erledigt: Godot-4.7.2-Headless-Editorimport und 60-Frame-Startszene ohne Parser- oder Laufzeitfehler.
- Offen: Sichtprüfung von Hinweis, Rückmeldung, Bewegung und Kamera im Godot-Fenster.

## ITEM-001 – Sumpfminze sammeln und Inventar
- Erledigt: tests/item_001_collection_test.gd prüft Startbestand 0, kein Sammeln außerhalb der Reichweite, Hinweis/Aktion in Reichweite, Aufnahme, HUD-Zähler und Rückmeldung, Verschwinden der Pflanze, Schutz vor doppelter Aufnahme sowie ungültige Inventaränderungen.
- Prüfbefehl: godot --headless --path . --script res://tests/item_001_collection_test.gd
- RED: Der erste Lauf zeigte erwartungsgemäß die fehlenden Sumpfminze-, Inventar- und HUD-Zähler-Knoten.
- GREEN: derselbe ITEM-001-Test und der CORE-002-Regressionslauf bestanden nach der Implementierung.
- Erledigt: ITEM-001- und CORE-002-Headless-Tests, Godot-4.7.2-Headless-Editorimport und 60-Frame-Startszene ohne Parser- oder Laufzeitfehler.
- Offen: Sichtprüfung der Pflanzendarstellung und Inventaranzeige im Godot-Fenster.

## LOOP-001 – Sumpfminze am Trockengestell verarbeiten
- Erledigt: `tests/loop_001_drying_rack_test.gd` prüft leeren Startbestand, verständliche Fehlermeldung ohne frische Minze, Aufnahme der Zutat, zwei 1:1-Verarbeitungsschritte, beide HUD-Zähler und erneute Ablehnung ohne Vorrat.
- Prüfbefehl: `godot --headless --path . --script res://tests/loop_001_drying_rack_test.gd`
- RED: Vor der Umsetzung fehlten das Trockengestell und der Zähler für getrocknete Minze; der neue Test schlug an diesen erwarteten Stellen fehl.
- GREEN: LOOP-001-Test sowie ITEM-001- und CORE-002-Regressionstests bestanden.
- Erledigt: Godot-4.7.2-Headless-Editorimport und 60-Frame-Startlauf ohne Parser- oder Laufzeitfehler.
- Offen: Sichtprüfung von Station, Interaktionshinweis und beiden Inventarzählern im Godot-Fenster.

## LOOP-002 – Beruhigungstee brauen
- Erledigt: `tests/loop_002_brewing_test.gd` prüft den Ablauf Sumpfminze sammeln → trocknen → brauen, den Rezept-Hinweis, den Verbrauch genau einer getrockneten Minze, den Tee-Zähler sowie den Versuch ohne Zutat.
- Prüfbefehl: `godot --headless --path . --script res://tests/loop_002_brewing_test.gd`
- RED: Vor der Umsetzung fehlten Braukessel und Beruhigungstee-Zähler; der neue Test schlug erwartungsgemäß an diesen beiden Prüfungen fehl.
- GREEN: LOOP-002-Test sowie LOOP-001-, ITEM-001- und CORE-002-Regressionstests bestanden.
- Erledigt: Godot-4.7.2-Headless-Editorimport und 60-Frame-Startlauf ohne Parser- oder Laufzeitfehler.
- Offen: Sichtprüfung von Braukessel, Interaktionshinweis und Inventarzählern im Godot-Fenster.

## QUEST-001 – Fenjas Beruhigungstee-Auftrag
- `tests/quest_001_fenja_quest_test.gd` prüft Annahme, aktive HUD-Aufgabe, Reaktion ohne Tee, Abgabe genau eines Tees aus einem Bestand von zwei, dauerhafte Abschlussanzeige, aktualisierte NPC-Hinweise und wiederholte Interaktion ohne weiteren Verbrauch.
- Derselbe Test prüft `Inventory.remove_item` bei fehlendem Gegenstand, unzureichendem Bestand, leerer ID und ungültiger Menge sowie erfolgreiche Entnahme und aktualisierten HUD-Bestand.
- Prüfbefehl: `godot --headless --path . --script tests/quest_001_fenja_quest_test.gd`
- RED: Vor der Implementierung fehlten Fenja, FenjaQuest und QuestStatus; der ausgeführte Test meldete diese drei erwarteten fehlenden Knoten.
- GREEN: `QUEST-001 Fenja quest checks passed.` nach Ergänzung von Quest, Inventarentnahme und HUD.
- Erledigt: QUEST-001-, LOOP-002-, LOOP-001-, ITEM-001- und CORE-002-Headless-Tests, Godot-4.7.2-Headless-Editorimport und 60-Frame-Startszene ohne Parser- oder Laufzeitfehler.
- Offen: Sichtprüfung von Fenjas Platzhalterfigur, Queststatus-HUD und realer Tastaturinteraktion im Godot-Fenster.
- Kein GDScript-Coverage-Werkzeug ist im Projekt eingerichtet; daher wird keine Coverage-Prozentzahl ausgewiesen.

## QUEST-002 – Martens Stärkender-Aufguss-Auftrag
- `tests/quest_002_marten_quest_test.gd` prüft Martens Freischaltung nach Fenjas Abschluss, Questannahme, HUD-Zielwechsel für Sammeln, Trocknen, Brauen und Abgabe, Rückmeldung ohne Aufguss, Abgabe von genau einem Aufguss aus einem Bestand von zwei sowie erneute Interaktion ohne weiteren Verbrauch.
- RED: Vor der Implementierung fehlten Marten und Martens Quest; der neue Headless-Test schlug an diesen erwarteten Prüfungen fehl.
- GREEN: QUEST-002-Headless-Test sowie alle neun früheren Regressionstests bestanden.
- Erledigt: Godot-4.7.2-Editorimport und 60-Frame-Startlauf ohne Parser- oder Laufzeitfehler.
- Offen: Sichtprüfung von Martens Platzhaltergrafik und Quest-HUD im Godot-Fenster.

## UX-001 – Nächstes Ziel entlang der Herstellungskette
- `tests/ux_001_core_loop_guidance_test.gd` spielt den gesamten Ablauf: Fenja ansprechen, Sumpfminze sammeln, trocknen, brauen und den Tee abgeben.
- Der Test prüft die ausgeblendete Zielzeile vor Annahme und danach exakt jeden Zielwechsel: „Sammle eine Sumpfminze.“, „Trockne die Sumpfminze.“, „Braue Beruhigungstee.“, „Bringe Fenja den Beruhigungstee.“ und die bleibende Abschlussmeldung.
- `tests/quest_001_fenja_quest_test.gd` prüft zusätzlich die Übergänge von „Sammle eine Sumpfminze.“ direkt zu „Bringe Fenja den Beruhigungstee.“, wenn bereits Tee im Inventar liegt.
- RED: Vor der Implementierung scheiterten die neuen und erweiterten Prüfungen erwartungsgemäß an der statischen Zielzeile und den fehlenden Zielwechseln.
- GREEN: `UX-001 core loop guidance checks passed.` und `QUEST-001 Fenja quest checks passed.`.
- Prüfbefehl: `godot --headless --path . --script tests/ux_001_core_loop_guidance_test.gd`.
- Erledigt: UX-001- und QUEST-001-Tests sowie LOOP-002-, LOOP-001-, ITEM-001- und CORE-002-Regressionsläufe, Godot-4.7.2-Editorimport und 60-Frame-Startlauf.
- Offen: Sichtprüfung im Godot-Fenster und Beobachtung durch neue Spielende. Die automatisierten Tests belegen Zieltexte und Übergänge, nicht subjektive Verständlichkeit.

## CONTENT-001a – Schilfwurzel sammeln
- `tests/content_001a_reed_root_collection_test.gd` prüft den Startbestand, die neue eigene Item-ID, keinen Sammelerfolg außerhalb der Reichweite, Objektname und Aktion im Hinweis, einmalige Aufnahme, eigene HUD-Aktualisierung sowie den unveränderten Sumpfminze-Bestand.
- RED: Der erste Lauf vor dem Szenen- und HUD-Eintrag meldete das erwartete fehlende Pickup und den fehlenden Zähler.
- GREEN: `CONTENT-001a reed-root collection checks passed.` nach der Implementierung.
- Prüfbefehl: `godot --headless --path . --script res://tests/content_001a_reed_root_collection_test.gd`.
- Erledigt: alle sieben Headless-Tests, darunter CONTENT-001a und die sechs bisherigen Regressionstests, Godot-4.7.2-Editorimport und 60-Frame-Startlauf.
- Offen: Sichtprüfung der neuen Pixelzeichnung und zusätzlichen Inventarzeile im Godot-Fenster.

## LOOP-003 – Schilfwurzel trocknen
- `tests/loop_003_reed_root_drying_test.gd` prüft den Startbestand, fehlende Zutaten, den Weg vom Pickup zur Station, Verarbeitung genau einer Wurzel pro E-Druck, getrennte Frisch-/Trockenbestände und Rückmeldungen für beide Pflanzen.
- Der Test prüft außerdem die bestehende Sumpfminze-Priorität, unabhängige HUD-Zähler, Wiederholungsverarbeitung und Ablehnung ohne Vorrat.
- RED: Vor der Implementierung fehlte der HUD-Zähler `DriedReedRootCount`.
- GREEN: `LOOP-003 reed-root drying checks passed.` nach der Implementierung.
- Prüfbefehl: `godot --headless --path . --script res://tests/loop_003_reed_root_drying_test.gd`.
- Erledigt: alle acht Headless-Tests (LOOP-003 und sieben Regressionen), Godot-4.7.2-Editorimport und 60-Frame-Startlauf.
- Offen: Sichtprüfung der erweiterten HUD-Zeilen im Godot-Fenster.

## LOOP-004 – Stärkenden Aufguss brauen
- `tests/loop_004_strengthening_infusion_test.gd` prüft Startbestand, den weiterhin braubaren Beruhigungstee vor Fenjas Abschluss, die gesperrte Aufguss-Rückmeldung, Questannahme/-abschluss und den Aufguss danach.
- Der Test prüft außerdem genau einen Verbrauch jeder getrockneten Zutat, Produkt-/Zähleranzeige und dass eine fehlende Mehrzutat keinerlei Teilverbrauch oder Ergebnis erzeugt.
- RED: Vor der Implementierung fehlte der `InfusionCount`-Knoten.
- GREEN: `LOOP-004 strengthening infusion checks passed.` nach Resource-, Inventar- und Kesselimplementierung.
- Prüfbefehl: `godot --headless --path . --script res://tests/loop_004_strengthening_infusion_test.gd`.
- Erledigt: alle neun Headless-Tests (LOOP-004 und acht Regressionen), Godot-4.7.2-Editorimport und 60-Frame-Startlauf.
- Offen: Sichtprüfung des erweiterten HUD und des gesperrten Rezeptfeedbacks im Godot-Fenster.

## CONTENT-001b – Nachtmoos sammeln
- `tests/content_001b_night_moss_collection_test.gd` prüft Fundstelle am Torfsteg, eigene ID und Beschriftung, Startbestand, Sammelhinweis in Reichweite, Ablehnung außerhalb der Reichweite, HUD-Änderung, Trennung von Sumpfminze und Schilfwurzel sowie Einmaligkeit.
- RED: Vor der Implementierung fehlten das Nachtmoos-Pickup und `NightMossCount`; der neue Headless-Test schlug an diesen erwarteten Prüfungen fehl.
- GREEN: `CONTENT-001b night-moss collection checks passed.` nach Einbindung der Plant-ID, Karte und HUD.
- Erledigt: alle elf Headless-Tests (CONTENT-001b und zehn Regressionen), Godot-4.7.2-Editorimport und 60-Frame-Startlauf.
- Offen: Sichtprüfung der Nachtmoos-Grafik, des Torfstegs und der zusätzlichen Inventarzeile im Godot-Fenster.

## LOOP-005 – Nachtmoos trocknen
- tests/loop_005_night_moss_drying_test.gd prüft getrennte Frisch-/Trockenbestände, die Priorität Sumpfminze → Schilfwurzel → Nachtmoos, 1:1-Verarbeitung, HUD-Aktualisierung und Rückmeldungen mit sowie ohne Vorrat.
- RED: Vor der Umsetzung fehlte der DriedNightMossCount-Knoten.
- GREEN: „LOOP-005 night-moss drying checks passed.“ nach Ergänzung von Verarbeitung und HUD.
- Prüfbefehl: godot --headless --path . --script res://tests/loop_005_night_moss_drying_test.gd.
- Erledigt: LOOP-005 und alle elf vorherigen Headless-Tests (insgesamt zwölf), Godot-4.7.2-Editorimport und 60-Frame-Laufzeit-Smoke-Check.
- Offen: Sichtprüfung des aktualisierten Inventar-HUDs und des Trockengestells im Godot-Fenster.

## LOOP-006 – Nachttrank brauen
- tests/loop_006_night_potion_brewing_test.gd prüft den Startbestand, Martens Rezeptfreischaltung, fehlende Zutaten ohne Teilverbrauch, 1:1-Verarbeitung, Rückmeldungen und HUD.
- RED: Vor der Umsetzung fehlte der Nachttrank-Zähler.
- GREEN: „LOOP-006 night-potion brewing checks passed.“ nach Rezept-, Quest- und HUD-Anbindung.
- Prüfbefehl: godot --headless --path . --script res://tests/loop_006_night_potion_brewing_test.gd.
- Erledigt: LOOP-006 und alle zwölf vorherigen Headless-Tests (insgesamt dreizehn), Godot-4.7.2-Editorimport und 60-Frame-Laufzeit-Smoke-Check.
- Offen: Sichtprüfung des Nachttrank-Zählers und der Rezeptfreischaltung im Godot-Fenster.

## QUEST-003 – Lenes Nachttrank-Auftrag

- `tests/quest_003_lene_quest_test.gd` prüft, dass Lene erst nach Martens Abschluss verfügbar wird und der HUD-Zieltext durch Schilfwurzel sammeln/trocknen, Nachtmoos sammeln/trocknen und Nachttrank brauen führt.
- Der Test prüft Annahme, Rückmeldung und unveränderten Zustand ohne Trank, Abgabe genau eines Nachttranks aus zwei, Zähler-/Quest-/Interaktions-HUD sowie Wiederholungsinteraktion ohne weiteren Verbrauch.
- RED: Vor der Implementierung fehlten Lene und LeneQuest in der Spielszene.
- GREEN: `QUEST-003 Lene quest checks passed.`; alle vierzehn Headless-Tests, Godot-4.7.2-Editorimport und 60-Frame-Startlauf bestanden.
- Offen: Sichtprüfung von Lenes Platzhaltergrafik, Kartenposition und Quest-HUD im Godot-Fenster.

## BOARD-001 – Auftragsbrett
- tests/board_001_quest_board_test.gd prüft Interaktionsprompt und Öffnen, Status aller drei Aufträge, Freischaltung nach Vorgängerabschluss, Annahme am Brett, NPC-Abgabe, Fokus-/Inputpause, Escape und Schließen-Schaltfläche.
- Die Questtests, der UX-Kernablauf sowie LOOP-004 und LOOP-006 wurden auf die Annahme am Brett umgestellt; NPCs bleiben für die Abgabe zuständig.
- RED: Der neue Test schlug vor der Implementierung wegen fehlendem Brett und Panel erwartungsgemäß fehl.
- GREEN: Der BOARD-001-Test, alle bestehenden Quest-/Rezept-/Sammelregressionen, Godot-4.7.2-Editorimport und 60-Frame-Startlauf bestanden.
- Offen: Sichtprüfung des gezeichneten Bretts, UI-Größe, Lesbarkeit und Tastaturfokus im Godot-Fenster.

## ECON-001 – Münzbelohnungen
- tests/econ_001_quest_rewards_test.gd prüft den Startbestand, erfolgreiche und fehlgeschlagene Abgaben für Fenja, Marten und Lene, die Beträge 5/10/15, Rückmeldung, HUD-Aktualisierung und Schutz vor doppelter Auszahlung.
- RED: Der neue Test schlug vor der Implementierung erwartungsgemäß fehl, weil CoinCount noch nicht existierte.
- GREEN: „ECON-001 quest reward checks passed.“; anschließend bestanden alle 16 Headless-Tests, der Godot-4.7.2-Editorimport und der 60-Frame-Startlauf.
- Prüfbefehl für den Featuretest: Godot 4.7.2 --headless --path . --script res://tests/econ_001_quest_rewards_test.gd. Für die Regression wurden alle 16 GDScript-Testdateien einzeln im Headless-Modus gestartet.
- Offen: Sichtprüfung der Münzzeile und ihrer Lesbarkeit im Godot-Fenster.

## SAVE-001 – Spielstand speichern und laden
- `tests/save_001_game_persistence_test.gd` prüft F5/F9 in der Input Map, manuelles Speichern/Laden, automatisches Laden beim Start, Position, alle Inventarmengen einschließlich Münzen, alle drei Questzustände sowie abgeerntete und noch sichtbare Sammelstellen.
- Der Test prüft zudem fehlenden, beschädigten und nicht unterstützten Spielstand, unbekannte Inventar-IDs sowie eine unmögliche Questabhängigkeit; ungültige Dateien dürfen Position, Inventar oder Queststatus nicht teilweise verändern.
- RED: Vor der Implementierung fehlte der SaveManager in der Main-Szene.
- GREEN: `SAVE-001 persistence checks passed.` nach JSON-Format, vollständiger Validierung und Wiederherstellung.
- Prüfbefehl: `godot --headless --path . --script res://tests/save_001_game_persistence_test.gd`.
- Erledigt: alle 17 Headless-Tests, Godot-4.7.2-Editorimport und 60-Frame-Startlauf bestanden.
- Offen: F5/F9, HUD-Hinweise, Lesbarkeit und tatsächliche Tastatureingabe noch im sichtbaren Godot-Fenster prüfen.

## EXP-001 – Ausbau priorisieren
- Die 17 Headless-Tests bestätigen Mechanik und Zustandsübergänge; sie messen nicht, ob die Graybox im Spielmaßstab gut lesbar oder unterhaltsam wirkt.
- Bisheriges direktes Nutzerfeedback benennt die einfarbige Grafik als Mangel und bevorzugt die zuvor erstellten Moorstimmungen.
- Entscheidung: VIS-001 gestaltet zuerst ein farbiges, zusammenhängendes Segment der vorhandenen Moor-Testkarte. Die Sichtprüfung der integrierten Grafik ist Teil von VIS-001; erst danach werden Jahreszeiten, neue Gebiete und Automatisierung erneut eingeordnet.

## VIS-001 – Moor-Kartengrafik

- Erledigt: Godot-4.7.2-Editorimport inklusive PNG-Atlasimport.
- Erledigt: alle 17 vorhandenen Spiellogiktests bestanden; der 60-Frame-Startlauf meldete keine Parser- oder Laufzeitfehler.
- Erledigt: Hauptszene in Godot gerendert und bei 480 × 270 geprüft; Boden, Teich, Torfweg und Atlasdekorationen sind im tatsächlichen Spielmaßstab sichtbar.
- Codeprüfung: Die vorhandenen Kartengrenzen- und Hindernis-Kollisionsrechtecke sowie Interaktionskoordinaten wurden nicht verändert.
- Noch offen: WASD-/Pfeiltastenbewegung und Kollisionen im laufenden Fenster manuell durchspielen. Der gerenderte Standbild-Check bestätigt keine Eingabe oder subjektiven Spielspaß.

## VIS-002 – Spieler-Richtungen

- Erledigt: tests/vis_002_player_facing_test.gd prüft das geladene 2 × 2-Atlas, Front-, Rücken-, linkes und rechtes Profil, die Richtung nach Eingabe, das Beibehalten im Leerlauf sowie die vertikale Priorität bei Diagonalgleichstand.
- Erledigt: alle 18 Tests, Godot-4.7.2-Editorimport, 60-Frame-Startlauf und ein gerenderter Hauptszenen-Check bei 480 × 270 bestanden.
- Codeprüfung: Spieler-Kollisionsform, Interaktionsbereich, Bewegungsgeschwindigkeit und Zielauswahl blieben unverändert.
- Noch offen: WASD/Pfeiltasten im laufenden Fenster mit echter Eingabe manuell prüfen.
## Automatisierung und CI

- Kein Testframework wird vor dem Bedarf einer eigenständigen Spielregel ergänzt.
- Kein CI-Workflow ist eingerichtet. Nach stabiler Projektstruktur neu bewerten, ob Headless-Import/Smoke-Start automatisiert werden soll.
- Erfolgreicher Editorstart ist kein Nachweis für korrekte Spielregeln oder gute Spielbarkeit.

## VIS-003 – Grafikatlanten für Weltobjekte
- tests/vis_003_visual_atlas_test.gd prüft alle neun Sprite2D-Zuordnungen zu den drei 3-Zellen-Atlanten sowie das Ausblenden eines gesammelten Pflanzen-Sprites.
- Godot-4.7.2-Editorimport einschließlich Reimport des korrigierten Stationenatlas, alle 19 Headless-Tests und ein 60-Frame-Startlauf bestanden.
- Die Hauptszene wurde mit GL Compatibility gerendert und bei 480 × 270 auf Lesbarkeit, Zellzuschnitt und Stil geprüft. Das Trockengestell hält 76 Pixel Abstand zur Zellgrenze; die nächste Grafik beginnt 92 Pixel innerhalb der Nachbarzelle.
- Codeprüfung bestätigt unveränderte Interaktionslogik, Weltpositionen, Kollisionsradien, Inventar, Quests und Speicherverhalten.
- Offen: WASD-/Pfeiltasten, Kollisionen und HUD-Führung noch im sichtbaren Godot-Fenster manuell prüfen.

## REL-001 – Windows-Testbuild vorbereiten
- Das versionierte Profil Windows Desktop exportiert Godot 4.7.2 als x86_64-EXE nach build/windows/Moor-Apotheke.exe; build/ bleibt ignoriert.
- Die passenden Godot-4.7.2-Windows-Vorlagen wurden lokal installiert. Das Release-Preset exportierte erfolgreich; die erzeugte EXE beendete --headless --quit-after 60 mit Exitcode 0.
- Der Testbuild ist nicht signiert. Sichtprüfung und Freigabe einer öffentlichen Veröffentlichung bleiben offen.

## PLAY-001 – HUD, Bewegung und Kollisionen
- tests/play_001_hud_and_collision_test.gd prüft die dunklen HUD-Flächen mit pixeliger Ein-Pixel-Kontur, den Zeichenaufbau hinter Texten, nicht blockierende Panels, WASD- und Pfeiltastenbindungen, alle vier Bewegungsrichtungen sowie Kollisionen mit Fels, Teichbegrenzung und äußerem Kartenrand.
- Godots Input.action_press simuliert die benannten InputMap-Aktionen für die Bewegungsprüfung. Die Godot-4.7-Dokumentation weist darauf hin, dass diese Methode keine _input()-Callbacks erzeugt.
- Die Hauptszene wurde bei 480 × 270 als Godot-Movie-Frame gerendert und auf Lesbarkeit von Steuerleiste und Inventarzählern geprüft.
- Der PLAY-001-Test und alle 19 vorherigen Tests, Godot-Editorimport sowie 60-Frame-Lauf bestanden.
- Offen: subjektives Gefühl physischer Tastatursteuerung wurde nicht manuell bewertet.

## INV-001 – Inventarfenster
- tests/inv_001_inventory_window_test.gd prüft I-Belegung, Öffnen und Schließen mit I/Escape/Schaltfläche, Fokus, aktuelle Bestände aller zehn Einträge, Münzen und Fenstergrenzen bei 480 × 270.
- Der Test prüft außerdem die Verlagerung der detaillierten Bestände aus dem permanenten HUD, die Pause von Bewegung und Weltinteraktionen sowie den Schutz vor Überschneidung mit dem Auftragsbrett.
- Alle 21 Headless-Tests, Godot-4.7.2-Editorimport und 60-Frame-Startlauf bestanden.
- Offen: echte Tastatureingabe und Lesbarkeit im sichtbaren Spielfenster manuell prüfen.

## PLAYTEST-001 – Fenjas Kernschleife im Godot-Viewport
- `tests/playtest_001_core_loop_test.gd` bewegt die Figur über `Input.action_press()` und echte Physikframes vom Auftragsbrett zur Sammelstelle, zum Trockengestell, zum Braukessel und zu Fenja. E und I werden als simulierte Tastaturereignisse an die vorhandenen Handler gegeben.
- Der Test nimmt Fenjas Auftrag an, sammelt Sumpfminze, trocknet sie, braut Beruhigungstee, liefert ihn ab und prüft Inventar, Queststatus sowie fünf Münzen. Ein eigener `user://playtest_001_test_save.json` wird vor und nach dem Lauf entfernt.
- Ein optionaler CLI-Ausgabepfad rendert die geöffnete Inventaransicht im normalen Godot-Viewport als 480 × 270 PNG; die Aufnahme wartet bis `RenderingServer.frame_post_draw`.
- Godot 4.7.2-Headless-Test und normaler GL-Viewportlauf bestanden. Alle 22 Headless-Tests, Editorimport und 60-Frame-Startlauf bestanden.
- Ressourcen-Audit: Je eine einmalig sammelbare Stelle für Sumpfminze, Schilfwurzel und Nachtmoos. Die Questrezepte benötigen zwei Sumpfminzen, zwei Schilfwurzeln und ein Nachtmoos. Damit ist die Folgequestkette aus einem frischen Spielstand aktuell nicht vollständig spielbar.
- Offen: echte Tastatur und subjektives Spielgefühl manuell prüfen.

## RESOURCE-001 – Kräutervorräte für die komplette Questkette
- `tests/playtest_001_core_loop_test.gd` prüft zwei Sumpfminz-, zwei Schilfwurzel- und eine Nachtmoosstelle samt fünf eindeutigen persistenten IDs.
- Die Figur läuft über echte Physikframes vom Auftragsbrett zu den Sammel- und Verarbeitungsstellen. Der Test nimmt Fenjas, Martens und Lenes Bitte am Brett an, verarbeitet und übergibt alle Heilmittel und prüft die drei abgeschlossenen Questzustände, Zutatenverbrauch, Inventar und 30 Münzen.
- RED: Der erweiterte Test scheiterte vor Kartenänderung an den fehlenden zusätzlichen Minz- und Wurzel-Pickups.
- GREEN: `RESOURCE-001 full quest-chain checks passed.`
- SAVE-001 sammelt auch die beiden neuen Fundstellen ein und prüft deren IDs und unsichtbaren Zustand nach F9 und automatischem Laden beim Neustart.
- Alle 22 Headless-Tests, Godot-4.7.2-Editorimport und 60-Frame-Startlauf bestanden.
- Offen: echte Tastatureingabe und subjektives Spielgefühl manuell prüfen.


## AREA-001 – Zweites Moorgebiet
- `tests/area_001_connected_moor_area_test.gd` prüft beide Übergänge und läuft per InputMap-Physikframes zu allen drei neuen Fundorten. Es sammelt Sumpfminze, Schilfwurzel und Nachtmoos, prüft acht global eindeutige IDs und das gemeinsame Inventar.
- Ein isolierter Spielstand prüft Position und alle drei geernteten Pflanzen beim Laden und beim automatischen Wiederherstellen nach Szenenneustart.
- RED: Vor der Implementierung schlug der Test fehl, weil Schilfufer noch nicht in `World` vorhanden war. GREEN: `AREA-001 connected moor area checks passed.`
- Nach einer durch die neue Karte überholten RESOURCE-001-Bestandsannahme wurde der Ressourcen-Audit auf 3 Sumpfminzen, 3 Schilfwurzeln und 2 Nachtmoose über beide Gebiete angepasst.
- Alle 23 Godot-4.7.2-Headless-Tests, Editorimport und 60-Frame-Hauptszene bestanden.
- Ein sichtbarer manueller Test von Bildausschnitt, echter Tastatur und subjektivem Steuerungsgefühl bleibt offen.

## MAP-01 – Dorfplatz
- `tests/map_01_village_plaza_test.gd` prüft die logische Gebiets-ID `Dorfplatz`, Spielerstart und Platzmitte, Apotheke/Eingang, die Wege in fünf Richtungen sowie das Auftragsbrett im Fußweg und seine Bedienbarkeit.
- Der Test läuft im Headless-Modus; zusätzlich wurde der Viewport mit normalem Godot-Renderer bei 480 × 270 aufgenommen und visuell geprüft.
- Der vollständige `playtest_001_core_loop_test.gd`-Lauf nach der Umgestaltung bestätigt die drei Aufträge, Verarbeitungsstationen und 30 Münzen. Eine Brunnenkollision blockierte zunächst den Querweg vom Ostbereich zum Trockengestell; das Gestell liegt nun unterhalb des Brunnens und der komplette Lauf besteht.
- MAP-01-Test: `MAP-01 village plaza checks passed.` End-to-End-Test: `RESOURCE-001 full quest-chain checks passed.`
- Alle 24 Godot-Headless-Testskripte, Godot-Editorimport und der 60-Frame-Startlauf bestehen; die gerenderte Ansicht wurde bei 480 × 270 geprüft.
- SCALE-01 ist als Gebietsplan abgeschlossen; tatsächlicher Flächenaufbau und Blindtests folgen je Gebiet in REG-01 bis REG-05. Physische Eingaben im sichtbaren Fenster bleiben offen.

## MAP-02 – Fünf Dorfwege

- `tests/map_02_routes_and_locks_test.gd` prüft fünf Richtungen, die logische Dorfplatz-ID, den offenen NW-Übergang, vier sichtbare Interaktionssperren und deren physische Kollisionsbarrieren.
- `tests/area_001_connected_moor_area_test.gd` läuft den NW-Weg zum Schilfufer, sammelt dort alle drei Kräuter und prüft den Rückweg zum Dorfplatz sowie Speichern/Laden.
- Die Torhinweise geben die geplanten Voraussetzungen wieder. Die tatsächliche questabhängige Freischaltung wird erst im späteren PROG-01 umgesetzt.
- MAP-02-Routentest, AREA-001-Rückweg, vollständige Questkette, 25 Headless-Testskripte, Editorimport, 60-Frame-Start und sichtbarer 480 × 270-Renderer bestehen.
- REG-01 bis REG-05 ergänzen sichere Rückwege und Rastpunkte für ihre Gebiete, sobald die Szenen entstehen.

## MAP-03 – Wiederverwendbares Moor-Kachelset

- `tests/map_03_reusable_terrain_tileset_test.gd` prüft die gemeinsame TileSet-Ressource, das 16×16-Raster, alle 64 registrierten Zellen des 128×128-Atlas, beide `TerrainBase`-Layer, ihre Profile und vollständige 40×23-Abdeckung ohne Kollision oder Navigation.
- Der Test prüft außerdem den 16-Pixel-Zellabstand sowie die Sichtbarkeit und Spielmaßstabbreite der Sammelpflanzen auf beiden Karten.
- Beide Karten wurden mit normalem Godot-Renderer als 480×270-Viewport aufgenommen. Pfade und Ufer sind ohne sichtbare Lücken; Sammelpflanzen bleiben gegenüber dem ruhigen Grundtile erkennbar.
- Abschlussprüfung: alle 26 Godot-Headless-Tests, Godot-4.7.2-Editorimport und 60-Frame-Hauptszene bestanden.
- Das TileSet ist manuell bemalbar; automatische Terrainmasken sind noch nicht eingerichtet. Die vorhandene Grundkarte behält ihre durchgehenden gezeichneten Wege und Ufer.

## VIS-004 – Haus und Moorvegetation

- `tests/vis_004_environment_style_test.gd` prüft den transparenten 1774×887-Umgebungsatlas, gültige Quellrechtecke und die Verwendung des gemeinsamen Atlas durch beide Karten.
- Dorfplatz und Schilfufer wurden mit normalem Godot-Renderer bei 480×270 aufgenommen. Die neue Apotheke sowie Schilf- und Moosgruppen wurden neben Spieler und Kräutern im Spielmaßstab geprüft; die Laufwege bleiben frei.
- Kollisionsrechtecke, Übergänge und Weggeometrie sind unverändert.
- Abschlussprüfung: alle 27 Godot-Headless-Tests, Godot-4.7.2-Editorimport und 60-Frame-Hauptszene bestanden.

## SCALE-01 – Gebietsraster und spätere Gebietsabnahme

SCALE-01 ist ein Designpunkt; es wurden keine Karten-Szenen geändert und keine Godot-Tests ausgeführt. Bei jedem folgenden REG-Punkt wird die Karte bei 480×270 im Spielmaßstab geprüft:

- Für die Mindestfläche ausschließlich passierbare 16×16-Kacheln und zusammenhängende Lauf-/Lichtungsflächen zählen. Wasser, unpassierbare Hindernisse, massive Dekoration und leere Ränder abziehen.
- Für jedes Gebiet mindestens 6.120 passierbare Kacheln (4×3-Sektor-Kern) nachweisen; 10.200 Kacheln entsprechen dem geplanten 5×4-Ausbauziel. Reicht der sichtbare Kern wegen Wasser oder Hindernissen nicht, werden Kartenränder und Wege erweitert.
- Hauptroute, zwei Seitenwege, Rundroute/Abkürzung, drei Landmarken, drei Gruppen je gebietseigener Sammelressource, zwei optionale Begegnungsorte, Geheimnis und sicherer Rückweg in der laufenden Szene abgehen.
- Mindestens drei neue Spielende pro fertigem Gebiet ohne Vorabhinweise beobachten. Medianzeit, erreichte Teilbereiche, entdeckte Ressourcengruppen, Abkürzung und Geheimnis sowie verpasste Orte festhalten.
- Ziel sind 25–40 Minuten gründliche Ersterkundung. Bei kürzeren Besuchen neue interessante Ziele und Routen ergänzen; keine leeren Laufwege. Kein Hauptfortschritt darf Kampf oder spätere Ausrüstung voraussetzen.
