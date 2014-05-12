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

- Open Desktop with `Win+E`
  - Default is My Computer
- Remap `CapsLock` key to `Tab` key
  - It is a feature for JIS keyboard
- Assign `Ctrl+Shift+V` to paste as plain text (paste without any formatting)
- Remap `Ctrl+D` to `Ctrl+F` on Google Chrome
  - Prevent to add a bookmark accidentally


### my_office.ahk
AHK scripts used in office. (This script should be used with `my.ahk`.)

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

You can customize the key mapping by changing `keymap` variables in `sap_launcher.ini.ahk`.
For more details of customizing of key mapping, see the code.

Do not forget to install `sap_launcher.ini.ahk` in the same directory as `sap_launcher.ahk`.
Otherwise, `sap_launcher.ahk` will not start.

To see the current key mapping, hit `h` on the form.

This script needs AHK_L v1.1.13+.
It uses `StrSplit` function and this function is introduced in v1.1.13.
Therefore, this script requires v1.1.13 and over.


Remarks
-------

`IME.ahk` has been distributed at [eamat @Cabinet](http://www6.atwiki.jp/eamat/).

The `IME.ahk` file in this repository is the file that I extracted from the original.
Therefore, it is the same license as the original file.


Links
-----
- AutoHotkey_L Download http://ahkscript.org/download/
- AutoHotkey Wiki (Japanese) http://ahkwiki.net/

