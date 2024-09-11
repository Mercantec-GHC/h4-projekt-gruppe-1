# Guide: Sådan kører du Flutter-projektet fra GitHub

## Trin 1: Installer Flutter SDK

1. **Download Flutter SDK** fra [flutter.dev](https://flutter.dev/docs/get-started/install).
2. Følg installationsvejledningen for dit operativsystem, og sørg for, at Flutter er tilføjet til din `PATH`.
3. Kør følgende kommando for at sikre, at alt er korrekt installeret:

    ```bash
    flutter doctor
    ```

4. Løs eventuelle problemer, som `flutter doctor` rapporterer, før du går videre.

## Trin 2: Installer Android Studio eller Visual Studio Code

- **Android Studio** bruges til at installere Android SDK og oprette Android-emulatorer.
- **Visual Studio Code** kan bruges som editor. Installer **Flutter**- og **Dart**-udvidelserne, hvis du bruger denne editor.

## Trin 3: Klon projektet fra GitHub

1. Åbn terminalen, og klon projektet fra GitHub:

    ```bash
    git clone https://github.com/Mercantec-GHC/h4-projekt-gruppe-1-1.git
    ```

2. Gå ind i projektmappen:

    ```bash
    cd h4-projekt-gruppe-1-1
    ```

## Trin 4: Installer projektets afhængigheder

1. Kør denne kommando for at hente alle nødvendige Flutter-pakker og afhængigheder:

    ```bash
    flutter pub get
    ```

## Trin 5: Kør projektet på en emulator eller fysisk enhed

### For Android:

1. Opret og start en Android-emulator i **Android Studio**:
   - Gå til **AVD Manager**.
   - Opret en ny emulator med en valgfri Android-version, og start den.

2. Kør projektet:

    ```bash
    flutter run
    ```

### For iOS:

1. Åbn Xcode, og kør en iOS-simulator.
2. Kør projektet med:

    ```bash
    flutter run
    ```

### For fysisk enhed (Android/iOS):

1. **Android**: Tilslut enheden via USB, aktiver **USB-fejlfinding**, og kør:

    ```bash
    flutter run
    ```

2. **iOS**: Tilslut din iPhone via USB, åbn projektet i Xcode, og kør derfra.

## Trin 6: Fejlretning og Hot Reload

- Når projektet kører, kan du bruge **Hot Reload** ved at trykke `r` i terminalen.
- Dette vil opdatere appen øjeblikkeligt uden at genstarte den.

## Trin 7: Byg APK eller iOS build

Når du er klar til at bygge projektet til produktion:

- For Android:

    ```bash
    flutter build apk --release
    ```

- For iOS:

    ```bash
    flutter build ios --release
    ```

Bemærk: iOS-bygninger kræver en Mac og de nødvendige certifikater til app-underskrift.

## Yderligere hjælp

Hvis du støder på problemer undervejs, kan du altid køre:

```bash
flutter doctor
```

