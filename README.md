# Semestrální projekt z předmětu Informatika na UNOB

## Project Goals
This is a project for the Informatics subject at the University of Defence.

## Installation
To install the game, follow these steps:
1. Download the binaries from the [releases page](https://github.com/Blacki005/informatika_projekt/releases).
2. Extract the downloaded files to your preferred location.
3. Run the executable to start the game.

The game is also playable online at my [GitHub hosted page](https://blacki005.github.io/bigohra.html).

## Usage
### Controls
- **ESC**: Skip dialogue
- **I**: Show/hide inventory
- **SPACE**: Salute
- **TAB**: Pause the game
- **E**: Interact with objects

## Scripts

### JSON_data.gd
- **Functionality**: This script is responsible for loading item data from a JSON file into a dictionary. It includes a function `LoadData` that reads and parses the JSON file, storing its content in a dictionary.

### character_chooser.gd
- **Functionality**: This script handles character selection. When a character button is pressed, it updates the global character variable and changes the scene to the main menu.

### enemy.gd
- **Functionality**: This script manages enemy behavior. It uses a timer to detect when a player enters an area and checks if the player salutes. If the player does not salute in time, the player's health decreases, and a dialogue bubble is shown.

### globals.gd
- **Functionality**: This extensive script serves as a hub for global variables and functions that are used across the game's NPCs, quests, and player stats. It includes functions for saving and loading game data, managing player stats, and resetting global variables. It also manages quest completion statuses, inventory items, and player positions. The script handles saving game data differently for Windows and Linux, ensuring compatibility with file system conventions on both operating systems. Additionally, it provides a function to handle player death, resetting all necessary variables and states.

### interaction_area.gd
- **Functionality**: This script defines an interaction area. It registers and unregisters the interaction area with the InteractionManager when a body enters or exits the area.

### interaction_manager.gd
- **Functionality**: This script manages interactions within the game. It keeps track of interactive areas and displays interaction labels based on the player's proximity to these areas. It also handles player input for interactions.

### inventory.gd
- **Functionality**: This script manages the player's inventory. It includes functionality for initializing the inventory, handling mouse input on inventory slots, and managing item movement and interactions within the inventory.

### item.gd
- **Functionality**: This script manages individual items in the game. It includes functions for setting item properties, updating item quantity, and displaying item information.

## Contributing
The project could use better graphics and any help is welcome. Feel free to submit pull requests or open issues with suggestions.

## License
This project is licensed under the Creative Commons Zero (CC0) license, which means it is free for public use.

## Authors
- The game uses the DialogueNodes addon by Nagi: [DialogueNodes](https://github.com/nagidev/DialogueNodes)
- The graphics were created using the Krita editor: [Krita](https://krita.org/en/)
