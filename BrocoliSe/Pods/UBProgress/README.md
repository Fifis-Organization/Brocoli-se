# UBProgress

## Usage

Here are some examples to show you how the `UBProgress` can be configured:

### Viewcode

#### Swift
```Swift

 progressBar.setTypeText(.fixedCenter)
 progressBar.setTypeForm(.circle)
 progressBar.setFont(UIFont.systemFont(ofSize: 20))
 progressBar.setLabelTextColor(.blue)
 progressBar.progressTintColor = UIColor.red
        
 progressBar.circleProgressWidth = 5
 progressBar.angle = 80
 progressBar.rotationAngle = 50
```
<img src="https://github.com/Prouj/UBProgress/blob/00d68c36248413f633b0ffb64a59cb67d19c3790/Readme/result%20.png" width="400"> 

#### Objective-C
```Objective-C
[_progressBar0 setTypeText: UBProgressBarIndicatorTextDisplayModeFixedCenter];
[_progressBar0 setTypeForm: UBProgressBarTypeCircle];
[_progressBar0 setFont: [UIFont systemFontOfSize: 20]];
[_progressBar0 setLabelTextColor: [UIColor colorWithRed:1.0 green:0.50 blue:0.50 alpha:1.0]];
 _progressBar0.circleProgressWidth = 5;
 _progressBar0.angle = 80;
 _progressBar0.rotationAngle = 50;
 ```
 <img src="https://github.com/Prouj/UBProgress/blob/1943beb9e04b9b2195e45b608a542198b7711940/Readme/CircleProgress-OBJC.png" width="400"> 

### Storyboard

Use one View and change the reference class to `UBProgress`. 

<img src="https://github.com/Prouj/UBProgress/blob/00d68c36248413f633b0ffb64a59cb67d19c3790/Readme/class.png" width="400"> 

<img src="https://github.com/Prouj/UBProgress/blob/00d68c36248413f633b0ffb64a59cb67d19c3790/Readme/property.png" width="400"> 

## Installation

The recommended approach to use the UBProgress in your project is using the [CocoaPods](http://cocoapods.org/) package manager, as it provides flexible dependency management and dead simple installation.

#### CocoaPods

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```
Go to the directory of your Xcode project, and Create and Edit your Podfile and add UBProgress:

``` bash
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile

target 'MyProject' do
pod 'UBProgress', :git => 'https://github.com/Prouj/UBProgress.git'
end
```

Install into your project:

``` bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file)

``` bash
$ open MyProject.xcworkspace
```
