# Coin List Demo

A demo application for listing and managing cryptocurrency coins. The app follows the VIPER architecture and demonstrates data storage, filtering, and more.

## Demo
| iPhone  | iPad |
| ------------- | ------------- |
| ![Watch The Video](https://github.com/Pratik948/coin_list_demo/blob/main/Demo/Screen%20Recording%202024-12-18%20at%206.04.51%E2%80%AFPM%20Compressed.mov)  |  ![Watch The Video](https://github.com/Pratik948/coin_list_demo/blob/main/Demo/Screen%20Recording%202024-12-18%20at%206.07.13%E2%80%AFPM%20Compressed.mov) |

---

## Table of Contents

1. [Features](#features)
2. [Architecture](#architecture)
3. [Setup and Installation](#setup-and-installation)
4. [Usage](#usage)
5. [Data Storage](#data-storage)
6. [Testing](#testing)
7. [Contact](#contact)
---

## Features

- List and display cryptocurrencies with details (name, symbol, type, etc.).
- Filter coins by:
  - Active
  - Inactive
  - New
  - Coin
  - Token
- Search functionality for coins by name or symbol.
- Persistent data storage using CoreData or JSON files.
- VIPER architecture for clean code separation.
- Unit tests for each component.

---

## Architecture

The project is built using the **VIPER** architecture, which ensures a clean separation of concerns.

- **View**: Handles the UI and user interactions.
- **Interactor**: Contains business logic and manages data.
- **Presenter**: Acts as the middle layer between View and Interactor.
- **Entity**: Defines the data models.
- **Wireframe**: Handles navigation between screens.

---

## Setup and Installation

### Prerequisites

- macOS with **Xcode** installed.
- **Swift** 5.0 or higher.

### Installation Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/coin-list-demo.git
   cd coin_list_demo
2.	Open the project in Xcode:
	 ```bash
    open pratikcoinlistdemo.xcodeproj
3.	Build and run the project:
   - Select the appropriate simulator or device.
   - Press Cmd + R to run the project.

---
## Usage

**Main Features**
1. Coin List
    - Displays a list of cryptocurrencies with their details (name, symbol, etc.).
2. Filter Options
    - Filter coins by their status (Active/Inactive), type (Coin/Token), or newness (New).
3. Search
    - Search for coins by name or symbol using the search bar.

**Persistent Storage**
- All data is saved in the CoreData by default and can be changed to the Documents directory using JSON files.
- Data persists between app launches.

___

## Data Storage

The project supports two types of data storage:
1. File Storage: Simple and lightweight storage for saving and retrieving data in JSON files.
	- The File Storage implementation uses JSON files for saving and retrieving data. It’s a great option for lightweight and simple use cases.
		- Location: Files are stored in the app’s Documents directory.
		- Format: Data is serialized and saved in JSON format using Swift’s Codable.
3. Core Data: A more robust and scalable solution for managing structured data using Apple’s Core Data framework.
   	- For more complex scenarios requiring structured and scalable data management, the project uses Core Data.
		- Persistence: Core Data stores data in a local SQLite database.
		- Entity: The project defines a CoinEntity model to manage cryptocurrency data.
  
If we want to change the data storage mechanism, we can modify the `kDataStorageType` constant to either `.file` or `.coredata` in the `AppStorage.swift` file.
The default `DataStorageType` is `DataStorageType.coredata`.

___

## Testing

The project includes unit tests for all VIPER components:
  - Interactor Tests:
  	- Ensure business logic behaves as expected.
  - Presenter Tests:
  	- Verify interactions between View and Interactor.
  - View Tests:
  	- Simulate user interactions and UI updates.
  - Wireframe Tests:
  	- Validate navigation logic.

**Running Tests**

To run the tests:
  1. Open the project in Xcode.
  2. Press Cmd + U to execute all test cases.
___
## Contact
**Pratik Jamariya**
- 📧 Email: [jamariyapratik@gmail.com](mailto:jamariyapratik@gmail.com)
- 📞 Phone: +918460176662
