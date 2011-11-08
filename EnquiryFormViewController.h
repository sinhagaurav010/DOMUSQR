//
//  EnquiryFormViewController.h
//  BarCodeReader
//
//  Created by gaurav on 14/09/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import <MessageUI/MessageUI.h>


@interface EnquiryFormViewController : UIViewController<MFMailComposeViewControllerDelegate > 
{
    IBOutlet UITableView *tablereader;   
    NSMutableArray  *arrayText;
    UITextField *fieldTxt1;
    NSMutableArray *arrayElement;
}

@end
