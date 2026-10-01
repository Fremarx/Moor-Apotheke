# Backlog: Welt und Moorgebiete

**Ziel:** Eine gut lesbare Welt mit dem Dorf als Mittelpunkt, fünf eigenständigen Sammelgebieten, passenden Gegnern und sinnvollen Verbesserungen.

**Grundlage:** [Weltentwurf und Karten-Mockup](world_design_plan.md)

**Gegnerdetails:** [Aussehen, Fähigkeiten und Gegenmaßnahmen](enemy_roster.md)

**Langfristiger Ausbau:** [Stufenplan für Gebiete, Rezepte und Verbesserungen](progression_roadmap.md)

**Ressourcen und Verkauf:** [Ressourcen-, Rezept- und Wirtschaftsentwurf](resource_economy.md)

Prioritäten: **P0** = erster spielbarer Ausbau, **P1** = nächste Erweiterung, **P2** = späterer Ausbau. Die Reihenfolge hält die vorhandenen Aufträge, Ressourcen und Rezepte als Einstieg bei.

## Maßstab als feste Vorgabe

### Größen- und Inhaltsvorgaben für SCALE-01

- Die Weltkarte ist eine Übersicht; jedes Gebiet wird als eigenes, großes Areal gebaut.
- Bei der geplanten Ansicht von 480×270 Pixeln mit 16×16-Kacheln entspricht ein Bildschirm etwa 30×17 Kacheln.
- Mindestmaß je Moorgebiet: ungefähr 4×3 Bildschirmansichten begehbarer Raum (etwa 120×51 Kacheln); Zielgröße 5×4 Ansichten. Wasser und leere Dekorationsfläche zählen nicht.
- Jedes Gebiet erhält mindestens drei Teilbereiche, zwei Nebenwege, eine Rundroute oder Abkürzung, drei Landmarken, mehrere Fundstellen und einen optionalen Geheimort.
- Als Mindestinhalt gelten pro Gebiet: eine Gebietsaufgabe, je Ressource mindestens drei Sammelgruppen, drei erkennbare Landmarken, zwei optionale Begegnungsorte, ein Geheimnis oder Nebenziel und eine wieder auffindbare Abkürzung.
- Das Geheimnis oder Nebenziel ist eine kurze Erkundungsaufgabe oder ein versteckter Routenabschnitt, nicht nur ein einzelner Sammelgegenstand.
- Zeitbudget für eine gründliche Ersterkundung: 6–9 Minuten Routen und Landmarken entdecken, 8–12 Minuten lokale Aufgabe und Sammelroute, 3–6 Minuten Begegnung oder Umweltaufgabe sowie 8–13 Minuten optionale Schleife, Geheimnis und Abkürzung. Das ergibt ungefähr 25–40 Minuten; Aktivitäten dürfen sich überschneiden.
- Zeithypothese fürs Gesamtspiel: etwa 3–4 Stunden für den Hauptpfad bei normaler Erkundung und 4–6 Stunden mit Geheimorten und einigen freiwilligen Aufträgen. Die Gebietszeit enthält die örtliche Aufgabe bereits; sie wird nicht doppelt auf die Gesamtzeit gerechnet.
- Spielzeit durch interessante Orte, Sammeln, Aufträge, Gegner, Geheimnisse und spätere Abkürzungen erzeugen; leere Laufstrecken zählen nicht als Inhalt.

**Fertig, wenn:** Die beiden Startareale im ersten großen Spielmeilenstein die Mindestfläche und Inhaltsziele erfüllen; alle drei späteren Areale erfüllen sie vor ihrer Veröffentlichung. Mindestens drei Personen, die das Gebiet noch nicht kennen, spielen jeden fertiggestellten Erstbesuch; Medianzeit, besuchte Teilbereiche und verpasste Orte werden festgehalten. Bei zu kurzer Spielzeit werden Ziele, Routen und Fundorte ergänzt, keine leeren Laufwege. Für den Gesamtumfang werden Hauptpfad und optionale Erkundung getrennt ausgewertet.

## SCALE-01 – Konkrete Flächenaufteilung der fünf Gebiete — P0

**Status: DONE (Gebietslayout und Abnahmemethode geplant).** Die Szenen, TileMaps und Spielinhalte werden in REG-01 bis REG-05 gebaut; dieser Punkt vergrößert noch keine laufende Karte.

### Gemeinsames Sektorraster

Das Raster beschreibt die begehbaren Weg- und Lichtungsbereiche eines Gebiets, nicht dessen vollständige rechteckige TileMap. Norden liegt oben, Spalten A–E laufen von Westen nach Osten, Zeilen 1–4 von Norden nach Süden. Ein Sektor entspricht ungefähr einer 480×270-Ansicht beziehungsweise 30×17 Kacheln zusammenhängender Wege und freier Flächen. Wasser, Felswände, unpassierbare Dekoration und leere Ränder zählen nicht zur Mindestfläche; bei breiten Wasserbecken wird die Kartenbegrenzung so weit vergrößert, dass die begehbare Fläche trotzdem groß genug bleibt.

Der Mindestkern umfasst zwölf Sektoren in einem 4×3-Block: ungefähr 120×51 begehbare 16×16-Kacheln (6.120 Kacheln). Das vollständige Planungsraster ist 5×4 Sektoren: ungefähr 150×68 Kacheln (10.200 Kacheln). Die acht übrigen Sektoren sind ein Ausbauziel, keine Pflicht, um ein Gebiet erstmals zu veröffentlichen. Die Kartenübersicht bleibt eine nicht maßstabsgetreue Wegkarte.

In jedem Raster bezeichnet der wiederholte Buchstabe den vorherrschenden Teilbereich. Fundstellen und Objekte stehen zusätzlich in den Listen; mehrere Einträge im selben Sektor erhalten später eigene Kachelkoordinaten. Alle drei Sammelgruppen je Ressource sind getrennte, wieder auffindbare Patches mit mehreren Einzelpflanzen oder Fundstücken. Gegnerstellen liegen in optionalen Seitentaschen; ein sicherer Hauptweg führt an beiden vorbei.

### 1. Schilfufer

**Zugang:** nordwestlicher Dorfpfad; Eintritt am südöstlichen Rand bei E4. Sicherer Rückweg am selben Übergang, Rastpunkt bei der Uferbank E4.
**Raster:** Kern B–E / Zeilen 2–4; A-Spalte und Zeile 1 erweitern die Uferroute.

~~~text
       A B C D E
  1    F F F L L
  2    F F L L U
  3    S F L U U
  4    S S U U U
~~~

U = Uferwiesen, L = Schilflabyrinth, F = Lichtung an der versunkenen Fähre, S = äußere Schilfschleife. Hauptroute: E4 → D4 → D3 → C3 → C2 → B2. Zwei Nebenwege: vom Labyrinth C2 zur Schnapper-Nische B3 und von den Uferwiesen D3 zur alten Schilfring-Lichtung C4. Der nordwestliche Fährenpfad bleibt ein weiterer, späterer Ausläufer.

- **Drei Landmarken:** verwitterter Weidenbogen E3, dreifacher Schilfring C3, Fährenmast B2.
- **Sammelgruppen:** Sumpfminze bei E4, C3 und B2; Schilfwurzel bei D4, C2 und B3.
- **Optionale Begegnungen:** Schilfschnapper in D2 und seltener Mückenschwarm in E2; beide Nischen haben eine markierte, kampffreie Umgehung.
- **Geheimnis/Nebenziel:** die drei versetzten Marksteine am Schilfring C4 in die richtige Reihenfolge bringen; das öffnet eine kleine, versteckte Kräuterlichtung.
- **Abkürzung:** eine anfangs angehobene Fährenplanke verbindet C2 mit D4. Am Fährenmast B2 wird sie dauerhaft abgesenkt; anschließend ist sie von beiden Seiten nutzbar.
- **Gebietsaufgabe:** Fenjas Einstieg führt zum beschilderten Minz- und Wurzelpatch und zur Herstellung des Beruhigungstees. Die Fährenmarksteine bleiben freiwillig.

### 2. Alter Torfstich

**Zugang:** östlicher Dorfpfad; Eintritt im Westen bei A2. Sicherer Rückweg und Rastpunkt am Werkzeugunterstand A2.
**Raster:** Kern A–D / Zeilen 2–4; Zeile 1 und Spalte E bilden optionale Gruben- und Moorweg-Ausläufer.

~~~text
       A B C D E
  1    T T G M M
  2    T T G G M
  3    G G G M M
  4    T G G M M
~~~

T = Torfhof mit Werkzeugresten, G = verzweigte Grubenstege, M = alter Torfweg und Moosnischen. Hauptroute: A2 → B2 → B3 → C3 → D3 → D4. Zwei Nebenwege führen vom Grubensteg C3 zu einer sicheren Torfherz-Grube A3 und über D2 in eine optionale Moosnische. Der Rückweg bleibt auch ohne Abkürzung vollständig begehbar.

- **Drei Landmarken:** Torfkran A2, gebrochene Wasserpumpe A4, moosbewachsenes Torftor D4.
- **Sammelgruppen:** Nachtmoos bei D2, C3 und D4; Torfherz bei A3, B3 und C4. Torfherz liegt an sicheren Grubenrändern, nie auf einer Pflichtpassage.
- **Optionale Begegnungen:** Moorwühler in C2 und Irrlicht in B4; Bodenwarnung und sichtbare Lücke zeigen den sicheren Bypass.
- **Geheimnis/Nebenziel:** alte Messpfähle entlang B4–C4–D4 verfolgen, um einen verschütteten Arbeitssteg freizulegen.
- **Abkürzung:** der Hebel am Torfkran A2 öffnet einen zurückführenden Steg zwischen A3 und D4. Der Steg bleibt danach offen.
- **Gebietsaufgabe:** Lenes bestehende Nachtmoosbitte führt zum alten Torfweg. Als optionale lokale Aufgabe wird der sichere Rückweg für weitere Kräutersammler markiert.

### 3. Quellsenke

**Zugang:** nordöstlicher Dorfpfad; Eintritt nach Reparatur der Brücke im Südwesten bei A4. Rastpunkt auf der trockenen Uferterrasse A4.
**Raster:** Kern A–D / Zeilen 2–4; Zeile 1 und Spalte E erweitern Wasserfall und Quellgrotte.

~~~text
       A B C D E
  1    W W W Q Q
  2    W W S G G
  3    W S S G G
  4    E U S G G
~~~

W = oberer Wasserfall, S = Seerosenteich und sichere Inselstege, G = Quellgrotte, U = trockene Uferwege. Hauptroute: A4 → B4 → B3 → C3 → C2 → D2. Zwei Nebenwege führen über den Westuferpfad A3 zu einem Aussichtspunkt und von C3 über D3 in eine optionale Grotte. Keine Ressource verlangt Schwimmen, Sprünge oder Kesselwasser aus der Quelle.

- **Drei Landmarken:** Wasserfallkante A2, großer Seerosenkreis C3, Echohalle D2.
- **Sammelgruppen:** Seerosenwurzel bei A3, B4 und C3; Quellperle bei C2, D3 und D4. Jede Quellperle ist eine einzelne seltene Fundstelle; die Erstentdeckung wird unabhängig vom Inventar dauerhaft notiert.
- **Optionale Begegnungen:** Blasenkröte auf der Insel B2 und Quellwächter an einer Nebenbucht C4; beide können auf trockenen Uferwegen umgangen werden.
- **Geheimnis/Nebenziel:** drei kleine Quellrinnen an der Grotte öffnen eine trockene Seitenkammer mit einer kurzen Erkundungsnotiz.
- **Abkürzung:** ein Sperrschieber in D4 verbindet nach dem Öffnen den Grottenbogen D3 mit dem Uferweg B4 und schließt die Rundroute.
- **Gebietsaufgabe:** eine Bitte aus der Quellsenke verbindet Seerosenwurzel mit dem Trittsicheren Sud; der Sperrschieber ist ein optionales Erkundungsziel.

### 4. Nebelhain

**Zugang:** südwestlicher Dorfpfad nach Lenes Nachttrank; Eintritt am nordöstlichen Rand bei E1. Rastpunkt am sichtbaren Weglicht E1.
**Raster:** Kern B–E / Zeilen 1–3; A-Spalte und Zeile 4 bilden zusätzliche Nebelpfade.

~~~text
       A B C D E
  1    S S F F N
  2    S F F F N
  3    N F F N N
  4    N N F N N
~~~

N = äußerer Nebelpfad, F = Flüsterlichtung, S = alter Steinkreis. Hauptroute: E1 → D1 → C1 → C2 → B2 → B1. Zwei Nebenwege führen von E2 in einen äußeren Kräuterpfad und von C2 in eine optionale Lichtung D3. Die Landmarken und der Ausgang bleiben bei Nebel sichtbar; Nebel darf Gegnerwarnungen nicht verdecken.

- **Drei Landmarken:** alter Steinkreis B1, Flüsterlichtung C2, Weglichtbogen E2.
- **Sammelgruppen:** Flüsterpilz bei B2, C3 und D2; Irrlichtstaub bei B1, C2 und D3. Die erste Staubentdeckung wird als Questmarke gespeichert.
- **Optionale Begegnungen:** Nebelkrähe in E3 und Wurzelhocker in B3; beide liegen neben dem Hauptpfad und blockieren keine Landmarke.
- **Geheimnis/Nebenziel:** drei echte Lichtzeichen im Pfad von C1 über D3 bis C3 finden; zusammen zeigen sie den verborgenen Zugang zu einer kleinen Lichtung.
- **Abkürzung:** zwei Wegsteine bei C1 und D3 lassen sich von ihren jeweiligen Seiten aktivieren und öffnen einen kurzen Rückweg zwischen B2 und E2.
- **Gebietsaufgabe:** Lene bittet um Flüsterpilz und eine Meldung zum Irrlichtstaub. Die Meldung erfüllt ihre Forschungsstufe; das Geheimnis ist optional.

### 5. Versunkener Wurzelhain

**Zugang:** südöstlicher Dorfpfad, nachdem je ein Auftrag in Quellsenke und Nebelhain erfüllt sowie Quellperle und Irrlichtstaub entdeckt und Lene gemeldet wurden. Eintritt am nordwestlichen Rand A1. Rastpunkt am Wurzelbogen A1.
**Raster:** Kern A–D / Zeilen 1–3; Zeile 4 und Spalte E erweitern Harzkanäle und die innere Lichtung.

~~~text
       A B C D E
  1    W W H H H
  2    W H H H I
  3    W H I I I
  4    W W H I I
~~~

W = Wurzelrand, H = verzweigte Harzkanäle, I = innere Lichtung. Hauptroute: A1 → B1 → C1 → C2 → C3 → D3. Zwei Nebenwege führen vom Rand B2 in einen ungefährlichen Wurzelbogen und von D3 über E3 in eine optionale Harzbucht.

- **Drei Landmarken:** großer Wurzelbogen A1, warme Harzquelle C2, bernsteinfarbene Baumkrone D3.
- **Sammelgruppen:** Wurzelrinde bei A2, B2 und C3; Harzbeere bei B1, C2 und D3.
- **Optionale Begegnungen:** Rankenläufer in B3 und Bernsteinwächter in D2; die Harzbucht bleibt über den äußeren Steg ohne Kampf erreichbar.
- **Geheimnis/Nebenziel:** drei Harzzeichen in der inneren Lichtung in eine Linie bringen; dahinter liegt ein begehbarer Wurzelhohlraum statt eines einzelnen Schatzgegenstands.
- **Abkürzung:** der vom Gebietsauftrag gelöste Steg führt von B3 direkt zur inneren Lichtung D3 und bleibt permanent geöffnet.
- **Gebietsaufgabe:** Lene lässt die beiden gemeldeten Erstfunde in ihrer regionalen Forschungsnotiz bestätigen; vor Ort wird zusätzlich ein sicherer Pfad durch die Harzkanäle markiert.

### Abnahme und spätere Umsetzung

- Alle fünf Raster besitzen drei zusammenhängende Teilbereiche, eine durchgehende Hauptroute, mindestens zwei freiwillige Nebenwege, eine schließbare Rundroute/Abkürzung, drei Landmarken, sechs Ressourcengruppen für die zwei gebietseigenen Sammelressourcen, zwei umgehbare Begegnungsorte und ein mehrschrittiges Geheimnis oder Nebenziel.
- REG-01 und REG-02 bauen zuerst ihren jeweiligen 4×3-Kern mit dem gesamten oben genannten Mindestinhalt. REG-03 bis REG-05 übernehmen dasselbe Mindestmaß vor Veröffentlichung; die 5×4-Zielraster bleiben die geplante Erweiterungsform.
- Bei der Szenenabnahme zählt nur passierbare 16×16-Terrainfläche. Wasser, unpassierbare Hindernisse, massive Dekoration und leere Ränder werden abgezogen. Falls ein 4×3-Kern dadurch unter 6.120 passierbare Kacheln fällt, wird seine Kartengrenze erweitert; ein nominell 4×3 großes Rechteck genügt dann nicht. 10.200 passierbare Kacheln sind das 5×4-Ziel.
- Jede Region erhält zwei freiwillige Begegnungsstellen mit sicherem Bypass. Keine Gebietsaufgabe, Ressource, Abkürzung oder Geheimnis darf einen Pflichtkampf oder einen noch nicht erworbenen Trank verlangen.
- Vor der Veröffentlichung spielen mindestens drei Personen, die das Gebiet nicht kennen, einen ersten Besuch ohne Hinweise. Festgehalten werden Medianzeit, erreichte Teilbereiche, gefundene Gruppen, Abkürzung/Geheimnis und verpasste Orte. Bei zu kurzer Erkundung kommen Routen, Ziele und Fundorte hinzu; leere Laufstrecken zählen nicht als Verlängerung.
- Zielhypothese bleibt 25–40 Minuten für eine gründliche Ersterkundung je Gebiet. Die örtliche Aufgabe ist in dieser Zeit enthalten. Die bestehenden Gesamtziele von 3–4 Stunden Hauptpfad und 4–6 Stunden mit optionaler Erkundung bleiben Spieltesthypothesen.
- SCALE-01 ändert keine laufende Karte oder Questlogik. REG-01/02 müssen bei der Umsetzung zusätzlich klären, wie Spawnpunkte, Kamera-/Save-Grenzen und regionale Übergänge mit der größeren Fläche zusammenspielen.

## Epic A — Dorfzentrum und Weltkarte

### MAP-01: Dorfplatz als zentralen Orientierungspunkt bauen — P0

**Status: DONE**

- Dorfplatz in die Kartenmitte setzen, Apotheke und Auftragsbrett gut sichtbar machen.
- Startpunkt so platzieren, dass die Figur direkt einen Blick auf mindestens zwei Ausgänge hat.
- Gebäude und Figuren dürfen die Wege zu den Ausgängen nicht verdecken.

**Fertig, wenn:** Dorfplatz, Apotheke, Brett und Startpunkt auf der Karte sofort erkennbar und erreichbar sind.

### MAP-02: Fünf Pfade und Übergänge anlegen — P0

**Status: DONE**

- Sichtbare Pfade vom Dorf zu Schilfufer, Quellsenke, Torfstich, Nebelhain und Wurzelhain bauen.
- Stege und Brücken dort einsetzen, wo Wasser oder tiefer Schlamm Wege unterbrechen.
- Zunächst nur die vorgesehenen Startgebiete öffnen; spätere Wege bleiben sichtbar und zeigen ihren gesperrten Übergang.
- Einen sicheren Rückweg und gut erkennbare Rastpunkte pro Gebiet vorsehen.

**Fertig, wenn:** Jeder Gebietsweg visuell bis zum Ziel verfolgbar ist und gesperrte Wege eindeutig als noch nicht offen erkennbar sind.

### MAP-03: Wiederverwendbares Moor-Kachelset festlegen — P0

**Status: DONE**

Umgesetzt mit einem gemeinsamen 16×16-TileSet und einem 8×8-Atlas für beide Startkarten. Ein ruhiger Basistile füllt das Raster; die bestehenden Pfade und Ufer bleiben zusammenhängend gezeichnet. Sammelpflanzen wurden bei 480×270 geprüft. Details und Quelle stehen in `docs/ART_ASSETS.md` sowie im MAP-03-Abschnitt von `docs/TESTING.md`.

- Gras, Torf, Schlamm, flaches/tiefes Wasser, Ufer, Holzsteg und Weg als Grundkacheln festlegen.
- Kachelübergänge für Ufer, Wegkurven und Brücken so anlegen, dass keine Lücken entstehen.
- Sammelpflanzen und Interaktionsorte mit klaren Silhouetten und zurückhaltendem Leuchteffekt markieren.

**Fertig, wenn:** Die Wege ohne sichtbare Kachelbrüche gebaut werden können und sammelbare Objekte auch bei Spielgröße leicht zu erkennen sind.

## Epic B — Gebiete einzeln gestalten

### REG-01: Schilfufer als Startgebiet — P0

**Status: TECHNISCH UMGESETZT; Blindtest vor Veröffentlichung offen.** Das 5×4-Gebiet hat Einstieg, Rückweg, Mindestfläche, sechs Kräutergruppen, eine dauerhaft freischaltbare Fährenabkürzung, ein dreistufiges Marksteinrätsel und den optionalen, verlustfrei vertreibbaren Schilfschnapper.

- **Lage und Eingang:** nordwestlicher Abzweig direkt vom Dorf.
- **Aufbau:** drei Teilbereiche: Uferwiesen am Eingang, ein verzweigtes Schilflabyrinth und die Lichtung an der versunkenen Fähre. Ein sicherer Hauptrundweg und zwei Nebenwege verbinden die Bereiche. Die zunächst angehobene Fährenplanke verbindet C2 und D4 erst nach Betätigung des Masts dauerhaft; ein Weg um den Teich bleibt offen.
- **Fundstellen:** je drei Gruppen Sumpfminze und Schilfwurzel liegen über alle Teilbereiche verteilt. Die Marksteinfolge in C4 öffnet zusätzlich eine verborgene Nachtmooslichtung; die sichtbaren Kerben zeigen die Reihenfolge eins bis drei.
- **Größe und Erkundung:** passierbare Fläche und Wege nach SCALE-01 sind umgesetzt. 25–40 Minuten und die Entdeckbarkeit von Schleife, Abkürzung und Geheimnis bleiben bis zum blinden Ersterkundungstest mit mindestens drei neuen Spielenden unbestätigte Ziele.
- **Gegner:** Schilfschnapper als einzelner, gut angekündigter Gegner in einer optionalen Seitennische mit sicherem Bypass; Mückenschwarm später als seltene Variante ergänzen.
- **Look:** helles Schilf, olivgrüne Inseln, schlammige Wege und wenige offene Wasserflächen.

**Fertig, wenn:** Beide bestehenden Pflanzen hier gesammelt werden können, der Weg zum Dorf klar bleibt und der Gegner ohne Verlust von Gegenständen umgangen oder vertrieben werden kann.

### REG-02: Alter Torfstich und Torfsteg — P0

**Status: TECHNISCH UMGESETZT; Blindtest vor Veröffentlichung offen.** Die 150×68-Karte hat mehr als 6.120 passierbare Kacheln. Drei Nachtmoos- und drei Torfherzstellen, ein dauerhaft absenkbarer Torfsteg, das dreistufige Messpfahl-Geheimnis, zwei umgehbare Begegnungen und ein sicherer Rückweg sind vorhanden.

- **Lage und Eingang:** östlicher Pfad vom Dorf.
- **Aufbau:** drei Teilbereiche: Torfhof mit Werkzeugresten, verzweigte Grubenstege und der alte Torfweg als Moosgebiet. Mehrere Stegschleifen verbinden sichere und optionale Routen.
- **Fundstellen:** Nachtmoos in mehreren schattigen Nischen am alten Steg; Torfherz an sicheren Grubenrändern und in einer optionalen Seitenroute.
- **Größe und Erkundung:** SCALE-01 erfüllen; Ziel sind 25–40 Minuten, mit mindestens einer Abkürzung, die erst beim Erkunden geöffnet wird.
- **Gegner:** Moorwühler kündigt sein Auftauchen am Boden an; Irrlicht ist die seltene Variante und darf nicht in Sackgassen locken.
- **Look:** Torfbraun, dunkles Wasser, verwittertes Holz und kleine blaugrüne Mooslichter.

**Fertig, wenn:** Nachtmoos wie im bestehenden Spielplan am alten Steg liegt, alle Gruben sicher umgehbar sind und mindestens eine klare Sammelroute zurückführt.

### REG-03: Quellsenke — P1

- **Lage und Eingang:** nordöstlicher Pfad; Brücke wird durch einen Dorfauftrag repariert.
- **Aufbau:** drei Teilbereiche: oberer Wasserfall, ausgedehnter Seerosenteich und Quellgrotte. Uferwege, mehrere Inseln und kurze Stege formen eine Rundroute mit zwei Nebenwegen.
- **Fundstellen:** Seerosenwurzel am Ufer, seltene Quellperle auf einer Insel. Quellwasser bleibt zunächst Dekoration und ersetzt nicht das kostenlose Kesselwasser.
- **Größe und Erkundung:** SCALE-01 erfüllen; Ziel sind 25–40 Minuten, mit Erkundung der Wasserfälle und mindestens einem optionalen Grottenfund.
- **Gegner:** Blasenkröte verlangsamt oder stößt kurz zurück; Quellwächter schützt die seltene Insel-Fundstelle.
- **Look:** klares Türkis, Seerosen, helles Moos und Wasserfälle als Orientierungspunkte.

**Fertig, wenn:** Beide Ressourcen ohne Schwimmen oder unklare Sprünge erreichbar sind und die Inselroute eine sichere Rückkehr erlaubt.

### REG-04: Nebelhain — P1

- **Lage und Eingang:** südwestlicher Weg; wird nach Lenes Nachttrank-Auftrag über einen benannten Storyfortschritt geöffnet.
- **Aufbau:** drei Teilbereiche: äußerer Nebelpfad, Flüsterlichtung und alter Steinkreis. Mehrere Lichtungen und leuchtende Wegzeichen bilden einen verzweigten Rundweg.
- **Fundstellen:** Flüsterpilze auf Lichtungen, Irrlichtstaub nahe bläulichen Lichtern.
- **Größe und Erkundung:** SCALE-01 erfüllen; Ziel sind 25–40 Minuten. Landmarken bleiben trotz Nebel sichtbar; optionale Abzweigungen führen zu Geheimorten.
- **Gegner:** Nebelkrähe greift in sichtbaren Vorbeiflügen an; Wurzelhocker hält kurz fest, ohne den Hauptweg zu blockieren.
- **Look:** dunkles Grün und Nebelblau; Nebel darf Details abdämpfen, aber weder Wegmarkierungen noch Gegnerwarnungen verdecken.

**Fertig, wenn:** Der Ausgang auch bei Nebel erkennbar bleibt, beide Ressourcen unterschiedliche Fundorte haben und der Rundweg nicht in eine Sackgasse führt.

### REG-05: Versunkener Wurzelhain — P2

- **Lage und Eingang:** südöstlicher Weg; öffnet nach einem Auftrag in Quellsenke und Nebelhain sowie den dauerhaft gespeicherten Erstfunden von Quellperle und Irrlichtstaub, über die Lene informiert wird. Das optionale Kräuterbuch ist nicht nötig.
- **Aufbau:** drei Teilbereiche: Wurzelrand, verzweigte Harzkanäle und innere Lichtung. Wurzelbögen rahmen längere Wege statt kleiner Kammern; ein später geöffneter Steg bildet eine Abkürzung.
- **Fundstellen:** Wurzelrinde an freiliegenden Wurzeln, Harzbeere nahe warmer Harzstellen.
- **Größe und Erkundung:** SCALE-01 erfüllen; Ziel sind 25–40 Minuten, mit einem Geheimort und einer optionalen Route an der inneren Lichtung.
- **Gegner:** Rankenläufer greift in einem klar sichtbaren Bereich an; Bernsteinwächter bewacht die innere Lichtung.
- **Look:** dunkles Torfgrün und Holzbraun, warme Bernsteinpunkte als Blickführung.

**Fertig, wenn:** Hauptroute und Abkürzung unterscheidbar sind, Harzstellen nicht mit Gegnern überlagern und ein sicherer Rückweg offen bleibt.

## Epic C — Sammeln, Gegner und Gebietsfortschritt

### SYS-01: Gebietseigene Fundstellen und Nachwachsen — P0

- Jeder Fundstelle eine feste Gebiet- und Ressourcen-ID zuordnen.
- Pro Gebiet mindestens zwei normale Fundstellen und eine seltene Fundstelle anlegen.
- Alle Pflanzen und seltenen Fundstellen bei einer Rückkehr ins Dorf erneuern; vertriebene Gegner kehren dann ebenfalls zurück. Kein Warten auf einen Ingame-Tag.
- Ressourcen und Fundstellen im Kräuterbuch nach Entdeckung sichtbar machen.

**Fertig, wenn:** Jede Ressource eindeutig einem Gebiet zugeordnet ist, gesammelt werden kann und nach einer Rückkehr ins Dorf erneut verfügbar ist.

### RES-01: Ressourcen sinnvoll in Rezepten und Ausbauten verwenden — P0/P1/P2

- Ressourcenorte, Verarbeitungszustand und Verwendungen nach [Ressourcenplan](resource_economy.md) abbilden.
- Frische Pflanzen am Trockengestell verarbeiten; Gebietsmaterial und Gegnerdrops direkt am Kessel nutzen.
- Für jede Gebietspflanze und jeden Gegnertropfen mindestens ein passendes Rezept anlegen.
- Erstfunde von Quellperle und Irrlichtstaub automatisch als dauerhafte Questmarken speichern; Torfherz und ausgewählte Ressourcen zusätzlich für Upgrades nutzen.
- Alle verbrauchten Hauptzutaten wachsen nach oder werden durch Gegner erneut geliefert.

**Fertig, wenn:** Keine Ressource ohne bekannte Verwendung im Inventar liegt und ein Spieler durch Brauen oder Verkaufen keinen Hauptfortschritt blockiert.

### SYS-02: Sichere Begegnungen mit Gegnern — P0

- Gegner kündigen Angriffe klar über Animation, Geräusch oder Bodeneffekt an.
- Ausweichen, Abstand halten oder Laterne/Schutzmittel als einfache Antwort ermöglichen.
- Treffer dürfen keine Zutaten aus dem Inventar löschen.
- Bei Niederlage Rückkehr zum letzten sicheren Wegpunkt; Inventar und Münzen bleiben erhalten.
- Bloßes Vorbeigehen ist sicher und gibt keine Belohnung. Ein mit dem Kräuterstab vertriebener Gegner lässt genau eine passende Gebietszutat fallen.

**Fertig, wenn:** Eine Begegnung ohne Kampfkenntnisse verständlich ist, kein Pflichtgegner einen Auftrag blockiert und ein Fehlschlag keinen Sammelfortschritt löscht.

### ENE-01: Startgegner platzieren — P0

- Schilfschnapper im Schilfufer und Moorwühler im Torfstich umsetzen.
- Beide zuerst einzeln platzieren und Warnung, Reichweite und Erholung festlegen.
- Gegner nicht direkt an Startpunkten, Auftragszielen oder schmalen Brücken platzieren.

**Fertig, wenn:** Beide Gegner lesbar und umgehbar sind und ihre Fundstellen nach einer Begegnung erreichbar bleiben.

### ENE-02: Gebietsvarianten ergänzen — P1/P2

- P1: Mückenschwarm, Irrlicht, Blasenkröte und Quellwächter.
- P1: Nebelkrähe und Wurzelhocker.
- P2: Rankenläufer und Bernsteinwächter.
- Seltene Varianten nur an markanten Orten und mit optionaler Belohnung einsetzen.

**Fertig, wenn:** Jeder Gegner eine eigene erkennbare Bewegung und eine verständliche Gegenmaßnahme hat.

### ENE-03: Gegnerdrops in Trankrezepte einbinden — P0/P1/P2

- Jeder Gegnertyp erhält eine eigene Alchemiezutat, passend zu seinem Gebiet und Aussehen.
- Jede mit dem Kräuterstab abgeschlossene Begegnung liefert eine Einheit dieses Materials; beim Vorbeigehen gibt es keinen Drop. Der Gegner erscheint nach einer Rückkehr ins Dorf erneut.
- Für jeden Drop mindestens ein benanntes Rezept mit einer Gebietspflanze als weiterer Zutat und einem klaren, zeitlich begrenzten Nutzen anlegen.
- P0: Schnapperschleim, Torfpanzerflocke und ihre Rezepte mit den Startgegnern umsetzen.
- P1: Drops und Rezepte für Quellsenke, Nebelhain sowie die seltenen Gegner der frühen Gebiete ergänzen.
- P2: Drops und Rezepte für den versunkenen Wurzelhain und Bernsteinwächter ergänzen.
- Rezepte und benötigte Zutaten im Rezeptbuch anzeigen; kein Hauptauftrag darf einen seltenen Gegnerdrop verlangen.

**Fertig, wenn:** Alle zehn Gegnertypen ein verwendbares Material fallen lassen, für jeden Drop mindestens ein Trankrezept existiert und die Materialien ohne Pflichtkampf oder Gegenstandsverlust gesammelt werden können.

## Epic D — Spielerkampf

### COM-01: Kräuterstab, Ausweichen und Herzen — P0

- Kräuterstab-Angriff in Blickrichtung auf F/Linksklick; die Grundwaffe verbraucht keine Zutaten und hat als Startwert etwa 0,45 Sekunden Erholung zwischen Schlägen.
- Ausweichschritt auf Leertaste; er lässt angekündigte Angriffe passieren und nutzt keine Ausdauerleiste.
- Drei Herzen für den Spieler; ein Treffer kostet ein Herz, etwa 0,8 Sekunden Schutz verhindert direkte Trefferketten (Startwert für den Spieltest).
- Gewöhnliche Gegner werden nach zwei Treffern vertrieben, seltene nach drei; sichtbare Widerstandspunkte zeigen den Fortschritt.
- Bei null Herzen Rückkehr zum letzten sicheren Wegpunkt; Inventar, Münzen und Zutaten bleiben erhalten.
- E bleibt für Weltinteraktionen reserviert; es gibt keine zusätzliche allgemeine Beruhigungsaktion im Kampf.

**Fertig, wenn:** Ein Spieler ohne Tränke jeden frühen Gegner ausweichen und vertreiben kann und Angriffe stets klar angekündigt werden.

### COM-02: Trankgürtel und Kampfmixturen — P1

- Schnellplätze 1 und 2 wählen; Q verwendet den gewählten Trank.
- Heil-, Schutz- und Gebietsmixturen direkt anwenden; geworfene Tränke fliegen in Blickrichtung.
- Nebelbombe unterbricht Gegner in kleinem Umkreis; Harzfang verlangsamt Gegner in einer kurzlebigen Fläche.
- Beruhigungstee stellt ein Herz wieder her.

**Fertig, wenn:** Schnellplätze während des Erkundens ohne Öffnen des Inventars nutzbar sind und keine Kampfmixtur zwingend für den Hauptfortschritt gebraucht wird.

## Epic E — Aufträge und Upgrades

### PROG-01: Wege über Dorfaufträge freischalten — P0

- **Start:** Dorfplatz und Schilfufer sind offen.
- **Nach Fenjas Beruhigungstee:** Alter Torfstich wird geöffnet. Dort liegt das Nachtmoos für Lenes Nachttrank.
- **Nach Martens stärkendem Aufguss:** Quellsenke wird über den reparierten Nordsteg geöffnet.
- **Nach Lenes Nachttrank:** Nebelhain wird über den südwestlichen Pfad geöffnet.
- **Später:** Nach je einem erfüllten Auftrag in Quellsenke und Nebelhain sowie den automatisch gespeicherten Erstfunden von Quellperle und Irrlichtstaub, von denen Lene erfährt, wird der Versunkene Wurzelhain geöffnet. Das optionale Kräuterbuch ist dafür nicht nötig; Questmarken bleiben beim Brauen oder Upgrade-Kauf erhalten.
- Gesperrte Pfade bleiben sichtbar; beim Untersuchen wird die konkrete Bedingung angezeigt.
- Jeder einmal geöffnete Weg bleibt dauerhaft offen.
- Aufträge und Gebietsfreischaltungen verlangen keinen Pflichtkampf.

**Fertig, wenn:** Die Gebiete in dieser Reihenfolge erreichbar sind, Lenes Nachtmoos-Aufgabe erst nach Öffnung des Torfstichs startet und die Karte für jeden gesperrten Weg dessen Bedingung erklärt.

### PROG-02: Pro Gebiet neue Ziele und Belohnungen staffeln — P0/P1/P2

- Jede Freischaltung ergänzt einen Auftrag, neue Sammelmaterialien, mindestens eine Rezeptidee und einen Grund, später zurückzukehren.
- Hauptgebiete werden ausschließlich über benannte Auftrags- und Entdeckungsmarken geöffnet, nie über Münzen, wiederholbare Aufträge oder einen Vertrauenswert.
- Nach einem Gebiet gibt es eine passende Verbesserung für Erkunden, Herstellung oder Kampf.
- Wahlbelohnungen bleiben später kaufbar; keine einzelne Entscheidung sperrt Rezepte oder Gebiete dauerhaft.
- Abschluss eines Gebiets schaltet mindestens eine weitere Abkürzung, Rezeptgruppe oder optionale Fundstelle frei.
- Den Ablauf der fünf Hauptetappen nach [Ausbaupfad](progression_roadmap.md) umsetzen.

**Fertig, wenn:** Jede neue Region einen klaren nächsten Schritt und eine sofort nutzbare Belohnung bietet, ohne neue Sammelmaterialien in einer Sackgasse enden zu lassen.

### UPG-01: Erste Verbesserung als Belohnung — P0

- Nach Fenjas Auftrag kostenlos zwischen Wanderbeutel (+8 Stapelplätze) und Trockengestell II (4 statt 2 Pflanzen pro Arbeitsgang) wählen lassen.
- Verbesserung sofort in Inventar- oder Stationsanzeige sichtbar machen.
- Nicht gewählte Verbesserung später für 12 Münzen und 2 getrocknete Sumpfminzen anbieten.

**Fertig, wenn:** Beide Optionen einen spürbaren, leicht erklärbaren Vorteil geben und die Wahl keinen anderen Fortschritt dauerhaft sperrt.

### UPG-02: Laterne, Sumpfstiefel und Kräuterbuch — P1

- Laterne zeigt seltene Sammelstellen im Umkreis von etwa 6 Kacheln und vertreibt einfache Gegner etwa 3 Sekunden lang.
- Sumpfstiefel senken die Schlamm-Verlangsamung als Startwert von 30 % auf 10 % und öffnen ausgewiesene Flachwasserwege.
- Kräuterbuch notiert entdeckte Ressourcen, bekannte Fundorte und fehlende Rezeptzutaten.
- Erstfunde von Quellperle und Irrlichtstaub bleiben im Aufgabenfortschritt gespeichert, unabhängig davon, ob das optionale Kräuterbuch gekauft wurde oder die Zutaten später verbraucht werden.

**Fertig, wenn:** Jede Verbesserung mindestens einen vorher sichtbaren oder bekannten Spielort sinnvoll verändert.

### UPG-03: Kessel und weitere Herstellungsstufen — P1/P2

- Trockengestell I/II/III verarbeitet 2/4/6 Pflanzen je Arbeitsgang; Verarbeitung hat keine Wartezeit.
- Trockengestell III kostet 22 Münzen und 1 Torfherz; es ist nach Öffnung des Torfstichs verfügbar, wenn Trockengestell II bereits gekauft wurde.
- Braukessel II kostet 35 Münzen, 1 Torfherz und 1 Quellsteinsplitter und braut nach Öffnung des Wurzelhains zwei gleiche Portionen pro Arbeitsgang.
- Kräuterstab-Griff erhöht nach Öffnung des Wurzelhains die Reichweite von etwa 2 auf 3 Kacheln.
- Gebietszutaten schalten zusätzliche Rezepte und Verbesserungen frei.

**Fertig, wenn:** Verbesserungen Klicks oder Laufwege reduzieren oder neue Rezepte ermöglichen, ohne Zeitdruck einzuführen.

### SALE-01: Gebraute Mittel verkaufen und Aufträge erfüllen — P1

- Fertige Tränke am Apothekentresen zum festen Grundpreis verkaufen.
- Einzigartige Geschichten- und Gebietsaufträge zahlen gemäß Vorgabe und geben Vertrauen jeweils einmal. Wiederholbare Aufträge kommen erst im Postgame, zahlen etwa 50 Prozent mehr als der Tresenpreis und geben kein weiteres Vertrauen.
- Münzen und Vertrauen sind optionale Dorffortschritts-Systeme; kein Hauptgebiet und kein Hauptauftrag hängt davon ab.
- Die drei Einführungsaufträge behalten ihre festen Belohnungen.
- Bewohner fragen bevorzugt nach Mitteln, die in ihrem eigenen Gebiet helfen; Aufträge haben keine Frist.
- Zutaten werden im Inventar behalten; ein Verkauf zieht nur das ausgewählte fertige Produkt ab.

**Fertig, wenn:** Der Tresenverkauf eine verlässliche Einnahmequelle ist, Aufträge lohnender sind, Preis und Münzertrag vor dem Verkauf sichtbar sind und Wiederholungen keinen Hauptfortschritt durch Vertrauen öffnen.

### UPG-04: Verbesserungen stufenweise ausbauen — P1/P2

- Jede Stufe erweitert einen bestehenden Nutzen, zum Beispiel mehr Trockenkapazität, eine neue Erkundungshilfe oder eine Abwehraktion mit dem Kräuterstab.
- Neue Stufen werden an passende Gebietsaufträge und Zutaten gebunden, nicht an Gegnergrind.
- Vor dem Kauf werden Kosten und Wirkung angezeigt.

**Fertig, wenn:** Verbesserungen sichtbar aufeinander aufbauen und jede Stufe eine neue Rezeptoption, Abkürzung oder Komfortverbesserung eröffnet.

### POST-01: Freien Ausbau nach der Hauptgeschichte anbieten — P2

- Auftragsbrett um wiederholbare Liefer-, Such- und Vertreibungsaufträge erweitern.
- Keine Fristen, Verderb oder Pflichtkämpfe einführen.
- Zusätzliche Belohnungen: Münzen, wiederverwendbare Alchemiezutaten, kosmetischer Dorfausbau und Rezeptvarianten.
- Optional einzelne Unterbereiche an bestehende Gebiete anbauen; jeder Abschnitt braucht eigene Landmarken, Ressourcen und Ziele.

**Fertig, wenn:** Nach Abschluss der fünf Hauptgebiete weitere sinnvolle Ziele bestehen und alle davon freiwillig bleiben.

## Reihenfolge der Gebietsfreischaltungen

| Schritt | Voraussetzung | Danach zugänglich |
| --- | --- | --- |
| Spielstart | keine | Dorfplatz, Apotheke, Schilfufer |
| 1 | Fenjas Beruhigungstee abgegeben | Alter Torfstich |
| 2 | Martens stärkenden Aufguss abgegeben | Quellsenke |
| 3 | Lenes Nachttrank abgegeben | Nebelhain |
| 4 | Je einen Auftrag in Quellsenke und Nebelhain erfüllt; Quellperle und Irrlichtstaub entdeckt und Lene davon berichtet | Versunkener Wurzelhain |

Die Reihenfolge verhindert, dass ein Auftrag eine noch gesperrte Ressource verlangt: Der Torfstich öffnet vor Lenes Nachtmoos-Aufgabe. Erstfunde werden automatisch vermerkt und bleiben trotz Brauen oder Upgrades gespeichert. Kräuterbuch, Laterne und Sumpfstiefel erleichtern spätere Ausflüge, sind aber keine Zugangsvoraussetzung.

## Empfohlene Reihenfolge für den ersten Ausbau

1. SCALE-01 und MAP-01 bis MAP-03: Maßstab, Dorf, Wege und Grundkacheln.
2. REG-01 und REG-02: Schilfufer und Torfstich mit den bereits geplanten Ressourcen.
3. SYS-01 und SYS-02 sowie ENE-01: Fundstellen und zwei Startgegner.
4. COM-01 und ENE-03: Grundkampf sowie Drops und Trankrezepte der Startgegner.
5. PROG-01 und UPG-01: erster freigeschalteter Pfad und erste Verbesserung.
6. REG-03 und REG-04 samt Gegnern, Zutaten und COM-02.
7. REG-05, Lenes Forschungsnotiz-Auftrag und die letzten optionalen Verbesserungen.
8. PROG-02 und POST-01: zusätzliche Rezepte, Gebietsschleifen und freiwillige Aufgaben nach der Hauptgeschichte.

## Gemeinsame Abnahmekriterien

- Jeder Pfad ist lesbar und verbindet sein Gebiet mit dem Dorf.
- Jedes Gebiet hat eigene Farben, Formen, Ressourcen und Gegner.
- Spieler verlieren bei Gegnerkontakt keine gesammelten Gegenstände.
- Hauptgeschichte bleibt ohne Pflichtkampf, Verkäufe, Münzgrind oder Upgrade-Käufe abschließbar.
- Ein bloß umgangener Gegner lässt keinen Drop fallen; ein vertriebener Gegner lässt genau eine Zutat fallen.
- Die Zeitziele gelten als Spieltest-Hypothesen; jeder erste Besuch braucht konkrete Aufträge, Fundziele und Abkürzungen statt bloßer Fläche.
- Jeder Sammelort bleibt nach dem ersten Besuch erneut interessant.
- Aufträge, neue Wege und Verbesserungen zeigen klar, was als Nächstes erreichbar ist.
- Die Welt bleibt ohne Verderb, knappe Fristen oder Pflichtkämpfe spielbar.
