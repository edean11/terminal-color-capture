# Terminal Color Capture
========================
Create and Automate Color Schemes for the Terminal

Project Vision
--------------

Create a terminal program that accepts different color schemes input by a user, saves them, and automates their application to the terminal window according to user criteria (i.e. date, time etc.)

Features
--------

### Main Functions
    1. Create ColorScheme
    2. Activate Color Schemes
    3. Edit Color Scheme
    4. Delete Color Scheme
    5. Create LS Color Profile
    6. Activate LS Color Profile
    7. Edit LS Color Profile
    8. Delete LS Color Profile
    9. Exit

Usage
-----

  * Run `rake bootstrap_database` to setup your local database
  * Then, `./terminal_color_capture` to manage the list of scenarios

Usage Examples
--------------

### Create a new color scheme

```
  > ./terminal_color_capture
  > Menu
    1. Create ColorScheme
    2. Activate Color Schemes
    3. Edit Color Scheme
    4. Delete Color Scheme
    5. Create LS Color Profile
    6. Activate LS Color Profile
    7. Edit LS Color Profile
    8. Delete LS Color Profile
    9. Exit


  > 1
  > What would you like to call this color scheme?
  > [SchemeName]
  > What color text would you like it to have?
  > [TextColor]
  > What format would you like it to have? (i.e. none, bold, underline)
  > [TextFormat]
  > What background color would you like?
  > [BackgroundColor]
  > When should it begin being active? (hh:mm)
  > [ActiveCriteria]
  > When should it end? (hh:mm)
  > [ActiveCriteria]
  > Would you like this scheme to overwrite the existing prompt color(s) for the given time period?
  > [yes or no]
```
  Creates a new color scheme record in db and returns success
```
  > New color scheme created successfully!
```

Acceptance Criteria:

  * New color scheme added to proper table
  * Exits program when finished


### Activate Existing Color Schemes

Usage Example:

```
  > ./terminal_color_capture
  > Menu
    1. Create ColorScheme
    2. Activate Color Schemes
    3. Edit Color Scheme
    4. Delete Color Scheme
    5. Create LS Color Profile
    6. Activate LS Color Profile
    7. Edit LS Color Profile
    8. Delete LS Color Profile
    9. Exit

  > 2
```
  Program outputs all color schemes in the database and returns formatted data
```
  > Which color scheme would you like to activate?
  > [SchemeName]
  > Are you sure?
  > [y]
```
  Program activates the chosen color scheme

Acceptance Criteria:

  * Program shows all existing color schemes
  * Program activates chosen color scheme
  * Exits program when finished


### Edit Existing Color Scheme

Usage Example:

```
  > ./terminal_color_capture
  > Menu
    1. Create ColorScheme
    2. Activate Color Schemes
    3. Edit Color Scheme
    4. Delete Color Scheme
    5. Create LS Color Profile
    6. Activate LS Color Profile
    7. Edit LS Color Profile
    8. Delete LS Color Profile
    9. Exit

  > 3
```
  Program outputs all color schemes in the database and returns formatted data
```
  > Which scheme would you like to edit?
  > [SchemeName]
  > What property would you like to edit?
  > [Property]
  > Property question
  > [New Answer]
```
  The program updates the color scheme accordingly

Acceptance Criteria:

  * Program changes the existing color scheme
  * Exits the program when finished

### Delete Existing Color Scheme

Usage Example:

```
  > ./terminal_color_capture
  > Menu
    1. Create ColorScheme
    2. Activate Color Schemes
    3. Edit Color Scheme
    4. Delete Color Scheme
    5. Create LS Color Profile
    6. Activate LS Color Profile
    7. Edit LS Color Profile
    8. Delete LS Color Profile
    9. Exit

  > 4
```
  Program outputs all color schemes in the database and returns formatted data
```
  > Which scheme would you like to delete?
  > [SchemeName]
  > Delete [SchemeName]?
  > y
```
  The program deletes the desired color scheme

Acceptance Criteria:

  * Program deletes the given color scheme
  * Returns to menu when finished

### Create LS Color Profile

Usage Example:

```
  > ./terminal_color_capture
  > Menu
    1. Create ColorScheme
    2. Activate Color Schemes
    3. Edit Color Scheme
    4. Delete Color Scheme
    5. Create LS Color Profile
    6. Activate LS Color Profile
    7. Edit LS Color Profile
    8. Delete LS Color Profile
    9. Exit

  > 5
  > What would you like to call this LS Color Profile?
  > [ProfileName]
  > What color text would you like directories to have?(use 'x' for default)
  > red
  > What color text would you like symbolic links to have?(use 'x' for default)
  > white
  > What color text would you like sockets to have?(use 'x' for default)
  > black
  > What color text would you like pipes to have?(use 'x' for default)
  > x
  > What color text would you like executables to have?(use 'x' for default)
  > x
  > What color text would you like block specials to have?(use 'x' for default)
  > x
  > What color text would you like character specials to have?(use 'x' for default)
  > red
  > What color text would you like executables with setuid bit sets to have?(use 'x' for default)
  > x
  > What color text would you like executables with setguid bit sets to have?(use 'x' for default)
  > x
  > What color text would you like directories writable to others, with sticky bit to have?(use 'x' for default)
  > x
  > What color text would you like directories writable to others, without sticky bit to have?(use 'x' for default)
  > x
  > New ls color profile created successfully!
```
  The program creates the desired ls color profile

Acceptance Criteria:

  * Program creates the given color scheme
  * Exits the program when finished

### Activate LS Color Profile

Usage Example:

```
  > ./terminal_color_capture
  > Menu
    1. Create ColorScheme
    2. Activate Color Schemes
    3. Edit Color Scheme
    4. Delete Color Scheme
    5. Create LS Color Profile
    6. Activate LS Color Profile
    7. Edit LS Color Profile
    8. Delete LS Color Profile
    9. Exit

  > 6
```
  The program shows all existing LS Color Profiles
```
  > Which profile would you like to activate?
  > [ProfileName]
  > Are you sure?
  > y
  > LS color profile activated successfully!
```
  The program activates the desired ls color profile

Acceptance Criteria:

  * Program activates the given color scheme
  * Exits the program when finished

### Edit LS Color Profile

Usage Example:

```
  > ./terminal_color_capture
  > Menu
    1. Create ColorScheme
    2. Activate Color Schemes
    3. Edit Color Scheme
    4. Delete Color Scheme
    5. Create LS Color Profile
    6. Activate LS Color Profile
    7. Edit LS Color Profile
    8. Delete LS Color Profile
    9. Exit

  > 7
```
  The program shows all existing LS Color Profiles
```
  > Which profile would you like to change?
  > [ProfileName]
  > Which property would you like to change?
  > [Property]
  > Property question?
  > [New Value]
  > LS color profile changed successfully!
```
  The program changes the desired ls color profile

Acceptance Criteria:

  * Program changes the given color scheme accordingly
  * Exits the program when finished

### Delete LS Color Profile

Usage Example:

```
  > ./terminal_color_capture
  > Menu
    1. Create ColorScheme
    2. Activate Color Schemes
    3. Edit Color Scheme
    4. Delete Color Scheme
    5. Create LS Color Profile
    6. Activate LS Color Profile
    7. Edit LS Color Profile
    8. Delete LS Color Profile
    9. Exit

  > 8
```
  The program shows all existing LS Color Profiles
```
  > Which profile would you like to delete?
  > [ProfileName]
  > Delete [ProfileName]?
  > y
  > LS color profile deleted successfully!
```
  The program deletes the desired ls color profile

Acceptance Criteria:

  * Program deletes the given color scheme
  * Exits the program when finished

