//
//  ResultViewController.h
//  BarCodeReader
//
//  Created by gaurav on 08/09/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <MessageUI/MessageUI.h>
#import "Constant.h"
#import "EnquiryFormViewController.h"

@interface ResultViewController : UIViewController<MFMailComposeViewControllerDelegate,UIActionSheetDelegate> {
   IBOutlet UIWebView *webApp;  
}
-(void)EmailTheLink;
-(void)saveTheUrlInFav;
@property(retain)NSString *stringUrl;
@end
