;  ___   _   ___   _                      _              _  __
; / __| /_\ | _ \ | |   __ _ _  _ _ _  __| |_  ___ _ _  | |/ /___ _  _ _ __  __ _ _ __
; \__ \/ _ \|  _/ | |__/ _` | || | ' \/ _| ' \/ -_) '_| | ' </ -_) || | '  \/ _` | '_ \
; |___/_/ \_\_|   |____\__,_|\_,_|_||_\__|_||_\___|_|   |_|\_\___|\_, |_|_|_\__,_| .__/
;                                                                 |__/           |_|

;; Username of SAP ( %A_UserName% = Windows logon user id )

user = %A_UserName%


;; Password of SAP
;   * Set commonly used password.
;   * Password prompt dialog will be displayed if left as blank.

password =


;; Default language of SAP
;   * It can be overridden by "language" key in each keymap.

language = EN


;; Max session
;   * Check the number of sessions to avoid session number limit by opening **new** session.
;   * In case of 0, the feature is disabled.
;   * It needs to display a system name in a taskbar. (Option -> Interaction design -> Visualization 2)

maxsession = 6


;; Keymapping

keymap := {}


; You can set "connect", "user", "password" and "language" for each keymap.
; Only "connect" is mandatory and others are optional.
; "user" and/or "language" should be specified when it is different from default you set above.


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

keymap.DE := { connect: "DEV/100|*SPRO DYNP_OKCODE=REF_IMG;", password: "DevPass" }
;   - Hot key is "DE"
;   - Sign-in to the system whose SID = "DEV" and client = 100 using the username set in above but password = "DevPass"
;   - After sign-in, open Reference IMG on transaction SPRO immediately
;   - Session language is default (Default language is "EN" (English))
