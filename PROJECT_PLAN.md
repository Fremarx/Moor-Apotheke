# Die Moor-Apotheke – Projektplan

Stand: 30.09.2026

## Project Status

### Aktuelle Phase
Phase 6 – Inhaltserweiterung

### Zuletzt bearbeiteter Task
CONTENT-001a – Schilfwurzel sammeln und eigenen HUD-Bestand anzeigen.

### Status
CORE-002 DONE; ITEM-001 DONE; LOOP-001 DONE; LOOP-002 DONE; QUEST-001 DONE; UX-001 DONE; CONTENT-001a DONE.

### Fortschritt
Die erste Herstellungskette und Fenjas Auftrag sind spielbar. Sumpfminze und Schilfwurzel lassen sich getrennt sammeln und zählen; die weiteren Inhalte werden als kleine, einzeln prüfbare Schritte ergänzt.

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

### Als Nächstes
LOOP-003 – Schilfwurzel am Trockengestell verarbeiten und als getrocknete Zutat anzeigen.

### Blocker
Keine technischen Blocker. Das Spiel liegt als eigenes öffentliches Repo `Fremarx/Moor-Apotheke`; abgeschlossene Backlogitems werden auf `codex/moor-apotheke` gepusht. Die manuelle Sichtprüfung von Bewegung und HUD im Godot-Fenster steht noch aus.

### Offene Entscheidungen
- Zielplattformen über Windows-Entwicklung hinaus werden nach dem ersten spielbaren Prototyp festgelegt.
- Umfang späterer Jahreszeiten und Automatisierung wird nach einem Test des Kernablaufs entschieden.
- Finale Pixelart wird erst nach Sichtung eines Spielbild-Mockups produziert.

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
- Sichtprüfung von Fenja, Quest-HUD und realer Tastatureingabe im Godot-Fenster ist noch offen; die Tests bestätigen Textwechsel, nicht die Verständlichkeit bei neuen Spielenden.

### Sicherheitsstatus
Kleines lokales Einzelspielerprojekt ohne Konto, Netzwerkdienst oder personenbezogene Nutzerdaten. Für spätere Spielstände gilt: nur benötigte Daten in user:// speichern und geladene Werte validieren. Fremde Add-ons und Assets vor Übernahme prüfen; Zugangsdaten gehören nicht ins Repository.

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
- Fenja ist die erste Auftraggeberin. Auftrag annehmen und Heilmittel abgeben geschehen zunächst direkt bei ihr; ein Auftragsbrett kommt später.
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
| LOOP-003 | Schilfwurzel am Trockengestell verarbeiten | P2 | CONTENT-001a | PLANNED |
| LOOP-004 | Stärkenden Aufguss aus getrockneter Schilfwurzel und Sumpfminze brauen; nach Fenjas Auftrag freischalten | P2 | LOOP-003, QUEST-001 | PLANNED |
| QUEST-002 | Martens Bitte um einen stärkenden Aufguss annehmen und erfüllen | P2 | LOOP-004 | PLANNED |
| CONTENT-001b | Nachtmoos am schattigen Torfsteg sammeln und im HUD zählen | P2 | QUEST-002 | PLANNED |
| LOOP-005 | Nachtmoos am Trockengestell verarbeiten | P2 | CONTENT-001b | PLANNED |
| LOOP-006 | Nachttrank aus getrockneter Schilfwurzel und Nachtmoos brauen; nach Martens Auftrag freischalten | P2 | LOOP-005, QUEST-002 | PLANNED |
| QUEST-003 | Lenes Bitte um einen Nachttrank annehmen und erfüllen | P2 | LOOP-006 | PLANNED |
| BOARD-001 | Auftragsbrett zum Anzeigen und Annehmen verfügbarer Bewohneraufträge ergänzen | P2 | QUEST-002, QUEST-003 | PLANNED |
| ECON-001 | Einfache Münzbelohnung für erfüllte Aufträge anzeigen und verbuchen | P2 | BOARD-001 | PLANNED |
| SAVE-001 | Position, Inventar und Questfortschritt speichern und laden | P2 | QUEST-001 | PLANNED |
| EXP-001 | Jahreszeiten, weitere Gebiete und Automatisierung nach Spieltest neu priorisieren | P3 | CONTENT-001, SAVE-001 | PLANNED |
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
- Fenja nimmt per E die Bitte um einen Beruhigungstee an und die HUD zeigt das aktive Ziel.
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
- Verarbeitung der Schilfwurzel und die übrigen Pflanzen, Rezepte, Bewohner, Auftragsbrett und Münzen bleiben eigene Folgepunkte.

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
