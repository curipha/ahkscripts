ahkscripts
==========
AutoHotkey scripts for AutoHotkey (Unicode).


About scripts
-------------

### my.ahk
My key configuration for general purpose.

- Open Desktop with <kbd>Win+E</kbd> (Default is My Computer)
- Remap <kbd>CapsLock</kbd> to <kbd>Tab</kbd> for JIS keyboard
- Assign <kbd>Ctrl+Shift+V</kbd> to paste as plain text (paste without any formatting)
- Remap <kbd>Ctrl+D</kbd> to <kbd>Ctrl+F</kbd> on Google Chrome to prevent from adding to bookmark accidentally
- etc...


### my_office.ahk
AHK script used in office. (This script should be used with `my.ahk`.)

- Remap <kbd>F1</kbd> to <kbd>Esc</kbd> since <kbd>F1</kbd> help is no use ;p
- Remap <kbd>Ctrl+/</kbd> to <kbd>Ctrl+/</kbd> + <kbd>/</kbd> on SAP GUI
- <kbd>Ctrl+-</kbd> sends <kbd>Shift+-</kbd> on Lotus Notes (<kbd>Shift+-</kbd> means just <kbd>=</kbd> on JIS keyboard)

SAP is an Enterprise Resource Planning software by SAP AG.
Lotus Notes is a Collaborative software by IBM.
They are the typical software currently used in the private enterprise.


### sap_launcher.ahk
Front-end of `sapshcut.exe` bundled with SAP GUI.

When you hit <kbd>Ctrl</kbd> twice quickly, a form appears in the upper-left corner of your screen.
You can enter a command for starting new SAP GUI session.

You can customize key mappings by changing `keymap` variables in `sap_launcher.ini.ahk`.
For more details of customizing of key mapping, see the code.
Do not forget to install `sap_launcher.ini.ahk` in the same directory as `sap_launcher.ahk`.
Otherwise, `sap_launcher.ahk` will not start.

To see the current key mapping, hit <kbd>h</kbd> on the form.


Remarks
-------

`IME.ahk` is originally distributed at [eamat @Cabinet](http://www6.atwiki.jp/eamat/).


Links
-----
- AutoHotkey Download https://autohotkey.com/download/
- AutoHotkey Wiki (Japanese) https://ahkwiki.net/

