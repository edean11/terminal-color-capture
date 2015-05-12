# Terminal Color Capture
========================
Create and Automate Color Schemes for the Terminal

Project Vision
--------------

Create a terminal program that accepts different color schemes input by a user, saves them, and automates their application to the terminal window according to user criteria (i.e. date, time etc.)

Features
--------

### Main Functions
    1.  Create a new color scheme
    2.  View existing color schemes
    3.  Edit an existing color scheme
    4.  Delete an existing color scheme

Usage Examples
--------------

### Create a new color scheme

```
  > ./terminal_color_scheme
  > Menu
    1. Create a New Color Scheme
    2. View an Existing Color Scheme
    3. Edit an Existing Color Scheme
    4. Delete an Existing Color Scheme


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
  > exit
```
  Exits the program

Acceptance Criteria:

  * New color scheme added to proper tables
  * Error returned if ActiveCriteria overlaps an existing ActiveCriteria
  * Calling exit exits the program


### View Existing Color Schemes

Usage Example:

```
  > ./terminal_color_scheme
  > Menu
    1. Create a New Color Scheme
    2. View an Existing Color Scheme
    3. Edit an Existing Color Scheme
    4. Delete an Existing Color Scheme
  > 2
```
  Program outputs all color schemes in the database and returns formatted data
```
  > exit
```
  Exits the program

Acceptance Criteria:

  * Program shows all existing color schemes
  * Exits the program at the end


### Edit Existing Color Scheme

Usage Example:

```
  > ./terminal_color_scheme
  > Menu
    1. Create a New Color Scheme
    2. View an Existing Color Scheme
    3. Edit an Existing Color Scheme
    4. Delete an Existing Color Scheme
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
```
  > exit
```
  Exits the program

Acceptance Criteria:

  * Program changes the existing color scheme
  * Exits the program at the end

### Delete Existing Color Scheme

Usage Example:

```
  > ./terminal_color_scheme
  > Menu
    1. Create a New Color Scheme
    2. View an Existing Color Scheme
    3. Edit an Existing Color Scheme
    4. Delete an Existing Color Scheme
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
  * Exits the program at the end

