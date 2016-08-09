# Blink Settings project
This is a separate application to develop Blink's settings app. I have assembled a simple separated project where I expect the functionality for the storyboards to be completed, and the data models to store and display created.

- Data Models: There are four serializable data models that need to be created, all of them can use the PKCard one as an example. Hosts will be defined at the Hosts section. The rest follow:
  * Defaults: Single structure, with the default configuration parameters
    "KeyboardMaps" - Dictionary: String ("ctrl", "alt", "command", "caps") to Integer / Enum (none, ctrl, meta, esc). Example:  {"ctrl": 1, "alt": 2, "command": 1, "caps": 3}.
    ThemeName: String
    FontName: String
    FontSize: Float
    DefaultUser: String.
  * Themes: List of themes consisting of
    Name: String
    Content: String - This will be filled up with a downloaded CSS from the "Theme" section.
  * Fonts: List of fonts consisting of
    Name: String
    Content: String - This will be filled up with a downloaded CSS from the "Font" section.

These are the stories that would have to be completed for each section:

- Keys: This area is fully complete. It is included here mostly as an example of the data models, lists, selectable table items, deleting from a list, etc...

- Hosts:
  * Create Hosts serializable data model with the following fields: "Host" - String; "HostName": String; "Port": Integer; "User": String; "Password": String; "Key": String; "MoshPort": Integer; "MoshStartup": String; "Prediction": Integer (from an enum that can be "adaptive", "always", "never" or "experimental".). Follow the available PKCard model for an example.
  * Present list of previously saved Hosts with the Title as the Host.
  * Remove a Host by dragging and using the cell's delete.
  * When tapping on a Host, open its information into the "Host creation" dialog, showing the name of the Host at the title.
  - Hosts creation: This dialog is opened either when creating a new host, or to edit an existing one.
    * Ensure all required fields are complete before enabling the Save button. Also, Host - HostName - User cannot have spaces. Ports have to be numbers. Ensure uniqueness of the "Host" field across the interface (during creation or edition).
    * When rolling back from the "Key", the selected key must be shown and saved.
    * Prediction mode selection: The Prediction Mode dialog should show the options "adaptive", "always", "never" and "experimental"; The options must be selectable using a checklist (in the same manner as Keys does); After switching back, the selected option must be shown on the Prediction Field and the option saved for the Host.
    * If opened on Edit mode: the Host information must be filled up on each field. Information must be editable and when saved, the host must be updated.
    * When pressing Save, a new Host must be created or updated, ensuring the uniqueness of the "Host" field, and showing an alert message otherwise with the error, cancelling the segue and allowing the user to fix the problem. After rolling back to the list of Hosts, the new Host must be shown. 
  
- Keyboard: This section allows to map a Key from the KeyboardMaps structure in the Defaults data model to an Enum.
  * The Keyboard section must show the selected Default value on each field.
  * When tapping on one of the keys, the Modifiers section must be opened with the selected option.
  * After switching back to Keys, the previously selected option must be selected and saved on the Defaults structure.
  
- Appearance: This section allows the configure the Defaults values for ThemeName, FontName and FontSize. In case a new Theme or Font is created, it will be added to the Themes or Fonts lists.
  * The Appearance section must show three sections. The first two, for Themes and Fonts must show the list of saved Themes and Fonts respectively. Each list must allow to delete elements from the Themes or Fonts. (The idea is to create something similar for each table to Settings > General > Accessibility > Media > Subtitles & Captioning.). The values for the Default structure Theme or Font must be selected.
  * The Themes or Fonts selection can be changed there from the list of available ones, showing a check mark for each section.
  * The Font Size section when tapped, must allow to edit the font number as a floating point value, adding the "px" word after edition.
  * When switching back, the selections for Fonts and Themes, and the value on Font Size must be updated on the Defaults structure.
  - "Add a new theme": This section allows to import a theme from a given URL, saving it to the Themes list
    * The Import button must be disabled until a URL is introduced. 
    * When the Import button is tapped, the URL content must be downloaded on the background. Once the content has been downloaded, an action method "Downloaded" must be invoked at the View Controller to be filled up by myself. In case there has been an error during the Download, an Alert Message must be displayed. In case the user switches back during download, the download must be cancelled.
    * When there is a Download and a Name, the "Save" button on the top right must be enabled. If pressed, it saves the Theme to the list with the "Name" and "Content" with the Content of the previously downloaded file, switching back to the Appearance section, that should now show the new theme selected.
  - "Add a new font": This section allows to import a theme from a given URL, saving it to the Fonts list
    * The Import button must be disabled until a URL is introduced. 
    * When the Import button is tapped, the URL content must be downloaded on the background. Once the content has been downloaded, an action method "Downloaded" must be invoked at the View Controller to be filled up by myself. In case there has been an error during the Download, an Alert Message must be displayed. In case the user switches back during download, the download must be cancelled.
    * When there is a Download and a Name, the "Save" button on the top right must be enabled. If pressed, it saves the Fonts to the list with the "Name" and "Content" with the Content of the previously downloaded file, switching back to the Appearance section, that should now show the new theme selected.

- Aligns and auto layouts must be improved where they are misaligned or not created.


