//
//  BarCodeReaderAppDelegate.h
//  BarCodeReader
//
//  Created by Rohit Dhawan on 06/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "HomeViewController.h"
#import "EnquiryFormViewController.h"
#import "SplashScreenViewController.h"

@interface BarCodeReaderAppDelegate : NSObject <UIApplicationDelegate,ZBarReaderDelegate> {
    HomeViewController *homeController;
    SplashScreenViewController *splashController;
    SplashScreenViewController  *splashScreenController;
    UINavigationController *navigation;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
