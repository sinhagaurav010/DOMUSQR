//
//  FavViewController.h
//  TestWebTab
//
//  Created by gaurav on 18/09/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import <MessageUI/MessageUI.h>

@interface FavViewController : UIViewController<MFMailComposeViewControllerDelegate> {
    IBOutlet UITableView *tableViewScan; 
    IBOutlet UIBarButtonItem *buttonDelAll;
    IBOutlet UIBarButtonItem *buttonDel;
    BOOL isDeleting;
    NSMutableArray *arrayDel;

}
-(IBAction)deleteAll:(id)sender;
-(IBAction)deleteOneByOne:(id)sender;

@end
