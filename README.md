# Moltin iOS-SDK

The Moltin ios-sdk is a simple to use interface for the API to help you get off the ground quickly and efficiently within the iOS app.

For full usage examples, check out the [Objective-C](https://github.com/moltin/ios-objc-example) example app, or the [Swift](https://github.com/moltin/ios-swift-example) example app.

## Installation
There are two ways to install the Moltin SDK in your project:

- Using CocoaPods (recommended)
- Manual installation by copying all of the files in the Moltin directory into your project, and adding them to your target

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Get Started](http://cocoapods.org/#get_started) section for more details.

#### Podfile
```objc
platform :ios, '7.0'

pod 'Moltin', :git => 'https://github.com/moltin/ios-sdk.git', :branch => 'master'
```


#### Usage

```objc
#import <Moltin/Moltin.h>;
```

### Authentication

Just set your store `public ID` from the API console on Moltin website and you are ready to go.

```objc
[[Moltin sharedInstance] setPublicId:@"XXXXXXXXXXXXX"];
```

### Resources

The majority of our API calls can be mapped to Model-esque instance and don't need any low-level API calls. A full example store app is included showing every part of the shopping process - from listing products, to adding them to a cart, and allowing the user to checkout (via credit card or Apple Pay).

Get a single product by ID
```objc
[[Moltin sharedInstance].product getWithId:@"6"
                                  callback:^(NSDictionary *response, NSError *error){
                                            if(!error) {
                                                NSLog(@"PRODUCT: %@", response);
                                            } else {
                                                NSLog(@"ERROR: %d", error.code);
                                            }
                                }];
```

Creating a user's address
```objc
[[Moltin sharedInstance].address createWithParameters:@{  @"first_name": @"Joe", @"last_name": @"Black" }
                                			 callback:^(NSDictionary *response, NSError *error){
						                                if(!error) {
						                                    NSLog(@"Address created.");
						                                } else {
						                                    NSLog(@"ERROR: %d", error.code);
						                                }
                                }];
```
