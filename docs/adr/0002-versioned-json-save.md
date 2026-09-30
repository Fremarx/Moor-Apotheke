# ADR-0002: Versioniertes JSON für lokale Spielstände

**Datum:** 2026-10-01
**Status:** accepted
**Entscheider:** Projektverantwortliche

## Kontext
Der spielbare Ausschnitt muss Position, Inventar, Münzen, Bewohneraufträge und abgeerntete Pflanzen zwischen Spielsitzungen behalten. Der Zustand besteht aus wenigen Zahlen, stabilen IDs und Questzuständen. Geladene Daten dürfen den aktuellen Lauf nur ändern, wenn der vollständige Spielstand gültig ist.

## Entscheidung
- `SaveManager` speichert JSON-Dateien mit Formatversion 1 nach `user://moor_apotheke_save.json`.
- Main serialisiert Position als x/y, Inventar als Item-ID/Mengenpaare, Bewohneraufträge als Zustandsstrings sowie geerntete Pflanzen als stabile `pickup_id`-Liste.
- F5 speichert, F9 lädt und beim Start wird ein gültiger Spielstand automatisch geladen.
- Das vollständige Format wird vor jeder Zustandsänderung validiert. Beschädigte Daten, unbekannte IDs und nicht unterstützte Versionen werden verworfen; F9 zeigt eine Rückmeldung.
- Bei einer inkompatiblen künftigen Formatänderung wird die Versionsnummer erhöht und ein separates Migrationsverhalten festgelegt.

## Betrachtete Alternativen
### Godot-Resource-Binärformat
- Vorteile: Engine-Objekte und komplexe Daten lassen sich direkt serialisieren.
- Nachteile: Für die kleine, explizite Zustandsmenge unnötig eng an Engine-Ressourcen gebunden und weniger leicht prüfbar.

### ConfigFile
- Vorteile: Einfaches eingebautes Format für Schlüssel und Werte.
- Nachteile: Verschachtelte Quest-/Pickup-Daten lassen sich in JSON direkter und mit einer einzelnen typisierten Validierungsroutine abbilden.

## Folgen
### Positiv
- Der Spielstand ist klein, lokal und lesbar; Engine-Objekte werden nicht direkt gespeichert.
- Typen, zulässige IDs und Questabhängigkeiten lassen sich vor dem Anwenden prüfen.
- Ein einzelner versionierter Datensatz reicht für den derzeitigen Einzelspielerumfang.

### Negativ / Risiken
- Änderungen an Item-IDs oder Savefeldern erfordern eine Versionsentscheidung und bei Bedarf eine Migration.
- Das Format bildet nur den aktuellen Einzelspielerfortschritt ab; mehrere Slots sind nicht Teil dieses Backlogpunkts.

### Rücknahme oder Migration
Das Format ist vor einer größeren Veröffentlichung änderbar. Bestehende Spielstände müssen dann über ihre Versionsnummer migriert oder als nicht unterstützt abgelehnt werden; ein stilles Teil-Laden ist ausgeschlossen.
