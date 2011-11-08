//
//  HomeViewController.h
//  BarCodeReader
//
//  Created by Rohit Dhawan on 06/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ZBarReaderViewController.h"
#import "ResultViewController.h"
#import "ViewPickerTool.h"
#import "Constant.h"
#import "WebBrowserViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "AdScreenFlash.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "FavViewController.h"
#import "EnquiryFormViewController.h"

@interface HomeViewController : UIViewController<ZBarReaderViewDelegate,cutomDelegateToolPicker,ADScreenFlashDelegate> {
    ZBarReaderView *readerView;
    ZBarCameraSimulator *cameraSim;
    ViewPickerTool *pickerOptions;
    NSMutableArray *arrayOptions;
    IBOutlet UITabBarController *tabBar;
    IBOutlet UIToolbar *toolBarScan;
    BOOL isStartScan;
    
    AdScreenFlash *viewBlink;
}
-(IBAction)clickToFav:(id)sender;
-(IBAction)clickToEnquiry:(id)sender;

-(IBAction)startScan:(id)sender;
@property (nonatomic, retain) IBOutlet ZBarReaderView *readerView;

@end
