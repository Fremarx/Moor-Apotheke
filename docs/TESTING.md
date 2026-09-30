# Teststrategie

## Aktueller Stand
Es gibt noch kein Testframework. Godot 4.7.2 hat nach CORE-001 die Graybox-Startszene im Headless-Editor importiert und 60 Laufzeitframes ohne Fehler ausgeführt. Ein sichtbarer Godot-Fenstertest mit echter Tastatur steht noch aus.

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

## Automatisierung und CI
- Kein Testframework wird vor dem Bedarf einer eigenständigen Spielregel ergänzt.
- Kein CI-Workflow ist eingerichtet. Nach stabiler Projektstruktur neu bewerten, ob Headless-Import/Smoke-Start automatisiert werden soll.
- Erfolgreicher Editorstart ist kein Nachweis für korrekte Spielregeln oder gute Spielbarkeit.
