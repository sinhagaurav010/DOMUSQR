//
//  WebBrowserViewController.h
//  TestWebTab
//
//  Created by gaurav on 18/09/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "FavViewController.h"
#import "QRImageViewController.h"
#import "EnquiryFormViewController.h"
#import "MBProgressHUD.h"

@interface WebBrowserViewController : UIViewController<UIActionSheetDelegate,UISearchBarDelegate,UIWebViewDelegate> {
  IBOutlet  UIWebView *webViewScan;   
    NSString *stringUrl;
    IBOutlet UISearchBar *searchBarScan;
    UIBarButtonItem *buttonFav;
    UIBarButtonItem *buttonQR;
    UIBarButtonItem *buttonEnq;
    BOOL isFirstTime;
}
-(void)saveTheUrlInFav;
-(IBAction)Savefavourites:(id)sender;

-(IBAction)favouritesNav:(id)sender;
-(IBAction)QRImageShow:(id)sender;
-(IBAction)EnquiryForm:(id)sender;
+(void)removeContentForKey:(NSString*)stringKey;


@end
