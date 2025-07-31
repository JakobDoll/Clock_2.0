# Clock 2.0 - ESPHome Smart Clock

Ein ESP8266-basiertes Smart-Clock-Projekt, das mit Home Assistant integriert werden kann.

## Hardware
- Wemos D1 Mini (ESP8266)
- Optional: I2C-Display, LEDs, Sensoren

## Software-Setup

### Voraussetzungen
- Python 3.8+
- Home Assistant Installation
- VSCode mit installierten Extensions

### Erste Schritte

1. **WiFi-Konfiguration anpassen:**
   - Öffnen Sie `clock.yaml` oder `clock_with_secrets.yaml`
   - Tragen Sie Ihre WiFi-Zugangsdaten ein
   - Bei Verwendung von `clock_with_secrets.yaml`: Bearbeiten Sie `secrets.yaml`

2. **Konfiguration validieren:**
   ```bash
   # In VSCode: Ctrl+Shift+P -> "Tasks: Run Task" -> "ESPHome: Validate Config"
   # Oder Terminal:
   .venv/bin/esphome config clock.yaml
   ```

3. **Firmware kompilieren:**
   ```bash
   # In VSCode: Ctrl+Shift+P -> "Tasks: Run Build Task"
   # Oder Terminal:
   .venv/bin/esphome compile clock.yaml
   ```

4. **Auf ESP8266 hochladen (erstes Mal per USB):**
   ```bash
   # ESP8266 per USB anschließen
   # In VSCode: Ctrl+Shift+P -> "Tasks: Run Task" -> "ESPHome: Upload"
   # Oder Terminal:
   .venv/bin/esphome upload clock.yaml
   ```

5. **Spätere Updates Over-The-Air (OTA):**
   ```bash
   # In VSCode: Ctrl+Shift+P -> "Tasks: Run Task" -> "ESPHome: Upload (OTA)"
   # Oder Terminal:
   .venv/bin/esphome upload clock.yaml --device clock-2-0.local
   ```

### VSCode Tasks
Das Projekt enthält vorgefertigte Tasks für:
- **ESPHome: Validate Config** - Konfiguration prüfen
- **ESPHome: Compile** - Firmware kompilieren
- **ESPHome: Upload** - Per USB hochladen
- **ESPHome: Upload (OTA)** - Over-The-Air Update
- **ESPHome: Logs** - Live-Logs anzeigen
- **ESPHome: Clean Build Files** - Build-Dateien löschen

Zugriff über `Ctrl+Shift+P` -> "Tasks: Run Task"

### Home Assistant Integration

1. Nach dem ersten Upload sollte das Device automatisch in Home Assistant erkannt werden
2. Gehen Sie zu **Einstellungen** > **Geräte & Dienste** > **Integrationen**
3. Das Device "Clock 2.0" sollte zur Konfiguration bereit sein
4. API-Schlüssel wird automatisch ausgetauscht

### Verfügbare Entitäten

Nach der Integration stehen folgende Entitäten zur Verfügung:
- **Status LED** - Steuerbare LED
- **WiFi Signal** - Signalstärke
- **Uptime** - Betriebszeit
- **IP Address** - Aktuelle IP-Adresse
- **Connected SSID** - Verbundenes WiFi-Netzwerk
- **ESPHome Version** - Firmware-Version
- **Restart Button** - Neustart-Button

### Zeitsynchronisation

Das Device synchronisiert automatisch die Zeit mit Home Assistant. Die aktuelle Zeit wird geloggt und kann in benutzerdefinierten Komponenten verwendet werden.

### Erweiterte Konfiguration

#### Zusätzliche Sensoren hinzufügen:
```yaml
sensor:
  - platform: dht
    pin: D4
    temperature:
      name: "Temperature"
    humidity:
      name: "Humidity"
    update_interval: 60s
```

#### Display anschließen (I2C):
```yaml
display:
  - platform: ssd1306_i2c
    model: "SSD1306 128x64"
    address: 0x3C
    lambda: |-
      it.strftime(0, 0, id(font), "%H:%M:%S", id(homeassistant_time).now());

font:
  - file: "arial.ttf"
    id: font
    size: 20
```

### Debugging

Logs in Echtzeit anzeigen:
```bash
# In VSCode: Task "ESPHome: Logs"
# Oder Terminal:
.venv/bin/esphome logs clock.yaml
```

### Troubleshooting

1. **Device wird nicht erkannt:**
   - USB-Treiber für CP2102/CH340 installieren
   - Richtigen COM-Port auswählen

2. **WiFi-Verbindung fehlschlägt:**
   - SSID und Passwort in `clock.yaml` überprüfen
   - 2.4GHz WiFi verwenden (5GHz wird nicht unterstützt)

3. **OTA-Updates schlagen fehl:**
   - Device muss im gleichen Netzwerk sein
   - mDNS muss funktionieren (`clock-2-0.local` erreichbar)

## Dateien

- `clock.yaml` - Haupt-ESPHome-Konfiguration
- `clock_with_secrets.yaml` - Konfiguration mit Secrets-Datei
- `secrets.yaml` - Vertrauliche Daten (nicht in Git)
- `requirements.txt` - Python-Abhängigkeiten
- `.vscode/tasks.json` - VSCode-Tasks
- `.vscode/settings.json` - VSCode-Einstellungen
