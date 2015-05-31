# Image Controller for a Static Site (icss)
Script for image management on static sites.

## About

Script copies image files from elected folder, replaces them with zero size files and creates two different sized image files which are then uploaded to the chosen website.

## Requires
Script requires [Mogrify](http://www.imagemagick.org/script/mogrify.php)

## Set Up
Script also requires manual creation of source, temp and destination folders.

These and the webserver destination must be set prior to use within the file.

## Use

While icss may be called from command line, driven by static site hooks or cron as required. 
