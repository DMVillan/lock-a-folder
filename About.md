# LocK-A-FoLdeR #
Copyright © 2011 Gurjit Singh



## 1 Introduction ##

LocK-A-FoLdeR is a compact and easy to use program that allows you to hide and lock up any folders on your computer, making them invisible and inaccessible to anyone but yourself. After you create a master password, simply select the folder you want to hide and click a button to make them disappear. To unlock a folder, enter your password and select the folder that you want to unlock.
### ==> It features : ###
  * Extremely easy to use and straightforward Interface.
  * Uses almost no CPU (no extra services or processes).
  * Compatible with Windows XP/Vista/7.
  * Open Source (Free To Use/Distribute/Study/Modify).
  * Multilingual.
and much more...

## 2 Updates ##

The latest version can be found at:
http://lock-a-folder.googlecode.com/
http://code.google.com/p/lock-a-folder/

## 3 Licensing ##

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

> http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## 4 Troubleshooting ##

To manually unlock folders in :
===> Windows 7 & Vista
```
	Open Folder Options from the Control Panel
	Click the View tab
	Under the Advanced settings, check the Show hidden files and folders radio box and uncheck Hide protected operating system files (Recommended) radio box
	Click OK
	Right click on the folder you want to Unlock then go to properties.
	Now click on the Security tab and then click the Advanced button at the bottom.
	Select the Owner tab in the next windows.
	Now click on the Edit button. In the next windows select your username in the ‘Change owner to’ field and check the "Replace owner of subcontainers and objects" option.
	Now click OK on all the dialog boxes that are open. That’s it :)
```

===> Windows XP
```
	Open Windows Explorer(My Computer).
	On the Tools menu, select Folder Options.
	move to the View tab.
	Check the "Show hidden files and folders" radio box and uncheck "Hide protected operating system files (Recommended)" & "Use simple file sharing (Recommended)" radio box
	Right click on the folder you want to Unlock then go to properties.
	Now click on the Security tab and then click the Advanced button at the bottom.
	Select the Owner tab in the next windows.
	In the next windows select your username in the ‘Change owner to’ field and check the "Replace owner of subcontainers and objects" option.
	Now click OK on all the dialog boxes that are open. That’s it :)
```

## 5 Command Line Parameters ##
```
LocK-A-FoLdeR.exe param "Folder[1]" "Folder[2]" "Folder[3]" "Folder[N]"

Where param is : 
/lk to lock folder(s)
/uk to unlock folder(s)
Examples :
LocK-A-FoLdeR.exe /lk "C:\Users\Gurjit\Downloads" "C:\Users\Gurjit\Pictures" "D:\F.E.A.R. 3" "D:\AssassinsCreed Brotherhood"
LocK-A-FoLdeR.exe /uk "C:\Users\Gurjit\Pictures" "D:\F.E.A.R. 3"
LocK-A-FoLdeR.exe /uk "C:\Users\Gurjit\Downloads"

To Unlock all Locked folders :
LocK-A-FoLdeR.exe /ukall
```
## 6 Contact ##

For Bug reports, suggestions and such, please
Email : correctlyincorrect@gmail.com
WWW : http://code.google.com/p/lock-a-folder/issues/list

## 7 CREDITS ##

Refer to NOTICE.txt