# Moltin

The Moltin ios-sdk is a simple to use interface for the API to help you get off the ground quickly and efficiently within the iOS app.

## Installation

Download the SDK at URL... or via Cocoapods by adding the 'Moltin' pod.

## Usage

Installation
------------

There are two ways to use Moltin in your project:
- using Cocoapods
- copying all the files into your project

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Get Started](http://cocoapods.org/#get_started) section for more details.

#### Podfile
``` objc
platform :ios, '7.0'

pod 'Moltin', :git => 'https://github.com/moltin/ios-sdk.git', :branch => 'develop'
```


#### Usage

``` objc
#import <Moltin/Moltin.h>;
```

### Authentication

Just set the `publicId` from the api console on Moltin website and you are ready to go.

``` objc
[[Moltin sharedInstance] setPublicId:@"XXXXXXXXXXXXX"];

```

### Resources

The majority of our API calls can be mapped to Model-esque instance and don't need any low-level API calls.

Get a single product by ID
``` objc
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
``` objc
[[Moltin sharedInstance].address createWithParameters:@{  @"first_name": @"Joe", @"last_name": @"Black" } 
                                			 callback:^(NSDictionary *response, NSError *error){         
						                                if(!error) {
						                                    NSLog(@"Address created.");
						                                } else {
						                                    NSLog(@"ERROR: %d", error.code); 
						                                }
                                }];
