# PLEXSTATUS

Check Plex server status (By ping and port availability) and update a web page using a BASH script.

[!(https://raw.githubusercontent.com/JoeWalters/IMG/master/Serverstatus.PNG)]


## Usage

Adjust three variables according to your environment and set this script to be run frequently using a cronjob.
```
SERVERIP=192.168.0.74 # Plex Server IP relative to where this script is running
STATUSPG=/var/www/public_html/index.html # Web page to update
PLEXPORT=32400 # Plex server port relative to the system where this script runs- Typically 32400
```

Here's the relevant section of my index.html file that's being updated by this script
```
    <section class="bg-primary" id="status">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2 text-center">
                    <h2 class="section-heading">SERVER STATUS</h2>
                    <hr class="light">
                    <br>
                    <p class="text-faded">Server Status:<font color="green">Up</font></p>
                    <p class="text-faded">Plex Status:<font color="green">Up</font></p>
<!--                    <a href="#services" class="page-scroll btn btn-default btn-xl sr-button">Get Started!</a> -->
                </div>
            </div>
        </div>
    </section>
```

Here's the HTML5 template that I'm using: https://github.com/BlackrockDigital/startbootstrap-creative

## Requirements
* BASH should be located in /bin/bash.
* You should already have a properly configured web server (Such as Apache or Nginx).

## Info

The script pings your $SERVERIP variable once and based on the results, uses `sed` to replace a line in your index.html file with the current server status. 
```
ping -c 1 $SERVERIP > /dev/null 2>&1
if [ $? -ne 0 ]
then
sed -i '/Server Status/c\                    <p class="text-faded">Server Status:<font color="red">Down<\/font><\/p>' $STATUSPG
else
sed -i '/Server Status/c\                    <p class="text-faded">Server Status:<font color="green">Up<\/font><\/p>' $STATUSPG
fi
```

Next, the script checks if your port is accessible using the `nc` command and uses `sed` to replace a line in your index.html file with the Plex port availablity. 
```
nc -z $SERVERIP $PLEXPORT
if [ $? -ne 0 ]
then
sed -i '/Plex Status/c\                    <p class="text-faded">Plex Status:<font color="red">Down<\/font><\/p>' $STATUSPG
else
sed -i '/Plex Status/c\                    <p class="text-faded">Plex Status:<font color="green">Up<\/font><\/p>' $STATUSPG
fi
```
