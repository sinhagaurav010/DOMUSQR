//
//  QRImageViewController.h
//  TestWebTab
//
//  Created by gaurav on 18/09/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import <MessageUI/MessageUI.h>

@interface QRImageViewController : UIViewController<MFMailComposeViewControllerDelegate> {
   IBOutlet UIImageView *imageQR;
}

@end
