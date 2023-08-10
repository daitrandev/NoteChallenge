# Welcome to NoteChallenge

[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)
[![Platform](http://img.shields.io/badge/platform-macOS-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-Swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)

## Table of Contents
* [Overview](#overview)
    * [Features](#features)
    * [Architecture](#architecture)
    * [Testing](#testing)
    * [Demo](#demo)
* [Requirements](#overview)
* [Installation](#installation)
* [Author](#author)

## Overview
![Alt text](https://github.com/daitrandev/assets/blob/master/NoteChallenge/clean-architecture-concept.png)

The application is implemented using the Clean Architecture and MVVM. The ultimate goal of Clean Architecture is to help the project not slow down developing when growing up both in team size and project size.
In addition to make developing process steady, the architecture also helps the project easier to maintain, test and reusable in many different kind of systems.

We have three main components here in this architecture.
* **Domain**: The layer where all business logic reside. It includes some layers: Entities + Use Cases + Abstractions.
* **Data**: The layer will implement some abstractions from the **Domain** to serve the relating business of data purposes. In includes some layers: Data Source + Repositories.
* **Presenter**: The layer will also implement some abstractions from the **Domain** to make the UI interactive with the data underneath.

### Features
* The application allows to login with user name and show the list of the notes that created by the user.
* The application can also show the notes of all users logged in to the application. 

### Architecture
![](https://github.com/daitrandev/assets/blob/master/NoteChallenge/app_architecture.jpg)

The application is separated into three main modules: 
**Domain**: This module contains specific use cases and repositories abstractions for managing notes like saving notes, creating notes, retrieve notes, etc. This module can be reused in many systems because it's the highest level module (most abstracted).
**Data**: This module contains implementation of repositories using **Firebase Database** to store and retrieve the data. This module depends on the **Domain** module. The **Firebase** services can be replaced with any other frameworks.
**Presentation**: This module contains the UI implementation and also depends on the **Domain**. Like **Data** module this UI implementation can be switch to any other frameworks as project requirements.

### Testing
The project also includes both UI Tests and Unit Tests to make the functionalities work more reliable and maintainable. Make sure you run the test before updating anything.

### Demo
![](https://github.com/daitrandev/assets/blob/master/NoteChallenge/demo.gif)


## Requirements
* Xcode 14 or later.

## Installation
* **Step 1**: Clone the project by this command:
```
git clone https://github.com/daitrandev/NoteChallenge.git
```
* **Step 2**: Open the `NoteChallenge.xcodeproj` file then grab a ☕️ to wait for the SPM packages fetching.
* **Step 3**: Select a target to build and run.

## Author
* Dai Tran
* <a href="https://www.linkedin.com/in/dai-tran-8b856b102/">LinkedIn</a>
* <a href="https://github.com/daitrandev">Github</a>
