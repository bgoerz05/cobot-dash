### Launching
Debugging:
1. Open VSCode
2. Open the "cobot_dashboard" folder (should be bookmarked on the PC)
3. Hit F5 or "start debugging" button.
Updating release version (used in demo.launch.py):
1. From VSCode, run `flutter run --release`.
2. Close out of the window when it opens. (The new version will now automatically be run when the demo is launched.)

### General Structure
Inside the `lib` folder there is:
- `main.dart`, which is effectively just an entry point that gets to the home screen.
- `theme.dart`, which should contain all the standard colors for the app.
- The `features` folder, containing the code for anything visible.
- The `services` folder, containing the code for app-wide tools that are generally hidden, primarily the connection to the Cobot itself.

Inside the `features` folder:
- `home.dart`, lays out the panels of the app.
- The `board`,  `clock`, `controls`, and `move_log` folders, containing the code for their corresponding panels.

Each of the panel folders contains:
- A `panel` class, which contains just the visual code for the panel's widget.
- A `bloc` class, which contains the code for listening to events (and/or streams), and responding by emitting a new state.
- A `state` class, containing the state variables for that panel.
- An `event` file, containing a class for each event the panel needs.
- Potentially a `repo` class, a singleton that provides streams to be listened to by blocs. This should be used to handle external data, or when a bloc needs to add an event to another bloc.

Inside the `test` folder:
- Tests are separated instead by the type of class, with a folder for `widget`, and another for `bloc`
- Widget tests should test only what is visible to the user, given a specific state.
- Bloc tests should test that a bloc emits the correct state(s) given the right event/stream value(s).

### Board
The board itself uses a board from the `chessground` package, for which documentation can be found [here](https://pub.dev/packages/chessground). The `fen` argument determines what is currently shown on the board. The `game` argument determines the behavior of the board, primarily how it can be interacted with. Should be set to `null` if moves should not be made from the app.
### Clock
The `getFormattedTime` method converts the `Duration` object to a string useful for display in the clock widget.
### Control Panel
Currently primarily used to interact with other blocs/repos, to the extend of having nothing in its own bloc.
However, its repo is used to connect the web socket service to the various widgets and blocs that use it. 
### Move Log
Currently just a list of the FEN strings of the moves.

---
For any further information, feel free to contact me at bgoerz05@gmail.com