# FFPersistanceService

[![Platform MacOS](https://img.shields.io/badge/platform-macOS-lightgrey.svg)](#)
[![Platform](https://img.shields.io/cocoapods/p/FFPersistanceService.svg?style=flat)](https://cocoapods.org/pods/FFPersistanceService)
[![Version](https://img.shields.io/cocoapods/v/FFPersistanceService.svg?style=flat)](https://cocoapods.org/pods/FFPersistanceService)
[![Carthage Compatible](https://img.shields.io/badge/carthage-compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![SPM Compatible](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager)
[![License](https://img.shields.io/cocoapods/l/FFPersistanceService.svg?style=flat)](https://cocoapods.org/pods/FFPersistanceService)

<!--## Description-->

A framework that makes it super easy to save objects in `UserDefaults` , `Keychain` or any custom `key`-`value` based object storage solution through protocols.

With the use of `Persistable` protocol you can easily `save`/`load`/`delete` through your Model objects 
in the predefined storage solution.  

## Usage

Check out the Example Project
- `ViewModel.swift` from `line 71` and
- `Model` folder

and in `PersistanceServiceTests` folder
- `Mocks.swift` and 
- `PersistableTests.swift` 

## Installation

### Cocopods

__FFPersistanceService__ is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
pod 'FFPersistanceService'
```

### Carthage

__FFPersistanceService__ is available through [Carthage](https://github.com/Carthage/Carthage). To install
it, simply add the following line to your `Cartfile`:

```ruby
github "fr3qfly/FFPersistanceService"
```

### Swift Package Manager

__FFPersistanceService__ is available through [Swift Package Manager](https://swift.org/package-manager). Once you have
a Package set-up you just need to add the package to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    // This is the line you need to add:
    .package(url: "https://github.com/fr3qfly/FFPersistanceService", from: "1.0.0"),
]
```

And you need to add it to the targets where you intend to use it.

```swift
.target(
    name: "Your_Target",
    dependencies: ["FFPersistanceService"])
```

## Author

BalazsSzamody, fr3qfly@gmail.com

## License

FFPersistanceService is available under the MIT license. See the LICENSE file for more info.
