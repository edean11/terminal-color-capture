# Terminal Color Capture
========================
Create and Automate Color Schemes for the Terminal

Project Vision
--------------

Create a terminal program that accepts different color schemes input by a user, saves them, and automates their application to the terminal window according to user criteria (i.e. date, time etc.)

Features
--------

### Main Functions
    1. CreateANewColorScheme
    2. ActivateExistingColorSchemes
    3. EditExistingColorScheme
    4. DeleteExistingColorScheme
    5. CreateLSColorProfile
    6. ChangeLSColorProfile
    7. DeleteLSColorProfile
    8. Exit

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
    1. CreateANewColorScheme
    2. ActivateExistingColorSchemes
    3. EditExistingColorScheme
    4. DeleteExistingColorScheme
    5. CreateLSColorProfile
    6. ChangeLSColorProfile
    7. DeleteLSColorProfile
    8. Exit


  > 1
  > What would you like to call this color scheme?
  > [SchemeName]
  > What color text would you like it to have?
  > [TextColor]
  > What format would you like it to have? (i.e. none, bold, underline)
  > [TextFormat]
  > What background color would you like?
  > [BackgroundColor]
  > When would you like this scheme to be active? (hh:mm-hh:mm,weekdays,now)
  > [ActiveCriteria]
```
  Creates a new color scheme record in db and returns success
```
  > New color scheme created successfully!
```

Acceptance Criteria:

  * New color scheme added to proper tables
  * Error returned if ActiveCriteria overlaps an existing ActiveCriteria
  * Returns to menu when finished


### Activate Existing Color Schemes

Usage Example:

```
  > ./terminal_color_capture
  > Menu
    1. CreateANewColorScheme
    2. ActivateExistingColorSchemes
    3. EditExistingColorScheme
    4. DeleteExistingColorScheme
    5. CreateLSColorProfile
    6. ChangeLSColorProfile
    7. DeleteLSColorProfile
    8. Exit

  > 2
```
  Program outputs all color schemes in the database and returns formatted data
```
  > Which color scheme would you like to activate?
  > [SchemeName]
```
  Program activates the chosen color scheme

Acceptance Criteria:

  * Program shows all existing color schemes
  * Program activates chosen color scheme
  * Returns to menu when finished


### Edit Existing Color Scheme

Usage Example:

```
  > ./terminal_color_capture
  > Menu
    1. CreateANewColorScheme
    2. ActivateExistingColorSchemes
    3. EditExistingColorScheme
    4. DeleteExistingColorScheme
    5. CreateLSColorProfile
    6. ChangeLSColorProfile
    7. DeleteLSColorProfile
    8. Exit

  > 3
```
  Program outputs all color schemes in the database and returns formatted data
```
  > Which scheme would you like to edit?
  > [SchemeName]
  > What color text would you like it to have?
  > [TextColor]
  > What format would you like it to have? (i.e. none, bold, underline)
  > [TextFormat]
  > What background color would you like?
  > [BackgroundColor]
```
  The program updates the color scheme accordingly

Acceptance Criteria:

  * Program changes the existing color scheme
  * Returns to menu when finished

### Delete Existing Color Scheme

Usage Example:

```
  > ./terminal_color_capture
  > Menu
    1. CreateANewColorScheme
    2. ActivateExistingColorSchemes
    3. EditExistingColorScheme
    4. DeleteExistingColorScheme
    5. CreateLSColorProfile
    6. ChangeLSColorProfile
    7. DeleteLSColorProfile
    8. Exit

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
```
  > exit
```
  Exits the program

Acceptance Criteria:

  * Program deletes the given color scheme
  * Returns to menu when finished

### Create LS Color Profile

Usage Example:

```
  > ./terminal_color_capture
  > Menu
    1. CreateANewColorScheme
    2. ActivateExistingColorSchemes
    3. EditExistingColorScheme
    4. DeleteExistingColorScheme
    5. CreateLSColorProfile
    6. ChangeLSColorProfile
    7. DeleteLSColorProfile
    8. Exit

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
  * Returns to menu when finished

### Change LS Color Profile

Usage Example:

```
  > ./terminal_color_capture
  > Menu
    1. CreateANewColorScheme
    2. ActivateExistingColorSchemes
    3. EditExistingColorScheme
    4. DeleteExistingColorScheme
    5. CreateLSColorProfile
    6. ChangeLSColorProfile
    7. DeleteLSColorProfile
    8. Exit

  > 6
```
  The program shows all existing LS Color Profiles
```
  > Which profile would you like to change?
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
  > LS color profile changed successfully!
```
  The program changes the desired ls color profile

Acceptance Criteria:

  * Program changes the given color scheme
  * Returns to menu when finished

### Delete LS Color Profile

Usage Example:

```
  > ./terminal_color_capture
  > Menu
    1. CreateANewColorScheme
    2. ActivateExistingColorSchemes
    3. EditExistingColorScheme
    4. DeleteExistingColorScheme
    5. CreateLSColorProfile
    6. ChangeLSColorProfile
    7. DeleteLSColorProfile
    8. Exit

  > 7
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
  * Returns to menu when finished

