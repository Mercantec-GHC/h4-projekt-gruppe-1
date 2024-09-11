GO Server

### Forudsætninger

1. **Installer Go** fra den officielle hjemmeside: [golang.org](https://golang.org/dl/).
2. Sørg for, at Go er korrekt installeret ved at køre:

    ```bash
    go version
    ```

### Kørsel af Go-backend

1. Naviger til mappen for Go-backenden i projektet:

    ```bash
    cd JWT
    ```

2. Hvis projektet bruger eksterne Go-moduler, kør:

    ```bash
    go mod tidy
    ```

3. Start Go-serveren:

    ```bash
    go run main.go
    ```

4. Go-serveren vil typisk køre på `http://localhost:8080`, medmindre andet er angivet i projektet.

---