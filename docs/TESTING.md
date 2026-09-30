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

## Automatisierung und CI
- Kein Testframework wird vor dem Bedarf einer eigenständigen Spielregel ergänzt.
- Kein CI-Workflow ist eingerichtet. Nach stabiler Projektstruktur neu bewerten, ob Headless-Import/Smoke-Start automatisiert werden soll.
- Erfolgreicher Editorstart ist kein Nachweis für korrekte Spielregeln oder gute Spielbarkeit.
