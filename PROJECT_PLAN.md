# Die Moor-Apotheke – Projektplan

Stand: 01.10.2026

## Project Status

### Aktuelle Phase
Phase 7 – Persistenz und Ausbau

### Zuletzt bearbeiteter Task
VIS-001 – Die Moor-Testkarte in einer warmen Pixelart-Richtung gestalten und integrieren.

### Status
CORE-002 DONE; ITEM-001 DONE; LOOP-001 DONE; LOOP-002 DONE; QUEST-001 DONE; UX-001 DONE; CONTENT-001a DONE; LOOP-003 DONE; LOOP-004 DONE; QUEST-002 DONE; CONTENT-001b DONE; LOOP-005 DONE; LOOP-006 DONE; QUEST-003 DONE; BOARD-001 DONE; ECON-001 DONE; SAVE-001 DONE; EXP-001 DONE; VIS-001 DONE.

### Fortschritt
Die Herstellungskette von Fenja über Marten bis Lene ist spielbar; drei Pflanzen werden gesammelt und verarbeitet. Das Auftragsbrett zeigt die Bewohnerbitten und ihre Freischaltung. Erfolgreiche Abgaben zahlen 5, 10 oder 15 Münzen, die direkt im HUD erscheinen. F5 speichert und F9 lädt Position, Inventar, Aufträge und bereits geerntete Pflanzen; vorhandene gültige Spielstände werden beim Start geladen. VIS-001 gestaltet die 640 × 360-Testkarte mit warmen Moosflächen, Torfweg, Teichufer und 4 × 4 Dekorationsatlas sichtbar farbiger. Spiellogik und Kollisionsflächen blieben erhalten.

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

### Als Nächstes
VIS-002 – Den abgestimmten Spielerentwurf mit Tasche und Minze als 4-Wege-Spielfigur integrieren.

### Blocker
Keine technischen Blocker. Das Spiel liegt als eigenes öffentliches Repo `Fremarx/Moor-Apotheke`; abgeschlossene Backlogitems werden auf `codex/moor-apotheke` gepusht. Die manuelle Sichtprüfung von Bewegung und HUD im Godot-Fenster steht noch aus.

### Offene Entscheidungen
- Zielplattformen über Windows-Entwicklung hinaus werden nach dem ersten spielbaren Prototyp festgelegt.
- Umfang späterer Jahreszeiten und Automatisierung wird nach einem Test des Kernablaufs entschieden.
- Der erste visuelle Ausschnitt orientiert sich am warmen Abendmoor; Dämmerungs- und Frühlingsstimmung bleiben Optionen für spätere Gebiete.

### Technische Schulden
- Bewegung und Testkarte sind provisorisch gezeichnet; finaler Grafikstil sowie weitere Pflanzen, Rezepte und Aufträge fehlen noch.
- Echte Tastatureingabe und Kameragefühl wurden noch nicht im sichtbaren Godot-Fenster geprüft.
- Exportvorlagen und Exportprofile werden erst für einen konkreten Build-Zielpunkt ergänzt.

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
- Sichtprüfung von Pflanzen, NPCs, Quest-/Inventar-HUD, Auftragsbrett und realer Tastatureingabe im Godot-Fenster ist noch offen; Headless-Tests bestätigen Logik und Textwechsel, nicht die Verständlichkeit bei neuen Spielenden.

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
| CONTENT-001 | Erweiterter Vertical Slice als kleine, unabhängig prüfbare Inhalte | P2 | UX-001 | IN PROGRESS |
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
| VIS-002 | Den abgestimmten Spielerentwurf mit Tasche und Minze als 4-Wege-Spielfigur integrieren | P1 | VIS-001 | PLANNED |
| REL-001 | Exportziel wählen, Exportvorlagen einrichten, Release-Checkliste ergänzen | P3 | stabile Kernschleife | PLANNED |

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

### VIS-001 Abnahmekriterien – erledigt
- Die 640 × 360-Testkarte zeigt bei 480 × 270 eine abgestimmte warme Moorpalette mit abwechslungsreichem Boden, lesbarem Teichufer und Torfweg.
- Ein transparenter 4 × 4-Dekorationsatlas ergänzt Schilf, Farne, Blüten, Steine und Wasserlilien; die genaue Herkunft und die finalen Prompts stehen in docs/ART_ASSETS.md.
- Bewegungslogik, Interaktionen, Pickup-Positionen und vorhandene Kollisionsrechtecke bleiben unverändert.
- Die tatsächliche Hauptszene wurde in Godot 4.7.2 bei 480 × 270 sichtbar gerendert und geprüft.
- Godot-Editorimport, alle 17 vorhandenen Spiellogiktests und der 60-Frame-Startlauf bestehen.
- Noch offen bleibt der Tastaturtest mit Bewegung und Kollision im laufenden Fenster sowie die subjektive Stilrückmeldung.
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
