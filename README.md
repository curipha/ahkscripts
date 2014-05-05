ahkscripts
==========
AutoHotkey scripts for AutoHotkey_L (Unicode).
Not works on AutoHotkey.

Some AHK scripts are also used in office.
This is why you can see "SAP" and "Notes" on the code ;p


About scripts
-------------

### my.ahk
Just a my key configuration for general usage.

- Remap `CapsLock` key to `Tab` key
- Assign `Ctrl+Shift+V` to paste as plain text (paste without any formatting)
- Remap `Ctrl+D` to `Ctrl+F` on Google Chrome
  - Prevent to add a bookmark accidentally
- Open Desktop in `Win+E`
  - Default is My Computer


### my_office.ahk
AHK scripts used in office.

- Remap `F1` key to `Esc` key
  - Generally, F1 help is no use ;p
  - ... except for SAP GUI
- Remap `Ctrl+/` to `Ctrl+/` + `/` on SAP GUI
  - A little hack
- Workaround for impossible to enter `Shift+-` in JIS keyboard on Lotus Notes
  - On JIS keyboard, `Shift+-` means just `=`

SAP is an Enterprise Resource Planning software by SAP AG.
Notes (a.k.a. Lotus Notes) is a Collaborative software by IBM.
These are the typical software currently used in the private enterprise.


### sap_launcher.ahk
Front-end of `sapshcut.exe` bundled with SAP GUI.

If you hit the Ctrl key twice quickly, an form will come out at the upper left of a screen.
You can enter the command for starting new SAP GUI session.

You can customize the key mapping by changing `keymap` variables in this program.
For more details of customizing of key mapping, see the code.

To see the current key mapping,  hit `h` on the form.


Links
-----
- AutoHotkey_L Download http://ahkscript.org/download/
- AutoHotkey Wiki (Japanese) http://ahkwiki.net/

