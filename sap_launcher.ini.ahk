;  ___   _   ___   _                      _              _  __
; / __| /_\ | _ \ | |   __ _ _  _ _ _  __| |_  ___ _ _  | |/ /___ _  _ _ __  __ _ _ __
; \__ \/ _ \|  _/ | |__/ _` | || | ' \/ _| ' \/ -_) '_| | ' </ -_) || | '  \/ _` | '_ \
; |___/_/ \_\_|   |____\__,_|\_,_|_||_\__|_||_\___|_|   |_|\_\___|\_, |_|_|_\__,_| .__/
;                                                                 |__/           |_|

;; Username of SAP (%A_UserName% = Windows logon user id)

user = %A_UserName%


;; Password of SAP (commonly used password)
;  * If kept blank, the password prompt dialog will be displayed.

password =


;; Keymapping

keymap := {}


; Example:
keymap.PR := { connect: "PRD/100" }
;   - Hot key is "PR"
;   - Sign-in to the system whose SID = "PRD" and client = 100 using the username set in above
;   - Password is used which will be prompt (it stores in memory)
;   - Session language is default (Default language is "EN" (English))

keymap.QA := { connect: "QAS/200|VA01", user: "QA", password: "P@ssw0rd", language: "JA" }
;   - Hot key is "QA"
;   - Sign-in to the system whose SID = "QAS" and client = 200 using username = "QA" and password = "P@ssw0rd"
;   - After sign-in, open transaction VA01 immediately
;   - Session language is "JA" (Japanese)

