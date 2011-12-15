//
//  BarCodeReaderAppDelegate.m
//  BarCodeReader
//
//  Created by  on 06/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BarCodeReaderAppDelegate.h"

@implementation BarCodeReaderAppDelegate


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        iPad = 1;
        // The device is an iPad running iPhone 3.2 or later.
    }
    else
    {
        iPad= 0;
        // The device is an iPhone or iPod touch.
    }
    
//    if(iPad == 0)
//    {
//        homeController = [[HomeViewController alloc] init];
////        [ZBarReaderViewController class];
////        ZBarReaderViewController *reader;// = (ZBarReaderViewController*)self;
////        //[self.tabBarController.viewControllers objectAtIndex: 0];
////        reader.readerDelegate = self;
////        reader.showsZBarControls = NO;
////        reader.supportedOrientationsMask = ZBarOrientationMaskAll;
//        
//        navigation = [[UINavigationController alloc] initWithRootViewController:homeController];
//    }
//    else
//    {
//        homeController = [[HomeViewController alloc] initWithNibName:@"HomeViewController_iPad"
//                                                              bundle:nil];
//        //        [ZBarReaderViewController class];
//        //        ZBarReaderViewController *reader;// = (ZBarReaderViewController*)self;
//        //        //[self.tabBarController.viewControllers objectAtIndex: 0];
//        //        reader.readerDelegate = self;
//        //        reader.showsZBarControls = NO;
//        //        reader.supportedOrientationsMask = ZBarOrientationMaskAll;
//        
//        
//
//        navigation = [[UINavigationController alloc] initWithRootViewController:homeController];
//    }

    splashController = [[SplashScreenViewController alloc] init];
    navigation = [[UINavigationController alloc] initWithRootViewController:splashController];

    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    [self.window addSubview:navigation.view];
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)  imagePickerController: (UIImagePickerController*) picker
  didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // do something useful with results
    //    UITabBarController *tabs = self.tabBarController;
    //    tabs.selectedIndex = 1;
    //    UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
    //    results.resultImage.image = image;
    
    id <NSFastEnumeration> syms =
    [info objectForKey: ZBarReaderControllerResults];
    for(ZBarSymbol *sym in syms) {
        NSLog(@"%@",sym.data);
        //      results.resultText.text = sym.data;
        break;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [navigation release];
    [homeController release];
    [_window release];
    [super dealloc];
}

@end
