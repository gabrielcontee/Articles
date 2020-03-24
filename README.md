gabriel-conte-ios

# Articles
The main idea is to develop an application that queries an API (http://www.ckl.io/challenge/), that provides a list of articles. The goal of the app is to list all provided articles. Also, the user should be able to sort by its properties and mark them as read.

## Requirements

* Xcode 11.3.1
* Swift 5

## Architecture

This app is using `MVMM` with  `Coordinators`.

## Features

* **No Storyboard:** Views was developed using view XIBs.
* **Unit Tests:** code coverage: ~53,6%
  
## Third-party libraries
I'm using CocoaPods, that is a dependency manager for Swift and Objective-C Cocoa projects

#### - pod 'SGImageCache'
Used to download and cache images.
  
## How to install

* Clone or download the project to your machine.
* Using the terminal, go to the project folder where there is the Podfile and execute the command bellow.
``` sh
pod install
```
