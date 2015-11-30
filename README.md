# CheckboxButton
[![Build Status](https://travis-ci.org/chrisamanse/CheckboxButton.svg)](https://travis-ci.org/chrisamanse/CheckboxButton) 
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A checkbox button UI component for iOS built in Swift.

![CheckboxButton image](./Images/CheckboxButton.png)

**`CheckboxButton`**
  - A subclass of `UIButton`. The rectangular square box is simply drawn on top of the button. The square box will fit the frame of the button while maintaining its aspect ratio.

# Installation

This project can be installed in different ways:
  - Manual
    1. Download the project
    2. Simply copy the `CheckboxButton.swift` to your project
  - Framework
    1. Download the project
    2. Build the **CheckboxButton** framework
    3. Embed the framework into your project
  - Carthage
    1. Install [Carthage](https://github.com/carthage/carthage) in your system if you don't have it yet
    2. Add a Cartfile in your project directory if you don't have one yet
    3. Then add the line `github "chrisamanse/CheckboxButton"` in your Cartfile
    4. Run `carthage update`
    5. Follow [Carthage](https://github.com/carthage/carthage) instructions to incorporate the frameworks that Carthage built

# Usage

`RadioButton` can be used in two different ways:
  - Interface Builder
    - Simply change the class of the `UIButton` to `CheckboxButton`.
  - Code
    - Use the initializer: `init(frame: CGRect)`

You can run the example app located in the same project to see how it's used.

# License

Copyright (c) 2015 Joe Christopher Paul Amanse

This software is distributed under the [MIT License](./LICENSE).
