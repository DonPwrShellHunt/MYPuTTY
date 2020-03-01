# MYPuTTY

Manipulate PuTTY session configurations

## Overview

Using PowerShell to configure session information is particularly handy
to automate generation of PuTTY sessions, and initiate connections to
one or more of these sessions via the command line.

## Installation

Eventually an Install-Module MYPuTTY from PSGallery will be supported.
Until then, the Output directory within the MYPuTTY development directory
will contain all the components, which can be copied to a PSModulePath
directory of your choice.

## Examples

> Get-MYPuttySession    # get all PuTTY sessions defined for the current user

> New-MYPuttySession -Name 'ubuntu-1804' -Template 'BlackOnPink'
