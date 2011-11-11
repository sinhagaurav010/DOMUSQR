//
//  WebBrowserViewController.m
//  TestWebTab
//
//  Created by gaurav on 18/09/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "WebBrowserViewController.h"


@implementation WebBrowserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    if([webViewScan isLoading])
        [webViewScan stopLoading];
    [webViewScan release];
    
    [super dealloc];
}


-(IBAction)Savefavourites:(id)sender
{
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil 
                                                     delegate:self 
                                            cancelButtonTitle:nil
                                       destructiveButtonTitle:nil 
                                            otherButtonTitles:@"Save to Favourites",@"Cancel", nil];
    
    // action.frame = CGRectMake(12, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    action.actionSheetStyle=UIActionSheetStyleDefault;
    [action showInView:self.view];
    [action release];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
            [self  saveTheUrlInFav];
        default:
            break;
    }
    
}

-(void)saveTheUrlInFav
{
    [arrayFav addObject:stringScanned];
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Saved"
                                                       message:nil 
                                                      delegate:self
                                             cancelButtonTitle:@"OK" 
                                             otherButtonTitles: nil];
    [alerView show];
    [alerView release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    if(isPort == 1)
//        webViewScan.frame = CGRectMake(0,
//                                       0,
//                                       768,
//                                       916);
//    else
//        webViewScan.frame = CGRectMake(0,
//                                       0,
//                                       1024,
//                                       660);
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(rotate)
//                                                 name:NOTIFICATIONMODEPORT object:nil];
//}
//
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATIONMODEPORT object:nil];
//}
//-(void)rotate
//{
//    if(isPort == 1)
//        webViewScan.frame = CGRectMake(0,
//                                       0,
//                                       768,
//                                       916);
//    else
//        webViewScan.frame = CGRectMake(0,
//                                       0,
//                                       1024,
//                                       660);
//    
//    
//}

#define mark -button Action-

-(IBAction)favouritesNav:(id)sender
{
    FavViewController *FavController = [[FavViewController alloc] init];
    [self.navigationController pushViewController:FavController 
                                         animated:YES];
    [FavController release];
}
-(IBAction)QRImageShow:(id)sender
{
    EnquiryFormViewController *EnquiryViewController = [[EnquiryFormViewController alloc] initWithNibName:@"EnquiryViewController_iPad" bundle:nil];
    
    [self.navigationController pushViewController:EnquiryViewController 
                                         animated:YES];
    [EnquiryViewController release];

//    QRImageViewController *QRImageController = [[QRImageViewController alloc] init];
//    [self.navigationController pushViewController:QRImageController 
//                                         animated:YES];
//    [QRImageController release];
}

-(IBAction)EnquiryForm:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark -searchba delegate-

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [webViewScan loadRequest:[NSURLRequest 
              requestWithURL:[NSURL 
               URLWithString:searchBar.text]]];
    [searchBarScan resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBarScan resignFirstResponder];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    self.navigationItem.backBarButtonItem    = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                                style:UIBarButtonItemStyleDone
                                                                               target:nil 
                                                                               action:nil];
    [self.navigationItem setTitle:@"DOMUS QR"];
 
    searchBarScan.delegate   = self;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view
                                              animated:YES];
    hud.labelText = @"Loading...";

    webViewScan.delegate = self;
    UIScrollView *sv = [webViewScan.subviews objectAtIndex:0];
    [sv setZoomScale:4.0 animated:YES];
    
    webViewScan.scalesPageToFit = YES;
    [webViewScan loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:stringScanned]]];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -Webview Delegate-

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    searchBarScan.text = [[request  URL] absoluteString];
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info"
                                                    message:@"Error in Network"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    
    [MBProgressHUD hideHUDForView:self.navigationController.view 
                         animated:YES];

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    if(UIInterfaceOrientationPortrait   == interfaceOrientation || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
//    {
//        [webViewScan setFrame:CGRectMake(0, 
//                                         44, 
//                                         768, 872)];
//        
//    }
//    else
//        [webViewScan setFrame:CGRectMake(0, 
//                                         44, 
//                                         1024, 
//                                         616)];
    // Return YES for supported orientations
	return ( interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
