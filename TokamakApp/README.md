# TokamakApp

1. Install `carton`:

```
brew install swiftwasm/tap/carton
```

If you had `carton` installed before this, make sure you have version 0.12.0 or greater:

```
carton --version
```

2. Create a directory for your project and make it current:

```
mkdir TokamakApp && cd TokamakApp
```

3. Initialize the project from a template with `carton`:

```
carton init --template tokamak
```

4. Build the project and start the development server, `carton dev` can be kept running
   during development:

```
carton dev
```

5. Open [http://127.0.0.1:8080/](http://127.0.0.1:8080/) in your browser to see the app
   running. You can edit the app source code in your favorite editor and save it, `carton`
   will immediately rebuild the app and reload all browser tabs that have the app open.
