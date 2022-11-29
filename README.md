
# psping shell script

this is a shell script responsible on pinging the amount of proccesses currently running with the help of given arguments and flags

the script can be activated with the following flags:

flag  | explenation
------------- | -------------
-c  | limit amount of pings, e.g. -c 3. Default is infinite
-t  | define alternative timeout in seconds, e.g. -t 5. Default is 1 sec
-u  | define user to check process for

## Deployment

the script also needs to be given the name of the executable you want to pinpoint (for example - firefox, gedit etc.)

the script works best while using the following syntax:

  ```bash
  ./psping [-c ###] [-t ###] [-u user-name] exe-name
  ```

hope you like it

