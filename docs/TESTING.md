# Teststrategie

## Aktueller Stand
Es gibt noch keine Gameplaylogik und kein Testframework. Godot 4.7.2 hat das Projekt im Headless-Editor geladen; die Startszene wurde noch nicht als Gameplay-Loop manuell geprüft.

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

## Automatisierung und CI
- Kein Testframework wird vor dem Bedarf einer eigenständigen Spielregel ergänzt.
- Kein CI-Workflow ist eingerichtet. Nach stabiler Projektstruktur neu bewerten, ob Headless-Import/Smoke-Start automatisiert werden soll.
- Erfolgreicher Editorstart ist kein Nachweis für korrekte Spielregeln oder gute Spielbarkeit.
