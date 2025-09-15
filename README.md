# Gaussian-Log-Alert
Scripts that alert you when Gaussian job terminates
### Push Notification Linking
A link will be generated using ntfy.sh server (see https://docs.ntfy.sh/). The link is not password protected and a hard to guess link needed to be generated. <br />
To do this, we will be employing `openssl` to generate random hex string to be a part of our link, you can modify the lenght of this string on `linkgen.sh`. <br /><br />
The app ntfy needed to be installed on phone for phone linking option to work. This is available on App Store, Google Play, and F-Droid <br />
- https://apps.apple.com/us/app/ntfy/id1625396347 (App Store)
- https://play.google.com/store/apps/details?id=io.heckel.ntfy (Google Play)
- https://f-droid.org/en/packages/io.heckel.ntfy/ (F-Droid) <br />
Made by Philipp C. Heckel. *ntfy*. https://github.com/binwiederhier/ntfy
## Initial Installation 
Source the install file to initialize everything
```
source install.sh
```
Add the link from `curllink.dat` to your ntfy app to get notification on phone or on your desktop ntfy app.
### Manual Installation
```
cp logalert.sh logalert
```
```
chmod +x logalert
```
Generate link for ntfy.sh or customize your link if you have a notification server
```
source linkgen.sh
```
Add the following to `.bashrc` under `#User specific aliases and functions`. This can be customized.
```
alias logalert='/path/to/logalert'
```

## Using the Script
Type into the terminal `loglert logname.log &`, this will track the log every 60 seconds (not precise), using it on a completed log file will instantly prints done. Recommended using it with `screen` package on a separate screen.
### Options
 - `p` Will send notification via ntfy when the job terminates
 - `d` A debugging option and will echo out the termlink and phonelink
Silent option is to be implemented, the program by default will echo to terminal when it is done
### Script Termination Condition
The script only checks for the string `Normal termination` or `Error termination` since my coding is not so robust, it will keep looping until they are found. If Gaussian is interrupted and the exit do not write to log, the script will run indefinitely. To solve this, user can manually type `Normal termination` or `Error termination` exactly at the end of the file or kill the pid of the script.
