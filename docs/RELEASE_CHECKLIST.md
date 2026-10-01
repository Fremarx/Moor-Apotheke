# Release-Checkliste

Stand: 01.10.2026. Diese Liste bereitet den ersten Windows-Testbuild vor; sie bestätigt keine öffentliche Release-Freigabe.

## Gewähltes Exportziel
- Plattform: Windows Desktop x86_64.
- Engine: Godot 4.7.2 Standard; die installierten Exportvorlagen müssen exakt dieselbe Version haben.
- Exportprofil: Windows Desktop in export_presets.cfg.
- Zielpfad: build/windows/Moor-Apotheke.exe; generierte Builds bleiben von Git ausgeschlossen.
- Erstes Zielsystem wurde anhand der vorhandenen Windows-Entwicklungsumgebung gewählt. macOS, Linux, Web und Mobile sind noch nicht festgelegt.

## Vor jedem Testbuild
- [ ] Godot 4.7.2 Standard und passende Windows-Exportvorlagen verwenden.
- [ ] Editorimport und alle Headless-Tests ausführen.
- [ ] Release-Export mit dem versionierten Profil erstellen.
- [ ] Exportierte EXE starten und Hauptszene, Eingaben, Speichern und Laden prüfen.
- [ ] Den Build auf einem sauberen Windows-System ohne Editorinstallation prüfen.
- [ ] Fenstergröße, Seitenverhältnis, Pixelkanten und Textlesbarkeit im exportierten Spiel prüfen.
- [ ] Buildversion und Änderungsnotizen festhalten.

## Vor einer öffentlichen Veröffentlichung
- [ ] Spielname, App-Icon, Versionsnummer und Produktmetadaten finalisieren.
- [ ] Urheberrecht und Lizenz für Quellcode, Musik, Schriftarten, Grafik und sonstige Drittanbieterinhalte dokumentieren.
- [ ] Godot-Lizenzhinweise und erforderliche Hinweise für eingebundene Inhalte beilegen.
- [ ] Festhalten, welche Bilder selbst erstellt, mit KI erzeugt oder extern lizenziert wurden; Rechte für Veröffentlichung bestätigen.
- [ ] Über ein Codesignaturzertifikat und den Umgang mit Windows-SmartScreen-Hinweisen entscheiden.
- [ ] Signatur-Credentials ausschließlich lokal beziehungsweise in einem sicheren Veröffentlichungsdienst speichern; nie committen. Godot hält lokale Export-Credentials in .godot/export_credentials.cfg.
- [ ] Veröffentlichungsdatei, SHA-256-Prüfsumme, Versionsnummer und Archivkopie des Builds sichern.
- [ ] Verteilungsweg, Release-Text und Rückfall auf den vorherigen Build festlegen.
- [ ] Öffentlichen Upload erst nach ausdrücklicher Freigabe durchführen.

## Aktueller Status
- Windows-x86_64-Exportprofil ist eingerichtet.
- Godot-4.7.2-Windows-Vorlagen für Debug- und Release-Export sind auf der aktuellen Entwicklungsmaschine installiert.
- Release-EXE wurde erfolgreich erstellt und mit einem 60-Frame-Headless-Start geprüft.
- Der Testbuild ist nicht digital signiert. Eine öffentliche Veröffentlichung wurde nicht durchgeführt.
- Die manuelle Sichtprüfung der Steuerung, Kollisionen und HUD-Führung im sichtbaren Spiel steht noch aus.
