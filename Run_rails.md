Rails server

### Forudsætninger

1. **Installer Ruby** og **Rails** ved hjælp af [rvm](https://rvm.io/) eller [rbenv](https://github.com/rbenv/rbenv).
2. Installer **Bundler** ved at køre:

    ```bash
    gem install bundler
    ```

### Kørsel af Rails-backend

1. Naviger til mappen for Rails-backenden i projektet:

    ```bash
    cd rails_backend
    ```

2. Installer alle Ruby-gems:

    ```bash
    bundle install
    ```

3. Kør migrationer for at opsætte databasen:

    ```bash
    rails db:migrate
    ```

4. Start Rails-serveren:

    ```bash
    rails server
    ```

5. Rails-serveren kører nu  på `http://localhost:5501`.

---