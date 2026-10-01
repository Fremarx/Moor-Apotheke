# Die Moor-Apotheke – Projektplan

Stand: 01.10.2026

## Project Status

### Aktuelle Phase
Phase 7 – Gebietsausbau nach dem überarbeiteten Weltentwurf

### Zuletzt bearbeiteter Task
SYS-02 – sichere Gegner-Begegnungen und schadloser Umgang mit Niederlagen.

### Status
CORE-002 DONE; ITEM-001 DONE; LOOP-001 DONE; LOOP-002 DONE; QUEST-001 DONE; UX-001 DONE; CONTENT-001a DONE; LOOP-003 DONE; LOOP-004 DONE; QUEST-002 DONE; CONTENT-001b DONE; LOOP-005 DONE; LOOP-006 DONE; QUEST-003 DONE; BOARD-001 DONE; ECON-001 DONE; SAVE-001 DONE; EXP-001 DONE; VIS-001 DONE; VIS-002 DONE; VIS-003 DONE; VIS-004 DONE; VIS-005 DONE; REL-001 DONE; PLAY-001 DONE; INV-001 DONE; PLAYTEST-001 DONE; CONTENT-001 DONE; RESOURCE-001 DONE; AREA-001 DONE; MAP-01 DONE; MAP-02 DONE; MAP-03 DONE; SCALE-01 DONE; REG-01 IMPLEMENTED (blind playtest pending); REG-02 IMPLEMENTED (blind playtest pending); SYS-01 DONE; MAP-04 DONE; SYS-02 DONE.

### Fortschritt
Die Aufträge und Rezepte für Fenja, Marten und Lene sind implementiert; RESOURCE-001 ergänzt je eine zweite einmalig sammelbare Sumpfminze- und Schilfwurzelstelle. Alle drei Aufträge lassen sich aus einem frischen Spielstand nacheinander abschließen. Drei Pflanzen werden gesammelt und verarbeitet. Das Auftragsbrett zeigt die Bewohnerbitten und ihre Freischaltung. Erfolgreiche Abgaben zahlen 5, 10 oder 15 Münzen, die direkt im HUD erscheinen. F5 speichert und F9 lädt Position, Inventar, Aufträge und bereits geerntete Pflanzen; vorhandene gültige Spielstände werden beim Start geladen. INV-001 verlagert die Bestandsübersicht in ein kategorisiertes Fenster mit Taste I. VIS-001 gestaltet die ursprüngliche 640 × 360-Testkarte mit warmen Moosflächen, Torfweg, Teichufer und 4 × 4 Dekorationsatlas sichtbar farbiger. VIS-002 integriert den Spielerentwurf als Front-, Rücken- und beide Profilansichten; Tasche und Minzblatt folgen der Perspektive. VIS-003 überträgt den Moor-Pixelstil auf neun Weltobjekte: drei Stationen, drei Bewohner und drei Sammelpflanzen. VIS-004 ersetzt die flach gezeichnete Apotheke durch ein reich schattiertes Hausmotiv und ergänzt passende Schilf- und Moosgruppen im Dorfplatz und Schilfufer. AREA-001 ergänzt das begehbare Schilfufer rechts neben der bisherigen Karte mit Torfplanken, Wasserflächen und drei zusätzlichen, dauerhaft speicherbaren Kräuterstellen. Alle drei Gebiete teilen Inventar und Spielstand; Übergänge laufen über eine kleine Area2D-Signal-Schnittstelle. MAP-01 übernimmt die neuen Entwurfsdateien unter `design/` als maßgebliche Weltplanung und gestaltet den bestehenden kompakten Startbereich als Dorfplatz mit gut erkennbarer Apotheke, Platzmitte, Auftragsbrett und sichtbaren Nord- und Ostwegen. Das Szenenobjekt `TestMap` behält seinen Knotennamen, seine logische Gebiets-ID lautet `Dorfplatz`. MAP-02 ergänzt fünf beschilderte Wege, öffnet Schilfufer im Nordwesten und sperrt vier spätere Übergänge sichtbar und physisch. MAP-03 ergänzt einen wiederverwendbaren 16×16-Mooratlas mit einem ruhigen Grundtile in beiden Startkarten; vorhandene Wege und Ufer bleiben lückenlos gezeichnet, der Atlas enthält passende manuell nutzbare Kachelmotive. Der Rückweg aus Schilfufer führt zum Startpunkt am Nordwestpfad; Rast- und Rückkehrpunkte weiterer Regionen entstehen mit ihren REG-Aufgaben. SCALE-01 legt für alle fünf Gebiete ein gemeinsames 5×4-Sektorraster mit 4×3-Mindestkern, Routen, Landmarken, Ressourcenstellen, optionalen Begegnungen und Geheimnissen fest. REG-01 baut das Schilfufer als 5×4-Karte mit mindestens 6.120 passierbaren Kacheln. REG-02 ergänzt den Alten Torfstich als drittes Gebiet mit Torfgruben, Nachtmoos, Torfherzen, dauerhaftem Stegrückweg und Markstein-Geheimnis.

VIS-005 ergänzt eine neue 8×8-Bodentextur im Stil der Figuren, Kräuter und Natur-Sprites. Beide Karten verteilen 16 ruhige Moos- und Grasvarianten reproduzierbar über die Laufwege; alte flache Bodenkleckse entfallen, Torfwege erhalten kleine Abriebcluster.

SYS-01 versieht alle 18 Sammelstellen in Dorfplatz, Schilfufer und Altem Torfstich mit stabiler Gebiets-, Ressourcen- und Fundortzuordnung. Fundstellen und vertriebene optionale Gegner kehren bei der Rückkehr ins Dorf zurück. Das kostenlose Basis-Kräuterbuch zeigt entdeckte Stellen; Erstentdeckungen bleiben getrennt vom Erntestatus auch in älteren Version-1-Spielständen kompatibel gespeichert.

SYS-02 ergänzt sichtbare Angriffswarnungen, seitliches Ausweichen, drei Herzen, den kostenlosen Kräuterstab und sichere Wegpunkte in allen drei Gebieten. Niederlagen lassen Inventar und Münzen unangetastet; nur ein Stabsieg gibt genau eine passende Gebietszutat.

### Zuletzt abgeschlossen
- **BOOT-001:** Projektanalyse, Anforderungen, Architekturrahmen, RAG-Quellenliste und Entwicklungsablauf dokumentiert.
- **CORE-001:** Graybox-Testkarte, Platzhalterfigur, Kamera und Bewegung.
- **CORE-002:** Interaktionsbereich, E-Taste, nächstes Ziel, HUD-Rückmeldung und graue Kräuterprobe.
- **ITEM-001:** Sumpfminze einmalig sammeln, Inventarbestand führen und im HUD anzeigen.
- **LOOP-001:** Trockengestell wandelt genau eine frische Sumpfminze pro E in getrocknete Minze um.
- **LOOP-002:** Braukessel verbraucht eine getrocknete Minze und stellt mit unbegrenzt verfügbarem Wasser einen Beruhigungstee her.
- **QUEST-001:** Fenja nimmt den Auftrag an, verbraucht bei der Abgabe genau einen Beruhigungstee und zeigt den Abschluss dauerhaft in der laufenden Partie.
- **UX-001:** Das dauerhafte HUD-Ziel führt vom Sammeln über Trocknen und Brauen bis zur Abgabe.
- **CONTENT-001a:** Schilfwurzel als eigene Sammelpflanze, Inventar-ID und HUD-Zähler ergänzt.
- **LOOP-003:** Trockengestell verarbeitet frische Sumpfminze zuerst und danach frische Schilfwurzel; beide erhalten getrennte getrocknete Bestände.
- **LOOP-004:** Beruhigungstee und stärkender Aufguss sind datengetriebene Rezepte; der Aufguss wird nach Fenjas Auftrag freigeschaltet und verbraucht beide Zutaten gemeinsam.
- **QUEST-002:** Marten bietet nach Fenjas Abschluss den Folgeauftrag an, nimmt genau einen stärkenden Aufguss an und zeigt den Fortschritt im Quest-HUD.
- **CONTENT-001b:** Einmalig sammelbares Nachtmoos am schattigen Torfsteg mit eigenem Inventarbestand und HUD-Zähler ergänzt.
- **LOOP-005:** Das Trockengestell verarbeitet Nachtmoos nach Sumpfminze und Schilfwurzel; frischer und getrockneter Bestand werden getrennt angezeigt.
- **LOOP-006:** Der Braukessel verarbeitet nach Martens Auftrag getrocknete Schilfwurzel und Nachtmoos gemeinsam zu einem Nachttrank.
- **QUEST-003:** Lene bietet nach Martens Abschluss ihre Bitte an; das Quest-HUD führt durch Sammeln, Trocknen und Brauen, und die Abgabe verbraucht genau einen Nachttrank.
- **BOARD-001:** Das Auftragsbrett zeigt Fenjas, Martens und Lenes Bitte; verfügbare Aufträge lassen sich am Brett annehmen und die Abgabe bleibt bei den Bewohnern.
- **ECON-001:** Erfolgreiche Abgaben zahlen einmalig 5/10/15 Münzen; Inventar und HUD zeigen den aktuellen Bestand.
- **SAVE-001:** Versionierte JSON-Spielstände in `user://` speichern und laden Position, Inventar, Queststatus und abgeerntete Pflanzen.
- **EXP-001:** Nach Funktions- und Nutzerfeedback den visuellen Ausbau vor neuen Gebieten, Jahreszeiten und Automatisierung einordnen.
- **VIS-001:** Die bestehende Testkarte mit warmen Bodenfarben, Teichufer, Torfweg und pixeligen Moorpflanzen sichtbar ausgestalten.
- **VIS-002:** Den abgestimmten Spielerentwurf als vier Richtungsansichten integrieren und die anatomisch feste Taschen- und Minzplatzierung bewahren.
- **VIS-003:** Trockengestell, Braukessel, Auftragsbrett, Fenja, Marten, Lene sowie Sumpfminze, Schilfwurzel und Nachtmoos als konsistente Sprite-Atlanten integrieren.
- **VIS-004:** Haus und Moorvegetation mit warmen Lichtkanten, kräftigen Konturen und dichten Pixelclustern an Spieler und Kräuter angleichen.
- **VIS-005:** Eintönige Grundfläche durch 16 abgestimmte Moos- und Grasvarianten ersetzen, alte Flachflecken entfernen und Wege mit zurückhaltenden Pixelclustern strukturieren.
- **REL-001:** Windows-x86_64-Exportprofil und Release-Checkliste einrichten; passende Vorlagen lokal installiert; Release-EXE exportiert und gestartet.
- **PLAY-001:** HUD-Hintergründe ergänzen; Richtungsbewegung und Karten-/Hinderniskollisionen prüfen; Spielansicht bei 480 × 270 gerendert.
- **INV-001:** Kategorisiertes Inventarfenster mit Taste I, live aktualisierten Beständen, Escape-/Schließen-Option und pausierter Welt.
- **PLAYTEST-001:** Fenjas Kernschleife mit Bewegung, Sammeln, Trocknen, Brauen, Abgabe und Inventar im Godot-Viewport durchgespielt; Ressourcenknappheit der Folgeaufträge ermittelt.
- **RESOURCE-001:** Zwei Minz- und zwei Schilfwurzelstellen mit eindeutigen Save-IDs ergänzt; Fenja, Marten und Lene aus einem frischen Spielstand end-to-end abgeschlossen.
- **AREA-001:** Schilfufer als zweite 640 × 360-Karte ergänzt, beidseitige Wegübergänge eingerichtet und je eine weitere Sumpfminz-, Schilfwurzel- und Nachtmoosstelle eingebaut.
- **MAP-01:** Dorfplatz mit Apotheke, zugänglichem Eingang, Auftragsbrett und klar sichtbaren Nord- und Ostwegen umgesetzt; die neue Weltplanung liegt versioniert unter `design/`.

- **MAP-02:** Fünf Radialwege mit Wegweisern, NE-Holzsteg, vier blockierten Zukunftswegen und funktionierendem NW-Schilfufer-Rückweg ergänzt. 25 Godot-Tests, Import, Start-Smoke und Rendererbild bestanden.
- **MAP-03:** Wiederverwendbaren 8×8-Terrainatlas mit 16×16-Zellen erstellt und über `TerrainBase` in Dorfplatz und Schilfufer eingebunden. Der ruhige Basistile schafft eine klare Fläche; Wege, Ufer und Pflanzen bleiben im Spielmaßstab lesbar.
- **SCALE-01:** Fünf Gebietsraster mit 4×3-Mindestkern, konkreten Routen, Inhaltsorten und späterem Flächen-/Blindtestverfahren dokumentiert.
- **REG-01:** Schilfufer auf 150×68 Kacheln mit mindestens 6.120 begehbaren Kacheln ausgebaut; sechs Kräutergruppen, sicherer Umweg, dauerhaft senkbarer Fährensteg, dreistufiges Marksteinrätsel, verborgene Mooslichtung und verlustfrei vertreibbarer Schnapper umgesetzt. Blind-Ersterkundung und Spielzeitmessung mit drei neuen Personen bleiben vor Veröffentlichung offen.
- **REG-02:** Alter Torfstich auf 150×68 Kacheln mit über 6.120 begehbaren Kacheln ergänzt; drei Nachtmoos- und drei Torfherzstellen, dauerhaft absenkbarer Torfsteg, drei Messpfähle mit verborgener Arbeitsnische, sichere optionale Begegnungen und Rückweg angelegt. Blinder Erstbesuch mit mindestens drei neuen Personen bleibt vor Veröffentlichung offen.
- **SYS-01:** 18 Fundstellen erhalten feste Gebiets-, Ressourcen- und Ortsdaten. Rückkehr ins Dorf erneuert Pflanzen und optionale Begegnungen; H öffnet ein Basis-Kräuterbuch mit entdeckten Stellen. Erstentdeckungen bleiben separat gespeichert und Version-1-Spielstände ohne dieses Feld sind weiterhin gültig.
- **SYS-02:** Klar sichtbare Warnlinien, Space-Ausweichschritt, kostenloser F-Kräuterstab, drei Herzen und sichere Rückkehrpunkte ergänzt. Sicheres Vorbeigehen gibt nichts und kostet nichts; Stabsiege geben genau eine Regionszutat.
- **MAP-04:** Dorfplatz auf 640 × 544 Pixel vergrößert, drei Cottage-Sprites und Kollisionen integriert, Platzpflaster und südliches Wegenetz ausgearbeitet; Übergänge und Weltkoordinaten bleiben stabil.

### Als Nächstes
Als Nächstes: ENE-01 – Startgegner einzeln platzieren und Warnung, Reichweite sowie Erholung im Gebiet überprüfen. Jahreszeiten und Automatisierung bleiben nachrangig.

### SYS-01 Abnahmekriterien – erledigt
- Alle 18 Fundstellen besitzen eindeutige Save-ID sowie feste Gebiets-, Ressourcen-, Seltenheits- und Ortsdaten; jedes Gebiet hat mindestens zwei häufige und eine seltene Fundstelle.
- Sammelstellen und vertriebene optionale Gegner kehren bei Rückkehr aus einem Gebiet in den Dorfplatz zurück; Geheimstellen bleiben entsprechend ihrem Rätselstatus verborgen.
- Das Basis-Kräuterbuch listet erstentdeckte Stellen und zeigt Gegend, Ort, Pflanze und Seltenheit. Die separate kostenpflichtige UPG-02-Erweiterung bleibt für Rezept-Hinweise vorgesehen.
- Erstentdeckungen werden separat vom Erntestatus gesichert; bestehende Version-1-Spielstände ohne Entdeckungsfeld laden weiter.

### SYS-02 Abnahmekriterien – erledigt
- Schilfschnapper und Moorwühler zeigen vor einem ausweichbaren Angriff eine klar sichtbare Linie; das harmlose Irrlicht lässt sich gefahrlos passieren.
- Der Kräuterstab kostet nichts; bloßes Vorbeigehen gibt keinen Gegenstand, ein Stabsieg genau eine passende Zutat.
- Treffer kosten höchstens ein Herz und löschen keine Zutaten. Nach drei Treffern wacht der Spieler am Gebietspunkt mit drei Herzen auf; Inventar und Münzen bleiben erhalten.
- Kein Gegner ist Voraussetzung für einen Auftrag oder den Zugang zu einer Sammelstelle.

### Blocker
Kein technischer Blocker für die vollständige Questkette. Das Spiel liegt als eigenes öffentliches Repo Fremarx/Moor-Apotheke; abgeschlossene Backlogitems werden auf codex/moor-apotheke gepusht. Physische Tastatur und subjektives Spielgefühl bleiben für deinen manuellen Test offen.

### Offene Entscheidungen
- Zielplattformen über Windows-Entwicklung hinaus werden nach dem ersten spielbaren Prototyp festgelegt.
- Umfang späterer Jahreszeiten und Automatisierung wird nach einem Test des Kernablaufs entschieden.
- Der erste visuelle Ausschnitt orientiert sich am warmen Abendmoor; Dämmerungs- und Frühlingsstimmung bleiben Optionen für spätere Gebiete.

### Technische Schulden
- Bewegung, Kartenillustrationen und Kollisionen bleiben ein einfacher Pixel-Prototyp und sollen im sichtbaren Godot-Fenster beurteilt werden.
- Physische Tastatureingabe und subjektives Steuerungsgefühl wurden nicht manuell bewertet; simulierte InputMap-Aktionen, Kollisionen und ein gerenderter Spielviewport bestehen.
- Der erste Windows-x86_64-Testbuild ist noch unsigniert; App-Metadaten, Lizenzhinweise und öffentlicher Vertriebsweg sind offen.

### Teststatus
- Godot 4.7.2 wurde mit gültiger Windows-Signatur installiert.
- Der Editor hat das neue Projekt headless geladen.
- Die Graybox-Startszene hat den Headless-Editorimport und einen 60-Frame-Laufzeit-Smoke-Check bestanden.
- Ein temporärer Headless-Check hat aktive Kamera, vier Richtungen, Hindernis und Kartenbegrenzung geprüft.
- CORE-002-Headless-Test prüft E-Aktion, Reichweite, nächste Auswahl, Rückmeldung, Verlassen der Reichweite und fortbestehende Bewegung.
- ITEM-001-Headless-Test prüft Startbestand, E-Aufnahme in Reichweite, Sammelhinweis, HUD-Bestätigung, Ausblenden, Einmaligkeit und Ablehnung ungültiger Bestandserhöhungen.
- LOOP-001-Headless-Test prüft fehlende Zutat, 1:1-Verarbeitung, zwei aufeinanderfolgende Umwandlungen, getrennte HUD-Zähler und Ablehnung ohne Vorrat; außerdem bestanden ITEM-001- und CORE-002-Regressionen.
- LOOP-001-Editorimport und 60-Frame-Laufzeit-Smoke-Check bestanden; Sichtprüfung von Station und HUD steht noch aus.
- LOOP-002-Headless-Test prüft Sammeln, Trocknen, Brauen, Mengenverbrauch, Tee-HUD und Ablehnung ohne Zutat; LOOP-001-, ITEM-001- und CORE-002-Regressionsläufe bestanden.
- LOOP-002-Editorimport und 60-Frame-Laufzeit-Smoke-Check bestanden; Sichtprüfung des Braukessels und HUD steht noch aus.
- QUEST-001-Headless-Test prüft Fenjas Bitte, HUD-Status, fehlenden Tee, Abgabe von genau einem Beruhigungstee, wiederholte Interaktion sowie gültige und ungültige `remove_item`-Aufrufe.
- QUEST-001-Headless-Test, alle bisherigen Regressionen, Godot-4.7.2-Editorimport und 60-Frame-Laufzeit-Smoke-Check bestanden.
- UX-001-Headless-Test prüft das Ziel vor Annahme, nach jedem Inventar-/Verarbeitungsschritt und nach dem Abschluss; QUEST-001 sowie frühere Schleifen bestehen als Regressionen.
- UX-001-Editorimport und 60-Frame-Laufzeit-Smoke-Check bestanden.
- CONTENT-001a-Headless-Test sowie alle sechs vorherigen Tests, Godot-4.7.2-Editorimport und 60-Frame-Laufzeit-Smoke-Check bestanden.
- LOOP-003-Headless-Test, sämtliche vorherigen Regressionen, Godot-4.7.2-Editorimport und 60-Frame-Laufzeit-Smoke-Check bestanden.
- LOOP-004-Headless-Test, sämtliche vorherigen Regressionen, Godot-4.7.2-Editorimport und 60-Frame-Laufzeit-Smoke-Check bestanden.
- QUEST-002-Headless-Test sowie alle bisherigen Regressionen, Godot-4.7.2-Editorimport und 60-Frame-Laufzeit-Smoke-Check bestanden.
- CONTENT-001b-Headless-Test sowie alle zehn bisherigen Regressionen, Godot-4.7.2-Editorimport und 60-Frame-Laufzeit-Smoke-Check bestanden.
- LOOP-005-Headless-Test sowie alle elf früheren Tests bestanden; Godot-4.7.2-Editorimport und 60-Frame-Laufzeit-Smoke-Check bestanden.
- LOOP-006-Headless-Test sowie alle zwölf vorherigen Tests (insgesamt dreizehn) bestanden; Godot-4.7.2-Editorimport und 60-Frame-Laufzeit-Smoke-Check bestanden.
- QUEST-003-Headless-Test zuerst rot, danach grün; alle dreizehn früheren Tests (insgesamt vierzehn), Godot-4.7.2-Editorimport und 60-Frame-Laufzeit-Smoke-Check bestanden.
- BOARD-001-Headless-Test zuerst rot, danach grün; alle vierzehn vorherigen Tests (insgesamt fünfzehn), Godot-4.7.2-Editorimport und 60-Frame-Laufzeit-Smoke-Check bestanden.
- SAVE-001-Test zuerst rot, danach grün; prüft F5/F9, automatische Startladung, Wiederherstellung aller gespeicherten Daten und unveränderten Laufzeitzustand bei fehlendem, beschädigtem oder nicht unterstütztem Save. Alle 17 Headless-Tests, Godot-4.7.2-Editorimport und 60-Frame-Laufzeit-Smoke-Check bestanden.
- AREA-001-Test zuerst rot, nach Karten- und Übergangsumsetzung grün; läuft über echte Physikframes zu allen drei neuen Pflanzen, prüft Hin- und Rückweg sowie Speichern, Laden und automatisches Wiederherstellen des zweiten Gebiets. Alle 23 Headless-Tests, Godot-4.7.2-Editorimport und 60-Frame-Hauptszene bestanden.
- SYS-02-Headless-Test zuerst rot, nach Umsetzung grün; prüft Warnphase, Ausweichschritt, Treffer, Rückkehr am Wegpunkt, Inventarerhalt und genau einen Gegnerdrop. Alle 31 Headless-Tests, Godot-4.7.2-Editorimport und 60-Frame-Hauptszenenlauf bestanden.
- REL-001: Godot 4.7.2 Windows-Exportvorlagen installiert; Release-Export nach build/windows/Moor-Apotheke.exe und 60-Frame-Start der EXE mit Exitcode 0 bestanden. Keine Codesignatur; kein öffentlicher Upload.
- PLAY-001: neuer Headless-Test prüft HUD-Hintergründe/-Ränder/-Zeichenreihenfolge, WASD- und Pfeiltastenbindungen, alle vier InputMap-Bewegungsrichtungen, aktive Kamera sowie Fels-, Teich- und Kartenrandkollisionen. Alle 20 Tests, Editorimport und 60-Frame-Lauf bestanden; Hauptszene bei 480 × 270 mit Godot Movie Maker gerendert und auf HUD-Lesbarkeit geprüft.
- INV-001: Test prüft I-Belegung, Modalsteuerung, Fokus, Fenstergrenzen, zehn live aktualisierte Inventarbestände, Escape/Schließen und die Konfliktvermeidung mit dem Auftragsbrett. Alle 21 Tests, Editorimport und 60-Frame-Startlauf bestanden; echte Tastatureingabe bleibt manuell offen.
- MAP-02: alle 25 Headless-Testskripte, Godot-4.7.2-Editorimport und 60-Frame-Hauptszene bestanden; die Dorfkarte wurde mit normalem Renderer als 480 × 270-Viewport gerendert und visuell geprüft.
- MAP-03: alle 26 Headless-Testskripte, Godot-4.7.2-Editorimport und 60-Frame-Hauptszene bestanden. Dorfplatz und Schilfufer wurden im normalen Renderer bei 480 × 270 geprüft; Atlasraster, gemeinsame TileSet-Nutzung, Kachelabstände und Pickup-Lesbarkeit bestehen.
- VIS-004: alle 27 Headless-Testskripte, Godot-4.7.2-Editorimport, 60-Frame-Hauptszene und beide 480 × 270-Kartenrenders bestanden. Haus und neue Naturgruppen wurden neben den Spieler- und Kräutersprites visuell verglichen.
- VIS-005: alle 27 Headless-Testskripte, Godot-4.7.2-Editorimport, 60-Frame-Hauptszene und beide 480 × 270-Kartenrenders bestanden. Die variierte Bodentextur wurde neben Figur, Kräutern, Wegen und Ufer geprüft.
- REG-02: alle 28 Godot-4.7.2-Headless-Tests, Editorimport und 60-Frame-Startlauf bestanden. Der neue Torfhof wurde mit dem normalen OpenGL-Renderer bei 480×270 aufgenommen und auf Weglesbarkeit, Hindernisse und Stil neben Figur und vorhandenen Moor-Atlanten geprüft. Save-/Load-Kompatibilität mit älteren Spielständen ist abgedeckt; der blinde Dreipersonen-Erstbesuch bleibt offen.
- MAP-04: MAP-04-Kartentest, alle 30 Godot-4.7.2-Headless-Skripte, Editorimport und 60-Frame-Hauptszene bestanden. Dorfplatzstart und südliches Wohnviertel wurden mit normalem Renderer bei 480 × 270 kontrolliert.
- Noch offen: physische Tastatureingabe und subjektives Steuerungsgefühl im sichtbaren Fenster selbst erleben; simulierte InputMap-Aktionen bestätigen die Logik, nicht das Gefühl.

### Sicherheitsstatus
Kleines lokales Einzelspielerprojekt ohne Konto, Netzwerkdienst oder personenbezogene Nutzerdaten. Der Spielstand speichert nur benötigte Daten in `user://`; das vollständige Format wird vor Änderungen am laufenden Spiel validiert. Fremde Add-ons und Assets vor Übernahme prüfen; Zugangsdaten gehören nicht ins Repository.

## Projektziel und Anforderungen

Ein gemütliches Top-down-Pixelart-Spiel über eine Apotheke am Moor. Der Spielende sammelt Kräuter, trocknet und verarbeitet sie, stellt Heilmittel her und hilft Dorfbewohnern.

### Funktionale Anforderungen
- Tastatursteuerung und verständliche Interaktion in Reichweite.
- Pflanzen sammeln und Bestände anzeigen.
- Zutaten über Trockengestell und Braukessel verarbeiten.
- Rezepte verbrauchen Zutaten und erzeugen Heilmittel.
- Aufträge annehmen, abgeben und belohnt bekommen.
- Spätere Ausbaustufen erweitern Pflanzen, Bewohner, Rezepte und Gebiete.

### Nichtfunktionale Anforderungen
- Godot 4.7.2 Standard und GDScript als Startstack.
- 2D-Pixelgrafik mit 16-Pixel-Kachelraster und scharfer Darstellung.
- Viewport 480 × 270; Fenster zunächst 960 × 540.
- Kleine, verständliche Szenen und Datenmodelle; keine Architektur ohne konkreten Bedarf.
- Offline und Einzelspieler; keine Konten, Telemetrie oder Netzwerkabhängigkeiten im Prototyp.
- Versionsverwaltung nach jedem fertigen Backlogpunkt.

### Annahmen
- Der erste Prototyp nutzt Platzhaltergrafik und braucht keine finale Animation.
- Fenja ist die erste Auftraggeberin. Ihre Bitte wird am Auftragsbrett angenommen und das Heilmittel direkt bei ihr abgegeben.
- Erste Testschleife: Sumpfminze sammeln → trocknen → Beruhigungstee brauen → Fenja helfen.
- Der erste Test hat keinen Zeitdruck, kein Verderben und keine Spielstandpersistenz.

## Masterplan und Meilensteine

| Phase | Ziel | Meilenstein |
| --- | --- | --- |
| 0. Grundlagen | Projekt, Anforderungen, Entwicklungsregeln und Quellen festhalten | BOOT-001 erledigt |
| 1. Bewegung und Welt | Graue Testkarte, Figur, Kamera und Kollisionen | Figur bewegt sich sicher durch die Testkarte |
| 2. Sammeln und Inventar | Eine Pflanze, Interaktion und Mengenanzeige | Sumpfminze wird aufgenommen und sichtbar gezählt |
| 3. Erste Herstellung | Trockengestell und ein Rezept im Braukessel | Tee entsteht aus korrekt verbrauchten Zutaten |
| 4. Erster Auftrag | Fenjas Bitte, Annahme, Abgabe und Abschluss | Auftrag ohne Neustart der Anwendung abschließbar |
| 5. Lesbarkeit und Stil | Rückmeldungen und erste zusammenhängende Pixelgrafiken | Neue Spielende verstehen den Ablauf ohne externe Erklärung |
| 6. Inhaltserweiterung | Weitere Pflanzen, Rezepte, Bewohner und Auftragsbrett | Erweiterte Inhalte nutzen getestete Systeme |
| 7. Persistenz und Ausbau | Spielstand, weitere Bereiche; Jahreszeiten/Automatisierung erneut prüfen | Spielstand zuverlässig schreiben und laden |
| 8. Release-Vorbereitung | Zielplattform, Exportvorlagen, Lizenz- und Laufzeitprüfung | Reproduzierbarer Build und Test-Checkliste |

## Priorisierter Backlog

| ID | Titel / Ziel | Priorität | Abhängigkeiten | Status |
| --- | --- | --- | --- | --- |
| BOOT-001 | Projekt und Prozess analysieren; Roadmap, Architekturrahmen und Wissensquellen dokumentieren | P0 | – | DONE |
| CORE-001 | Graybox-Testkarte, Platzhalterfigur, Kamera und Bewegung in vier Richtungen | P1 | BOOT-001 | DONE |
| CORE-002 | Interaktionsbereich, Taste E und Hinweis für das nächste Objekt | P1 | CORE-001 | DONE |
| ITEM-001 | Sumpfminze aufnehmen und Inventarbestand anzeigen | P1 | CORE-002 | DONE |
| LOOP-001 | Minze am Trockengestell verarbeiten | P1 | ITEM-001 | DONE |
| LOOP-002 | Getrocknete Minze und Wasser zu Beruhigungstee verarbeiten | P1 | LOOP-001 | DONE |
| QUEST-001 | Fenjas Bitte annehmen, Tee abgeben und Abschluss anzeigen | P1 | LOOP-002 | DONE |
| UX-001 | Kernablauf auf Lesbarkeit prüfen und Rückmeldungen ergänzen | P2 | QUEST-001 | DONE |
| CONTENT-001 | Erweiterter Vertical Slice als kleine, unabhängig prüfbare Inhalte | P2 | UX-001 | DONE |
| CONTENT-001a | Schilfwurzel sammeln, als eigene Pflanze darstellen und im HUD zählen | P2 | UX-001 | DONE |
| LOOP-003 | Schilfwurzel am Trockengestell verarbeiten und als getrocknete Zutat anzeigen | P2 | CONTENT-001a | DONE |
| LOOP-004 | Stärkenden Aufguss aus getrockneter Schilfwurzel und Sumpfminze brauen; nach Fenjas Auftrag freischalten | P2 | LOOP-003, QUEST-001 | DONE |
| QUEST-002 | Martens Bitte um einen stärkenden Aufguss annehmen und erfüllen | P2 | LOOP-004 | DONE |
| CONTENT-001b | Nachtmoos am schattigen Torfsteg sammeln und im HUD zählen | P2 | QUEST-002 | DONE |
| LOOP-005 | Nachtmoos am Trockengestell verarbeiten | P2 | CONTENT-001b | DONE |
| LOOP-006 | Nachttrank aus getrockneter Schilfwurzel und Nachtmoos brauen; nach Martens Auftrag freischalten | P2 | LOOP-005, QUEST-002 | DONE |
| QUEST-003 | Lenes Bitte um einen Nachttrank annehmen und erfüllen | P2 | LOOP-006 | DONE |
| BOARD-001 | Auftragsbrett zum Anzeigen und Annehmen verfügbarer Bewohneraufträge ergänzen | P2 | QUEST-002, QUEST-003 | DONE |
| ECON-001 | Einfache Münzbelohnung für erfüllte Aufträge anzeigen und verbuchen | P2 | BOARD-001 | DONE |
| SAVE-001 | Position, Inventar, Questfortschritt und abgeerntete Pflanzen speichern und laden | P2 | CORE-001, ITEM-001, QUEST-003, ECON-001 | DONE |
| EXP-001 | Ausbau nach Teststand und Nutzerfeedback neu priorisieren | P3 | CONTENT-001, SAVE-001 | DONE |
| VIS-001 | Die Moor-Testkarte in einer zusammenhängenden Pixelart-Richtung gestalten und integrieren | P1 | EXP-001, SAVE-001 | DONE |
| VIS-002 | Den abgestimmten Spielerentwurf mit Tasche und Minze als 4-Wege-Spielfigur integrieren | P1 | VIS-001 | DONE |
| VIS-003 | Arbeitsstationen, Bewohner und Sammelstellen visuell an die neue Moor-Pixelart anpassen | P1 | VIS-002 | DONE |
| REL-001 | Windows-x86_64-Exportprofil und Release-Checkliste einrichten | P3 | stabile Kernschleife | DONE |
| PLAY-001 | HUD-Lesbarkeit, Bewegungsrichtungen und Kollisionen im Godot-Viewport prüfen | P1 | VIS-003 | DONE |
| INV-001 | Ein eigenes Inventarfenster mit Taste I öffnen und schließen | P1 | PLAY-001 | DONE |
| PLAYTEST-001 | Fenjas Kernschleife, Viewport und nächste Ausbauschritte prüfen | P1 | INV-001 | DONE |
| RESOURCE-001 | Genügend Kräuter für Fenja, Marten und Lene bereitstellen und Questkette end-to-end verifizieren | P1 | PLAYTEST-001 | DONE |
| AREA-001 | Zweites Moorgebiet als neue Erkundungsfläche mit zusätzlichen Fundorten ergänzen | P2 | RESOURCE-001 | DONE |
| MAP-01 | Dorfplatz als zentralen Orientierungspunkt mit Apotheke, Brett und sichtbaren Wegen bauen | P0 | AREA-001 | DONE |
| MAP-02 | Fünf sichtbare Gebietspfade samt Start- und Sperrübergängen anlegen | P0 | MAP-01 | DONE |
| MAP-03 | Wiederverwendbares Moor-Kachelset für Boden, Ufer, Wege und Brücken festlegen | P0 | MAP-02 | DONE |
| MAP-04 | Dorfplatz vergrößern, Wege und Platzpflaster ausarbeiten, Wohnhäuser ergänzen | P1 | MAP-03, VIS-004, VIS-005 | DONE |
| VIS-004 | Hausarchitektur und Moorvegetation an den Spieler- und Kräuterstil angleichen | P0 | VIS-003, MAP-03 | DONE |
| VIS-005 | Bodenstruktur und Torfwege an die abgestimmte Moor-Pixelart anpassen | P0 | VIS-004, MAP-03 | DONE |
| SCALE-01 | Fünf Gebietsraster, Mindestkerne und Inhalte konkret planen | P0 | MAP-03 | DONE |
| REG-01 | Schilfufer als großes Startgebiet mit Ressourcenroute bauen | P0 | SCALE-01 | IMPLEMENTED (blind playtest pending) |
| REG-02 | Alter Torfstich als großes Gebiet mit Ressourcen, Abkürzung, Geheimnis und Rückweg ergänzen | P0 | REG-01, SCALE-01 | IMPLEMENTED (blind playtest pending) |
| SYS-01 | Gebietseigene Fundstellen, feste Ressourcen-IDs und Nachwachsen bei Rückkehr ins Dorf | P0 | REG-01, REG-02 | DONE |
| SYS-02 | Sichere Begegnungen mit Gegnern | P0 | SYS-01 | DONE |
| ENE-01 | Startgegner sicher platzieren und Begegnungen abstimmen | P0 | SYS-02, REG-01, REG-02 | NEXT |

### CORE-002 Abnahmekriterien
- Die Interaktion nutzt die benannte Aktion interact auf E.
- Innerhalb der Reichweite erscheint ein Hinweis mit Aktion und Objektname; außerhalb ist der Hinweis verborgen.
- Bei mehreren erreichbaren Zielen wird das räumlich nächste ausgewählt. Ein Interaktionsfeedback bleibt beim Zielwechsel sichtbar und wird durch den HUD-Timer ausgeblendet.
- E löst nur das ausgewählte Ziel aus; ohne Ziel bleibt die Eingabe wirkungslos.
- Die graue Kräuterprobe liefert Bestätigungsfeedback; Sammeln und Inventar bleiben Teil von ITEM-001.
- Der Headless-Test sowie Editorimport und 60-Frame-Smoke-Check laufen erfolgreich.

### ITEM-001 Abnahmekriterien
- Im Moor steht eine klar erkennbare, einmalig sammelbare Sumpfminze mit dem bestehenden Interaktionsbereich.
- In Reichweite zeigt der Hinweis „[E] Sammeln: Sumpfminze“; außerhalb ist er verborgen.
- Das HUD startet mit „Sumpfminze: 0“ und zeigt nach dem Sammeln „Sumpfminze: 1“.
- Ein E-Knopfkontakt sammelt genau ein Exemplar; die Pflanze verschwindet und kann nicht erneut gesammelt werden.
- Der Bestand wird in einer kleinen Inventarkomponente gehalten; die Pflanze meldet das Sammeln über ein Signal.
- Ein Headless-Test deckt Startbestand, Aufnahme, HUD-Aktualisierung, Einmaligkeit und bestehende Interaktionsregressionen ab.
- Editorimport und 60-Frame-Laufzeittest laufen erfolgreich; sichtbare HUD-/Grafikprüfung bleibt separat dokumentiert.

### LOOP-001 Abnahmekriterien – erledigt
- Ein klar erkennbares Trockengestell ist in der Moor-Testszene mit dem vorhandenen E-Interaktionsfluss benutzbar.
- Mit mindestens einer frischen Sumpfminze wandelt E genau eine frische in eine getrocknete Minze um.
- Inventar-HUD und Mengenbestand zeigen frische und getrocknete Minze getrennt; beide ändern sich bei der Umwandlung korrekt.
- Ohne frische Minze bleibt der Bestand unverändert und das HUD meldet verständlich, was fehlt.
- Die erste Umsetzung verarbeitet unmittelbar bei E; ein Trocknungs-Timer und Produktionsanimation bleiben außerhalb des Scopes.
- Ein Headless-Test deckt fehlende Zutat, erfolgreiche 1:1-Umwandlung, HUD-Änderung, Wiederholung ohne Bestand und Interaktionsregressionen ab.
- Editorimport und 60-Frame-Laufzeittest laufen erfolgreich; sichtbare Stations-/HUD-Prüfung bleibt separat dokumentiert.

### LOOP-002 Abnahmekriterien – erledigt
- Der Braukessel bietet die Aktion „Beruhigungstee brauen“ über die vorhandene E-Interaktion.
- Ein erfolgreicher E-Druck verbraucht genau eine getrocknete Sumpfminze und erzeugt genau einen Beruhigungstee.
- Wasser ist unbegrenzt am Braukessel verfügbar und wird gemäß GAME_PLAN.md nicht als Inventargegenstand geführt.
- Ohne getrocknete Minze bleiben alle Bestände unverändert; das HUD zeigt eine verständliche Rückmeldung.
- Ein Headless-Test prüft die Kette Sammeln → Trocknen → Brauen, den HUD-Zähler und den Versuch ohne Zutat.
- LOOP-001-, ITEM-001- und CORE-002-Regressionstests, Editorimport und 60-Frame-Laufzeittest bestehen.
- Sichtprüfung von Braukessel, Interaktionshinweis und Inventarzählern wird durchgeführt oder als offen dokumentiert.

### QUEST-001 Abnahmekriterien – erledigt
- Fenjas Bitte wird am Auftragsbrett per E-Auswahl angenommen; die HUD zeigt danach das aktive Ziel.
- Ohne Tee bleibt die Bitte aktiv und Fenja erklärt freundlich, was noch fehlt.
- Die Abgabe verbraucht genau einen Tee, markiert die Bitte als erfüllt und zeigt den Abschluss dauerhaft in dieser Partie.
- Wiederholtes Ansprechen nach Abschluss verändert weder Queststatus noch Inventar.
- Inventarentnahmen lehnen leere IDs, ungültige Mengen und unzureichenden Bestand ab, ohne den Bestand zu verändern.
- Headless-Test deckt den gesamten Questablauf und `remove_item`-Grenzfälle ab; frühere Schleifen bestehen als Regressionen.
- Queststatus wird in diesem Backlogpunkt nicht gespeichert; Belohnungen, weitere Bewohner und finale Fenja-Grafik bleiben späteren Punkten vorbehalten.
- Godot-Editorimport und 60-Frame-Laufzeittest bestehen; manuelle Sichtprüfung im Godot-Fenster ist separat als offen dokumentiert.

### UX-001 Abnahmekriterien – erledigt
- Vor Annahme bleibt die Zielzeile verborgen; nach Annahme zeigt sie „Sammle eine Sumpfminze.“.
- Frische Minze, getrocknete Minze und fertiger Tee führen nacheinander zu „Trockne die Sumpfminze.“, „Braue Beruhigungstee.“ und „Bringe Fenja den Beruhigungstee.“.
- Nach der Abgabe bleibt „Aufgabe erfüllt: Fenjas Bitte.“ sichtbar.
- Anleitung wird aus vorhandenem Inventarstatus abgeleitet; Rezepte, Interaktionsfeedback, Questbedingungen und Inventarregeln ändern sich nicht.
- Quest-/UX-Headless-Tests und Regressionen, Editorimport sowie 60-Frame-Laufzeittest bestehen.
- Sichtprüfung im Godot-Fenster und Test mit neuen Spielenden bleiben als spätere manuelle Validierung offen.

### CONTENT-001a Abnahmekriterien
- Am Schilfufer gibt es eine interaktive Schilfwurzel mit unterscheidbarem Pixel-Platzhalter und eigenem Inventar-ID `reed_root`.
- Der E-Hinweis benennt Schilfwurzel und Sammelaktion; außerhalb der Reichweite kann sie nicht aufgenommen werden.
- Einsammeln erhöht ausschließlich den Schilfwurzelbestand um eins, aktualisiert „Schilfwurzel: N“ im HUD und entfernt die Pflanze aus der Karte.
- Erneute Interaktion kann dieselbe Pflanze nicht ein zweites Mal aufnehmen; Sumpfminze-Bestand und Anzeige bleiben unverändert.
- Ein eigener Headless-Test prüft Bestand, Hinweis, HUD, einmalige Aufnahme und Trennung von Sumpfminze.
- Verarbeitung der Schilfwurzel und die übrigen Pflanzen, Rezepte, Bewohner sowie Münzbelohnungen bleiben eigene Folgepunkte; das Auftragsbrett ist in BOARD-001 ergänzt.

### CONTENT-001b Abnahmekriterien
- Am schattigen alten Torfsteg wächst ein einmalig sammelbares Nachtmoos mit einer dunklen, klar unterscheidbaren Pixel-Platzhaltergrafik.
- Der E-Hinweis nennt Nachtmoos und die Sammelaktion; außerhalb der Interaktionsreichweite kann es nicht aufgenommen werden.
- Einsammeln erhöht ausschließlich den Bestand `night_moss` um eins, aktualisiert „Nachtmoos: N“ im HUD und entfernt die Pflanze aus der Karte.
- Erneute Interaktion kann dasselbe Nachtmoos nicht noch einmal aufnehmen; Sumpfminze- und Schilfwurzelbestand bleiben unverändert.
- Ein eigener Headless-Test deckt Fundstelle, Reichweite, Inventar-ID, HUD, Einmaligkeit und Trennung der Bestände ab; frühere Inhalte bestehen als Regressionen.
- Trocknung des Nachtmooses ist mit LOOP-005 umgesetzt; LOOP-006 verwendet es im Nachttrank.

### LOOP-003 Abnahmekriterien
- Das Trockengestell verarbeitet genau eine frische Schilfwurzel zu einer getrockneten Schilfwurzel pro E-Druck.
- Bei gemischtem Bestand wird zuerst die Sumpfminze verarbeitet, danach die Schilfwurzel; Rückmeldung benennt die verarbeitete Pflanze.
- Frischer und getrockneter Schilfwurzelbestand erscheinen in eigenen Inventar-/HUD-Zählern.
- Ohne frische Zutat werden keine Bestände geändert und die Rückmeldung nennt beide akzeptierten Pflanzen.
- LOOP-001 und die restlichen Kernschleifen bestehen unverändert als Regressionen.

### LOOP-004 Abnahmekriterien
- Beruhigungstee bleibt vor und nach Fenjas Auftrag als Startrezept verfügbar.
- Der stärkende Aufguss benötigt genau eine getrocknete Sumpfminze und eine getrocknete Schilfwurzel und ist vor Fenjas abgeschlossenem Auftrag gesperrt.
- Nach Fenjas Abschluss verbraucht ein erfolgreicher Brauvorgang beide Zutaten zusammen und erzeugt genau einen Aufguss; fehlende Zutaten verursachen keinen Teilverbrauch.
- Beide Rezepte sind als Godot-Resources definiert; Inventar, Freischaltung, Feedback und Ergebnisanzeige bleiben getrennte Zuständigkeiten.
- Ein eigener Headless-Test prüft Rezeptfreischaltung, Zutatenverbrauch, Ergebnis-HUD und atomare Mehrzutatenverarbeitung.

### QUEST-002 Abnahmekriterien
- Marten ist als interaktiver Bewohner in der Testkarte vorhanden und verweist vor Fenjas Abschluss auf Fenjas Bitte.
- Nach Fenjas Abschluss kann Martens Bitte angenommen werden; der Queststatus bleibt davor unverändert.
- Ohne stärkenden Aufguss bleibt Martens Bitte aktiv und weder Inventar noch Queststatus ändern sich.
- Eine erfolgreiche Abgabe verbraucht genau einen stärkenden Aufguss, schließt die Bitte ab und aktualisiert Inventar-, Interaktions- und Quest-HUD.
- Wiederholtes Ansprechen nach Abschluss verbraucht keinen weiteren Aufguss.
- Das HUD führt während Martens Bitte anhand der Bestände zum nächsten benötigten Schritt.
- Ein eigener Headless-Test prüft die Freischaltung nach Fenja, Annahme, fehlenden Gegenstand, Abgabe und Wiederholungsinteraktion; frühere Schleifen bleiben Regressionen.

### BOARD-001 Abnahmekriterien – erledigt
- Ein physisches Auftragsbrett ist über die normale E-Interaktion erreichbar und öffnet ein eigenes HUD-Panel.
- Das Panel zeigt Fenja, Marten und Lene mit ihrem jeweiligen Heilmittel und dem Status „Annehmen“, „Gesperrt“, „In Arbeit“ oder „Erledigt“.
- Marten wird erst nach Fenjas Abschluss und Lene erst nach Martens Abschluss am Brett freigeschaltet.
- Aufträge lassen sich nur am Brett annehmen; Bewohner nehmen weiterhin die fertigen Mittel direkt entgegen.
- Während das Panel geöffnet ist, pausieren Bewegung und Weltinteraktion; Escape und die Schaltfläche „Schließen“ schließen es wieder und stellen die Eingabe her.
- Fokus liegt beim Öffnen auf der ersten verfügbaren Aktion; gesperrte und bereits angenommene Aufträge sind deaktiviert.
- BOARD-001-, Quest-, Kernablauf- und Rezeptregressionstests bestehen; Godot-Editorimport und 60-Frame-Laufzeittest bestehen.
- Sichtprüfung der Brettgrafik, Panelgröße und Lesbarkeit im Spielmaßstab bleibt offen.

### QUEST-003 Abnahmekriterien
- Lene ist als interaktive Bewohnerin vorhanden und bietet ihre Bitte erst nach Martens Abschluss zur Annahme an.
- Die aktive Quest führt das HUD anhand des Inventars durch Schilfwurzel sammeln/trocknen, Nachtmoos sammeln/trocknen und Nachttrank brauen.
- Ohne Nachttrank bleibt die Bitte aktiv und Bestand sowie Queststatus ändern sich nicht.
- Die erfolgreiche Abgabe verbraucht genau einen Nachttrank, schließt die Bitte ab und aktualisiert Zähler, Feedback, Interaktionshinweis und Quest-HUD.
- Wiederholtes Ansprechen nach Abschluss verbraucht keinen weiteren Nachttrank.
- Der Headless-Test prüft Freischaltung, Zutatenführung, Annahme, fehlenden Gegenstand, Abgabe und Wiederholungsinteraktion; alle bisherigen Tests bleiben Regressionen.
- Sichtprüfung von Lene, ihrer Platzierung und dem Quest-HUD im Godot-Fenster bleibt separat dokumentiert.

### LOOP-005 Abnahmekriterien
- Das Trockengestell verarbeitet pro E-Druck genau eine frische Nachtmoos-Einheit zu einer getrockneten Einheit.
- Die Priorität des Gestells bleibt Sumpfminze vor Schilfwurzel vor Nachtmoos; nicht ausgewählte Zutaten bleiben unberührt.
- Frisches und getrocknetes Nachtmoos erhalten getrennte Inventarbestände und HUD-Zähler.
- Ohne frische Zutat bleiben alle Bestände unverändert und die Rückmeldung nennt Sumpfminze, Schilfwurzel und Nachtmoos.
- Ein eigener Headless-Test deckt Reihenfolge, 1:1-Verarbeitung, getrennte Zähler, Feedback und Regressionen ab.
- Sichtprüfung im Godot-Fenster bleibt separat dokumentiert.

### LOOP-006 Abnahmekriterien
- Der Braukessel erhält ein Nachttrank-Rezept mit genau einer getrockneten Schilfwurzel und einem getrockneten Nachtmoos als Zutaten.
- Vor Abschluss von Martens Auftrag bleibt das Rezept gesperrt und verbraucht bei einem Brauversuch keine Zutat.
- Nach Martens Abschluss aktualisiert Main den Stationsstatus; ein E-Druck verbraucht beide Zutaten gemeinsam und erzeugt genau einen Nachttrank.
- Fehlt eine Zutat, bleibt der Bestand vollständig erhalten; Rückmeldung und getrennte HUD-Zähler zeigen den Zustand korrekt.
- Der Headless-Test prüft Sperre/Freigabe, atomare Zutatenverarbeitung, wiederholtes Brauen und HUD; alle vorherigen Schleifen bestehen als Regressionen.
- Sichtprüfung des neuen HUD-Zählers und Brauablaufs im Godot-Fenster bleibt separat dokumentiert.

### ECON-001 Abnahmekriterien – erledigt
- Fenja, Marten und Lene zahlen nach erfolgreicher Abgabe jeweils 5, 10 und 15 Münzen; nur nach erfolgreichem Entfernen des Heilmittels wird die Belohnung verbucht.
- Die Rückmeldung nennt den Betrag; der Bestand coins und die HUD-Zeile „Münzen: N“ aktualisieren sich sofort.
- Fehlende Heilmittel und wiederholte Interaktion nach Abschluss zahlen keine Münzen ein zweites Mal.
- Ein Headless-Test prüft Startstand, alle drei Beträge, Feedback, HUD, fehlgeschlagene Abgaben und Einmaligkeit; frühere Tests bestehen als Regressionen.
- Münzbestand und Questzustände werden durch SAVE-001 sitzungsübergreifend gespeichert.

### SAVE-001 Abnahmekriterien – erledigt
- F5 speichert eine versionierte JSON-Datei in Godots `user://`; F9 lädt sie und beim Start wird ein gültiger Spielstand automatisch wiederhergestellt.
- Spielerposition, alle bekannten Inventarmengen inklusive Münzen, die drei Bewohneraufträge und abgeerntete Kräuterstellen werden gespeichert.
- Unbekannte Inventar-IDs, ungültige Zahlen, Questzustände mit unmöglicher Freischaltreihenfolge, unbekannte/doppelte Pickup-IDs, beschädigte Daten und nicht unterstützte Versionen werden vor dem Anwenden abgelehnt.
- Ein ungültiger Spielstand verändert weder Position, Inventar noch Queststatus; die Laufzeitaktion zeigt verständliches Feedback.
- Der SAVE-001-Headless-Test besteht rot/grün; alle 17 Headless-Tests, Editorimport und 60-Frame-Laufzeit-Smoke-Check bestehen.
- Sichtprüfung der F5-/F9-Hinweise im Godot-Fenster bleibt Teil der noch offenen manuellen Sichtprüfung.

### EXP-001 Ergebnis – erledigt
Die 17 Headless-Tests bestätigen die vorhandenen Spielregeln; sie bewerten weder die Bildwirkung im Spielmaßstab noch den Spielspaß. Aus dem bisherigen direkten Feedback ist die aktuell einfarbige Graybox-Grafik der stärkste bekannte Mangel. Die drei zuvor besprochenen Moorstimmungen geben eine konkrete visuelle Richtung.

| Ausbauoption | Wirkung (1–5) | Sicherheit (1–5) | Aufwand (1–5) | ICE: Wirkung × Sicherheit ÷ Aufwand |
| --- | ---: | ---: | ---: | ---: |
| Visueller Ausschnitt der bestehenden Moor-Testkarte | 5 | 5 | 3 | 8,3 |
| Neues Moorgebiet | 4 | 3 | 5 | 2,4 |
| Jahreszeiten und Wetter | 3 | 2 | 4 | 1,5 |
| Erste Automatisierung | 3 | 2 | 5 | 1,2 |

- VIS-001 setzt diese Entscheidung um: Die Testkarte erhält Boden-, Ufer-, Weg- und Pflanzendetails, während Spiellogik und Kollisionsflächen gleich bleiben.
- Für den ersten Abschnitt dient das warme Abendmoor als Ausgangspunkt. Dämmerungs- und Frühlingsstimmungen werden als spätere Gebietsrichtungen vorgemerkt.
- Jahreszeiten, zusätzliche Gebiete und Automatisierung werden nach Sichtprüfung des integrierten Grafikabschnitts erneut bewertet. Der manuelle Test im Godot-Fenster ist weiterhin offen; die Priorisierung behauptet nicht, dass die Graybox bereits als unterhaltsam bestätigt wurde.

### PLAYTEST-001 Ergebnis – erledigt
Der neue Integrationstest durchläuft Fenjas Auftrag im laufenden Godot-Viewport: Bewegung über physikalische Frames, Auftragsannahme am Brett, Minze sammeln, trocknen, Tee brauen, Fenja beliefern und anschließend das Inventar öffnen. Der Test isoliert den Spielstand unter `user://playtest_001_test_save.json`. `Input.action_press` bewegt die Figur über die echte Physik; E und I werden als simulierte Tastaturereignisse an die vorhandenen Handler gegeben. Das ist kein Test mit physischer Tastatur.

Die gerenderte Hauptszene samt geöffnetem Inventar passt bei 480 × 270 in den Viewport. Zehn Inventarbestände und die Münzbelohnung sind sichtbar. Die visuelle Einschätzung ist eine Bildprüfung; Lesbarkeit und Steuerungsgefühl auf dem eigenen Bildschirm müssen noch von dir beurteilt werden.

Der Ressourcen-Audit findet je eine nicht nachwachsende Sumpfminze-, Schilfwurzel- und Nachtmoosstelle. Die Rezepte der Questkette verbrauchen insgesamt zwei Sumpfminzen (Fenja und Marten), zwei Schilfwurzeln (Marten und Lene) und ein Nachtmoos (Lene). Deshalb lässt sich aus einem frischen Spielstand aktuell nur Fenjas Auftrag fertigstellen.

| Nächste Option | Wirkung | Sicherheit | Aufwand | ICE |
| --- | ---: | ---: | ---: | ---: |
| RESOURCE-001: fehlende einmalige Kräuterstellen ergänzen und alle drei Aufträge spielbar machen | 5 | 5 | 2 | 12,5 |
| Neues Moorgebiet mit weiterem Sammelziel | 4 | 3 | 4 | 3,0 |
| Jahreszeiten und Nachwachsen | 3 | 2 | 4 | 1,5 |
| Erste Automatisierung | 3 | 2 | 5 | 1,2 |

Die ICE-Werte sind eine vorläufige Einschätzung nach dem reproduzierbaren Ressourcen-Audit, keine Aussage darüber, was sich für dich am unterhaltsamsten spielt.

### RESOURCE-001 Ergebnis – erledigt
Die Testkarte enthält nun je zwei einzeln speicherbare Sumpfminz- und Schilfwurzelstellen sowie eine Nachtmoosstelle. Die neuen Fundorte liegen auf der südlichen Wegfläche und verwenden die bestehenden Interaktionen, Atlasgrafiken und Inventar-IDs; beide neuen `pickup_id`-Werte sind eindeutig.

Der erweiterte End-to-End-Test startet ohne Spielstand, bewegt die Figur über Physikframes und schließt Fenjas, Martens und Lenes Auftrag nacheinander ab. Er prüft Zutatenverbrauch, Queststatus, alle fünf Fundstellen, das Inventar und insgesamt 30 Münzen. SAVE-001 sammelt und speichert zusätzlich alle vier Minz-/Wurzelstellen und prüft deren Wiederherstellung nach Laden und Neustart.

- RED: Der neue Test scheiterte erwartungsgemäß, weil die beiden zusätzlichen Pickup-Knoten noch fehlten.
- GREEN: Die vollständige Drei-Aufträge-Runde und SAVE-001 bestehen mit den neuen Fundstellen.
- Alle 22 Headless-Tests, Godot-4.7.2-Editorimport und der 60-Frame-Startlauf bestanden.
- Echte Tastatureingabe und subjektives Spielgefühl bleiben für deinen manuellen Test offen.

### AREA-001 Abnahmekriterien – erledigt
- Das Schilfufer ist eine begehbare, 640 × 360 große zweite Karte neben TestMap; ein Auslöser führt hin und ein weiterer zurück.
- Die neue Karte zeigt eine eigene Moorpalette, Torfplanken, Wasserflächen und Schilf und nutzt vorhandene Pixelart-Atlanten.
- Je eine neue Sumpfminz-, Schilfwurzel- und Nachtmoosstelle sind über echte Laufwege erreichbar und verwenden eindeutige Pickup-IDs im gemeinsamen Inventar.
- Die 1280 × 360-Welt ist innerhalb der Kamera- und Save-Grenzen; Fundstellen und Position werden beim Laden im zweiten Gebiet wiederhergestellt.
- AREA-001-Test zuerst rot und danach grün; alle 23 Headless-Tests, Godot-Editorimport und 60-Frame-Startlauf bestehen. Sichtbare Kontrolle auf dem eigenen Bildschirm bleibt offen.

### MAP-01 Abnahmekriterien – erledigt
- Die Dorfplatz-Karte wird logisch als `Dorfplatz` identifiziert; der bestehende Szenenknoten `TestMap` bleibt für vorhandene Szenenpfade stabil.
- Startpunkt und Dorfplatzmitte liegen bei `(320, 190)`; der Blick führt auf die Wege, deren fünf Richtungen und Freischaltungen MAP-02 festlegt.
- Die Apotheke, ihr Eingang und das Auftragsbrett sind auffindbar; Brett und Eingang lassen sich zu Fuß erreichen, ohne den Ostweg zu blockieren.
- MAP-01-Test und vollständiger RESOURCE-001-Questlauf bestehen; alle 24 Godot-Headless-Tests, Editorimport, 60-Frame-Startlauf und sichtbare 480 × 270-Rendererprüfung sind grün.
- Die sichtbare Spielansicht wurde im Godot-Renderer bei 480 × 270 aufgenommen. MAP-02 zeigt inzwischen die vier weiteren Gebietspfade als gesperrte Übergänge; SCALE-01 definiert jetzt den Flächen- und Inhaltsplan; REG-01 baut das Schilfufer auf 150×68 Kacheln; seine Laufbarkeit wird mit einer Rasterzählung und echten Physikwegen geprüft. REG-02 ergänzt den 5×4-Alten-Torfstich mit gemessener Laufbarkeit, sicherem Rückweg, Abkürzung und gespeichertem Geheimnis.

### MAP-02 Abnahmekriterien – erledigt
- Fünf beschilderte Wege laufen vom Dorfplatz zu Schilfufer (NW), Quellsenke (NE), Alter Torfstich (O), Nebelhain (SW) und Versunkenem Wurzelhain (SE).
- Der NW-Übergang ins bestehende Schilfufer ist begehbar; der Rückweg setzt den Spieler am NW-Startpunkt des Dorfplatzes ab.
- Vier noch nicht gebaute Regionen sind durch sichtbare Holzbarrieren und untersuchbare Tore klar gesperrt; ihre geplanten Auftragsbedingungen werden angezeigt.
- Die NE-Route besitzt einen sichtbaren Holzsteg über dem Teich. Wegverlauf, Bewohner und Stationen lassen die fünf Richtungen frei.
- REG-Aufgaben ergänzen sichere Rückwege und Rastpunkte in den jeweiligen Gebieten, sobald deren Szenen entstehen.
- MAP-02- und AREA-001-Tests, alle 25 Headless-Skripte, Editorimport, 60-Frame-Start und der gerenderte Viewport bestehen.

### MAP-03 Abnahmekriterien – erledigt
- Ein gemeinsamer 16×16-Terrainatlas stellt Gras, Torf, Schlamm, Wege, Wasser, Ufer, Stege und Schilf als 8×8-Raster bereit.
- Dorfplatz und Schilfufer verwenden dasselbe TileSet in einer dekorativen, kollisionsfreien `TerrainBase`-Ebene; alle 40×23 Zellen sind belegt.
- Die bestehenden gezeichneten Wege und Ufer bleiben in beiden 480×270-Kartenansichten durchgehend; Sammelpflanzen sind am Spielmaßstab lesbar.
- Der MAP-03-Test, alle 26 Headless-Skripte, Godot-4.7.2-Editorimport und 60-Frame-Hauptszene bestehen.
- Die Atlasgrafik, Herkunft, Bearbeitungsschritte und manuelle TileSet-Verwendung sind in `docs/ART_ASSETS.md` dokumentiert. Automatische Terrainmasken sind nicht Bestandteil dieses Slices.

### SCALE-01 Abnahmekriterien – Entwurf abgeschlossen

- Fünf konkrete 5×4-Sektorraster legen die Teilbereiche, Hauptrouten, zwei Seitenwege, den 4×3-Mindestkern und den 5×4-Ausbau fest.
- Jedes Gebiet hat drei Landmarken, drei Gruppen je gebietseigener Sammelressource, zwei freiwillige umgehbare Begegnungsorte, eine mehrschrittige optionale Entdeckung, eine lokale Aufgabenidee, sicheren Rückweg und dauerhaft auffindbare Abkürzung.
- Die Ressourcennamen, Gegner, Übergangsbedingungen und Auftragsstufen stimmen mit design/resource_economy.md, design/enemy_roster.md und design/progression_roadmap.md überein.
- Die Szenegrößen werden erst in REG-01 bis REG-05 anhand passierbarer 16×16-Kacheln gemessen; mindestens 6.120 Kacheln pro Gebiet, 10.200 als 5×4-Ziel. Wasser, unpassierbare Hindernisse und leere Ränder zählen nicht.
- Vor jeder Veröffentlichung wird das Gebiet von mindestens drei neuen Personen erkundet; Medianzeit, besuchte Bereiche, gefundene Gruppen und verpasste Inhalte werden protokolliert.
- SCALE-01 ist reine Planung: Keine Spielszene und kein Runtime-Test wurden in diesem Schritt geändert oder ausgeführt.

### MAP-04 Abnahmekriterien – erledigt
- Dorfplatz ist 640 × 544 Pixel groß; der 40 × 34-Grundboden reicht bis an die Südgrenze. Die Weltpositionen der anderen Gebiete und des bestehenden Dorfes bleiben unverändert.
- Der Platz nutzt gestaffelte Pflastersteine mit sichtbaren Fugen und variierter Patina. Ein verbreiterter südlicher Zugang verbindet den Platz mit dem neuen Wohnviertel.
- Drei Cottage-Sprites stehen südlich des bisherigen Dorfzentrums. Jedes Haus besitzt eine zur sichtbaren Fassade passende Blockerkollision; Hofgärten, Holz und Wassergefäß füllen die Straßenränder.
- Der MAP-04-Test prüft Kartengrenze, Kachelbelegung, Kamera, Hausmarker und Kollisionen. Alle 30 Godot-4.7.2-Headless-Tests, Editorimport, 60-Frame-Start und beide 480 × 270-Dorfausschnitte bestehen.

### VIS-001 Abnahmekriterien – erledigt
- Die 640 × 360-Testkarte zeigt bei 480 × 270 eine abgestimmte warme Moorpalette mit abwechslungsreichem Boden, lesbarem Teichufer und Torfweg.
- Ein transparenter 4 × 4-Dekorationsatlas ergänzt Schilf, Farne, Blüten, Steine und Wasserlilien; die genaue Herkunft und die finalen Prompts stehen in docs/ART_ASSETS.md.
- Bewegungslogik, Interaktionen, Pickup-Positionen und vorhandene Kollisionsrechtecke bleiben unverändert.
- Die tatsächliche Hauptszene wurde in Godot 4.7.2 bei 480 × 270 sichtbar gerendert und geprüft.
- Godot-Editorimport, alle 17 vorhandenen Spiellogiktests und der 60-Frame-Startlauf bestehen.
- Noch offen bleibt der Tastaturtest mit Bewegung und Kollision im laufenden Fenster sowie die subjektive Stilrückmeldung.
### VIS-002 Abnahmekriterien – erledigt
- Der Spieler verwendet vier getrennte, freigegebene Ansichten: vorne, hinten, Profil nach links und Profil nach rechts.
- Die Richtung folgt der letzten Bewegungsrichtung; bei diagonaler Eingabe gewinnt die stärkere Achse, bei Gleichstand die vertikale. Im Leerlauf bleibt die letzte Ansicht stehen.
- Die Tasche bleibt anatomisch links befestigt: im Frontbild auf der Betrachter-rechten Seite, in der Rückenansicht auf der Betrachter-linken Seite. In Profilen verdeckt der Körper die Tasche, wenn dieselbe Seite nicht sichtbar ist.
- Das Minzblatt wächst aus der Taschenöffnung, erscheint vorne und in der linken Profilansicht und bleibt in der Rücken- und rechten Profilansicht verdeckt.
- Bewegungs-, Kollisions- und Interaktionsflächen bleiben unverändert.
- Die transparente 2 × 2-Grafik und der vollständige Prompt stehen in docs/ART_ASSETS.md; die Figur wurde in der Hauptszene bei 480 × 270 geprüft.
- Godot-Import, alle 18 Spiellogik- und Richtungsprüfungen und der 60-Frame-Startlauf bestehen.
- Noch offen bleibt die manuelle Steuerung mit echter Tastatur im laufenden Fenster.
### VIS-003 Abnahmekriterien – erledigt
- Drei transparente, horizontale 3-Zellen-PNG-Atlanten stellen Stationen, Bewohner und Sammelpflanzen im Stil der Moor- und Spieleratlanten dar.
- Trockengestell, Braukessel und Auftragsbrett sowie Fenja, Marten, Lene, Sumpfminze, Schilfwurzel und Nachtmoos verwenden den jeweils passenden Sprite2D-Frame.
- Alle neun Motive wurden in der Hauptszene bei 480 × 270 auf Lesbarkeit und Stil geprüft.
- Interaktionslogik, Positionen, Kollisionsradien, Inventar, Quests und Speicherverhalten bleiben unverändert.
- Godot-Import, alle 19 Headless-Tests und der 60-Frame-Startlauf bestehen.
- Der neue VIS-003-Test prüft Atlaszuordnung sowie das Ausblenden und Wiederanzeigen eines gesammelten Pflanzen-Sprites.
- Noch offen bleibt die manuelle WASD-/Pfeiltastenprüfung im laufenden Fenster.
### VIS-004 Abnahmekriterien – erledigt
- Die Apotheke verwendet ein detailreiches, transparentes Pixelmotiv mit dunklen Torfkonturen, warmen Lichtkanten und Materialschattierung passend zu Figuren und Kräutern.
- Schilf- und Moosgruppen verwenden dieselbe abgestufte Farbpalette und bleiben bei 480 × 270 gut lesbar, ohne Wege, Übergänge oder Interaktionsflächen zu verdecken.
- Der Umgebungsatlas ist transparent, jede verwendete Quellregion liegt innerhalb der Bildgrenzen und beide Karten zeichnen ihn über die dokumentierte `CanvasItem.draw_texture_rect_region()`-API.
- Kartenwege, Kollisionsrechtecke und Übergänge bleiben unverändert; Herkunft, Prompts und Lizenzstatus des neuen Assets sind dokumentiert.
- Der VIS-004-Test, alle Headless-Tests, Godot-4.7.2-Editorimport, 60-Frame-Hauptszene und beide normal gerenderten 480 × 270-Kartenbilder bestehen.

### VIS-005 Abnahmekriterien – erledigt
- Ein handgefertigter 8×8-Terrainatlas ergänzt 16 gemäßigte Moos- und Grasbodenvarianten, passend zu den vorhandenen Spieler-, Kräuter- und Umweltgrafiken.
- Dorfplatz und Schilfufer verwenden das neue Atlasbild über das gemeinsame 16×16-TileSet; ein zellpositionsbasierter Hash verteilt die Varianten reproduzierbar und kollisionsfrei.
- Die vorherigen flachen Streifen und Moosflecken übermalen den Boden nicht mehr. Torfwege erhalten sparsame Abrieb- und Kieselpixel, ohne Laufwege und Orientierung zu verdecken.
- Der MAP-03-Test prüft auf beiden Karten mindestens zwölf verwendete Basisvarianten und die vollständige TileSet-Nutzung. Alle 27 Headless-Tests, Godot-4.7.2-Editorimport, 60-Frame-Hauptszene und beide normal gerenderten 480 × 270-Kartenbilder bestehen.
- Herkunft, Dateipfade, Verkleinerungsschritte und finaler Bildprompt sind in `docs/ART_ASSETS.md` dokumentiert.
### Definition of Done pro Backlogpunkt
- Taskziel und Abnahmekriterien sind erfüllt.
- Projekt lädt; relevante Editor- oder Laufzeitprüfung ist erfolgreich.
- Logik ist durch passende automatisierte oder dokumentierte manuelle Prüfungen abgedeckt.
- Fehler, Risiken und ausgelassene Prüfungen sind festgehalten.
- Architektur-, Entwicklungs- und Spielplandokumente sind bei Bedarf aktualisiert.
- Diff auf Scope, generierte Dateien und versehentliche Secrets prüfen.
- Einen thematisch passenden Commit erstellen und auf origin/codex/moor-apotheke pushen.

### Test- und Qualitätsziele
- Jede Spielschleife erhält nachvollziehbare Abnahmeschritte.
- Reine Daten-/Regellogik automatisiert prüfen, sobald sie eigenständig genug ist.
- Bewegung, UI, Kamera und Grafik manuell im Godot-Fenster prüfen.
- Kernablauf extern testen, bevor die Inhaltsmenge erweitert wird.
- Kein Testframework und kein CI-Dienst ohne konkreten Nutzen.

## Risiken und Gegenmaßnahmen

| Risiko | Auswirkung | Gegenmaßnahme |
| --- | --- | --- |
| Zu großer erster Ausschnitt | Kernschleife wird spät spielbar | Erst eine Pflanze, ein Rezept und ein Auftrag |
| Uneinheitliche KI-Bilder | Kachel- und Figurenstil passt nicht zusammen | Stilreferenz fixieren; Assets im echten Spielmaßstab prüfen |
| Zu frühe Automatisierung | Komplexität ohne validierten Spielspaß | Nach UX-001 neu bewerten |
| Veraltete Godot-Hinweise | API-/Editoranweisungen passen nicht zur Version | Versionierte /en/4.7/-Dokumentation verwenden |
| Eigenständiges Spielrepo | Spätere Zusammenführung mit anderen Repos braucht eine Migration | Moor-Apotheke als eigenes Projekt weiterentwickeln |
| Ungenaue generierte Pixelgrafik | Raster, Transparenz oder Kachelanschluss passen nicht | PNGs im Spiel prüfen und gezielt nacharbeiten |

## Skills, Agents und Wissensquellen
- Verwendet: ECC git-workflow, architecture-decision-records und documentation-lookup; Bildarbeit über den verfügbaren imagegen-Skill.
- Ein unabhängiger Planreview-Agent hat den ersten Slice verkleinert und Abnahmefragen hervorgehoben; der Dateistand wurde danach erneut geprüft.
- Ein eigenes Skillpaket wird vorerst nicht angelegt: AGENTS.md deckt die wenigen wiederkehrenden Regeln ab. Bei stabiler Asset- oder Featurearbeit erneut prüfen.
- Die RAG-Quellenstrategie steht in docs/KNOWLEDGE_BASE.md. Ein Vektorserver ist für den kleinen Quellenbestand nicht gerechtfertigt.

## Änderungsprotokoll
| Datum | Änderung |
| --- | --- |
| 30.09.2026 | Projektgrundlage und Roadmap angelegt; erster Slice auf eine Kräuter-zu-Auftrag-Schleife fokussiert. |
| 01.10.2026 | REL-001: Windows-x86_64-Exportprofil, passende lokale Vorlagen, Exportdokumentation und Release-Checkliste ergänzt. |
| 30.09.2026 | CORE-001: Graybox-Moorfläche, Hindernisse, Spielerbewegung und Kamera ergänzt; Headless-Prüfung bestanden. |
| 30.09.2026 | GitHub-Ziel auf das eigenständige Repo Fremarx/Moor-Apotheke umgestellt. |
| 30.09.2026 | Repository auf GitHub veröffentlicht; lokale Maschinenpfade aus der Entwicklungsdoku entfernt. |
| 30.09.2026 | CORE-002: generische Interaktion, E-Taste, nächstes Ziel und HUD-Rückmeldung ergänzt; Headless-Prüfungen bestanden. |
| 30.09.2026 | ITEM-001: Sumpfminze-Sammelstelle, einmalige Aufnahme, Inventar und HUD-Zähler ergänzt; Headless-Prüfungen bestanden. |
| 30.09.2026 | LOOP-001: Trockengestell, atomare 1:1-Inventarverarbeitung und zweiter HUD-Zähler ergänzt; Headless-, Import- und Laufzeitprüfungen bestanden. |
| 30.09.2026 | LOOP-002: Braukessel, Beruhigungstee und vollständige Sumpfminze-zu-Tee-Schleife ergänzt; Headless-, Import- und Laufzeitprüfungen bestanden. |
| 30.09.2026 | QUEST-001: Fenjas Auftrag, Laufzeitstatus, Teeabgabe und Abschluss-HUD ergänzt; Feature- und Regressionstests bestanden. |
| 30.09.2026 | UX-001: Quest-HUD leitet durch Sammeln, Trocknen, Brauen und Abgabe; End-to-End- und Regressionstests bestanden. |
| 30.09.2026 | CONTENT-001a: Schilfwurzel als eigene Sammelpflanze samt Inventar-/HUD-Zähler ergänzt; Headless-Test zuerst rot und nach Implementierung grün. |
| 30.09.2026 | LOOP-003: Schilfwurzel im Trockengestell verarbeitet, frischen und getrockneten HUD-Zähler ergänzt; Headless-Test zuerst rot und danach grün. |
| 30.09.2026 | LOOP-004: zweites Rezept als Resource ergänzt, Freischaltung an Fenjas Abschluss gebunden und atomare Mehrzutatenverarbeitung samt HUD umgesetzt; Headless-Test rot/grün. |
| 30.09.2026 | QUEST-002: Martens Folgeauftrag, genau-ein-Aufguss-Abgabe und HUD-Führung ergänzt; Headless-Test rot/grün, Regressionen, Editorimport und Startcheck bestanden. |
| 30.09.2026 | CONTENT-001b: Nachtmoos am schattigen Torfsteg als eigenes Pickup mit Inventar-ID und HUD-Zähler ergänzt; Headless-Test rot/grün und Regressionen bestanden. |
| 30.09.2026 | LOOP-005: Nachtmoos als dritte Zutat am Trockengestell verarbeitet, eigener HUD-Zähler ergänzt; Featuretest rot/grün, alle zwölf Headless-Tests, Editorimport und Startcheck bestanden. |
| 30.09.2026 | LOOP-006: Nachttrank-Rezept an Martens Abschluss gebunden, atomare Mehrzutatenverarbeitung und eigener HUD-Zähler ergänzt; Featuretest rot/grün, alle dreizehn Headless-Tests, Editorimport und Startcheck bestanden. |
| 30.09.2026 | QUEST-003: Lenes Folgeauftrag, HUD-Führung durch beide Zutatenketten und genau-ein-Nachttrank-Abgabe ergänzt; Featuretest rot/grün, alle vierzehn Headless-Tests, Editorimport und Startcheck bestanden. |
| 30.09.2026 | BOARD-001: Auftragsbrett mit Statusanzeige und Verfügbarkeitsregeln ergänzt; Annahme dorthin verlegt, direkte NPC-Abgabe erhalten; 15 Headless-Tests, Editorimport und Startcheck bestanden. |
| 30.09.2026 | ECON-001: einmalige Questbelohnungen von 5/10/15 Münzen und HUD-Zähler ergänzt; neuer Headless-Test rot/grün, alle 16 Tests, Editorimport und 60-Frame-Startlauf bestanden. |
| 01.10.2026 | SAVE-001: versionierter JSON-Spielstand mit F5/F9, automatischem Laden, Positions-, Inventar-, Quest- und Pickup-Persistenz ergänzt; ungültige Spielstände werden vor Anwendung verworfen. Featuretest rot/grün; alle 17 Headless-Tests, Editorimport und 60-Frame-Startlauf bestanden. |
| 01.10.2026 | EXP-001: visuellen Ausbau vor neuen Gebieten, Jahreszeiten und Automatisierung priorisiert; VIS-001 gestaltet zuerst ein spielbares Moorsegment und beinhaltet die noch offene sichtbare Spielprüfung. |
| 01.10.2026 | VIS-001: warmes Moorsegment mit strukturierterem Boden, Torfweg, Teichufer und transparentem 4 × 4-Dekorationsatlas integriert; alle 17 vorhandenen Tests, Editorimport, 60-Frame-Start und gerenderte Hauptszene geprüft. |
| 01.10.2026 | VIS-002: Spielerentwurf als transparenten 2 × 2-Richtungsatlas integriert; Tasche und Minzblatt perspektivisch konsistent; 18 Tests, Editorimport, 60-Frame-Start und Spielbild geprüft. |
| 01.10.2026 | VIS-003: Stationen, Bewohner und Sammelpflanzen als drei transparente 3-Zellen-Atlanten integriert; 19 Tests, Godot-Import, 60-Frame-Start und Hauptszene bei 480 × 270 geprüft. |
| 01.10.2026 | REL-001: Windows-x86_64-Exportprofil, passende lokale Vorlagen, Exportdokumentation und Release-Checkliste ergänzt. |
| 01.10.2026 | PLAY-001: HUD-Kontrast im Moor-Stil verbessert; vier Bewegungsrichtungen, Fels-/Teich-/Randkollisionen und 480 × 270-Spielansicht geprüft. |
| 01.10.2026 | INV-001: Kräuter- und Heilmittelbestände in ein kategorisiertes Modal mit I/Escape und Live-Zählern verlagert; Spielersteuerung pausiert; Regressionen, Editorimport und Startlauf geprüft. |
| 01.10.2026 | PLAYTEST-001: Fenjas komplette Kernschleife und Inventar im 480 × 270 Godot-Viewport geprüft; Ressourcen-Audit zeigt zu wenig Sumpfminze und Schilfwurzel für die Folgeaufträge. |
| 01.10.2026 | RESOURCE-001: Je eine zweite Minz- und Wurzelstelle ergänzt; komplette Questkette mit 30 Münzen, fünf eindeutigen Pickup-IDs, Save-/Load-Prüfung, 22 Headless-Tests, Import und Startcheck abgeschlossen. |
| 01.10.2026 | AREA-001: Begehbares Schilfufer mit Hin- und Rückweg sowie drei erreichbaren Sammelstellen ergänzt; zweite Kartenhälfte und geerntete Pflanzen werden gespeichert. AREA-Test rot/grün, alle 23 Headless-Tests, Editorimport und 60-Frame-Start bestanden. |
| 01.10.2026 | MAP-01: Neue Weltentwurfsdateien übernommen; Dorfplatz mit Apotheke, Auftragsbrett, Brunnen und sichtbaren Nord-/Ostwegen gestaltet. Trockengestell unterhalb der Brunnenkollision platziert. MAP-01- und vollständiger Drei-Aufträge-Test bestanden; Rendererbild bei 480 × 270 geprüft. |
| 01.10.2026 | MAP-02: Fünf Dorfwege samt NW-Schilfuferübergang, NE-Holzsteg und vier beschilderten, physisch gesperrten Zukunftswegen umgesetzt. AREA-001-Rückweg und Questkette bestehen; MAP-02 prüft Route und Sperren. |
| 01.10.2026 | MAP-03: Gemeinsamen 16×16-Mooratlas und kollisionsfreie Grundkachelebene für Dorfplatz und Schilfufer ergänzt; 26 Headless-Tests, Import, Start-Smoke und beide gerenderten Kartenansichten bestanden. |
| 01.10.2026 | VIS-004: Reich schattiertes Apothekenhaus und passende Schilf-/Moosgruppen integriert; Headless-MainLoop der 27 Testskripte repariert, alle 27 Tests, Editorimport, Start-Smoke und zwei Rendererbilder geprüft. Haus, Kräuter und Figuren bei 480 × 270 verglichen. |
| 01.10.2026 | VIS-005: Einheitlichen 8×8-Moorbodentexturatlas erstellt, 16 ruhige Moos-/Grasvarianten deterministisch auf beiden Gebieten verteilt und alte flache Bodenkleckse entfernt; Wege mit dezenten Torf- und Kieseldetails ergänzt. Alle 27 Tests, Editorimport, Start-Smoke und Dorfplatz-/Schilfufer-Viewport bei 480 × 270 geprüft. |
| 01.10.2026 | SCALE-01: Fünf 5×4-Gebietsraster mit 4×3-Mindestkernen, Routen, Ressourcenpatches, Landmarken, optionalen Begegnungen und Geheimnissen geplant; Flächenmessung und Blindtestkriterien für REG-01 bis REG-05 festgelegt. Keine Runtime-Änderung; Godot-Tests nicht ausgeführt. |
| 01.10.2026 | REG-01: Schilfufer auf 150×68 Kacheln mit mindestens 6.120 begehbaren Kacheln ausgebaut; sechs Kräutergruppen, sicherer Umweg, dauerhaft senkbarer Fährensteg, dreistufiges Marksteinrätsel, verborgene Mooslichtung und verlustfrei vertreibbarer Schnapper. Alle 27 Headless-Tests, Import und Start-Smoke bestehen; blinder Ersterkundungstest bleibt vor Veröffentlichung offen. |
| 01.10.2026 | SYS-01: Gebietsdaten und 18 stabile Fundstellen-IDs ergänzt; Pflanzen und optionale Begegnungen kehren bei Dorfbesuch zurück. Das Basis-Kräuterbuch protokolliert Entdeckungen. Version-1-Save-Kompatibilität, vollständiger Headless-Testlauf, Editorimport und 60-Frame-Start-Smoke geprüft. |
| 01.10.2026 | MAP-04: Dorfplatz von 640 × 360 auf 640 × 544 Pixel erweitert, drei Cottage-Sprites mit Hofdetails ergänzt und Pflaster/Wege sichtbar ausgearbeitet. Übergangskoordinaten blieben stabil; 30 Headless-Tests, Editorimport, 60-Frame-Start und zwei Dorfausschnitte bei 480 × 270 bestanden. |
| 01.10.2026 | SYS-02: Warnlinien, Ausweichschritt, Kräuterstab, Herzen und sichere Wegpunkte umgesetzt; alle 31 Headless-Tests, Godot-4.7.2-Import und 60-Frame-Start bestanden. |
