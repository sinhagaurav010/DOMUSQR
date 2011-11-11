//
//  SplashScreenViewController.m
//  BarCodeReader
//
//  Created by gaurav sinha on 04/10/11.
//  Copyright 2011 sinhagaurav010@gmail.com. All rights reserved.
//

/*
 1.
 The BACK button of the web browser screen – should now read SCAN [not BACK]
 BACK buttons on all other screens are fine.
 
 2.
 We need to clear any favourites or enquiry forms that have been made by the previous user.
 
 Can this be done by:
 Pressing the IPAD HOME button and it returns to the IPAD home screen that includes the DOMUS QR button.
 This action should remove/ delete all saved “favourites” and any completed “enquiry form” information from the DOMUS APP.
 
 Then Press the DOMUS QR button and it goes to the “splash page” and stays there.
 The Splash Page should read/say  “TOUCH TO SCAN”
 The Splash page displays until it is touched.. and   
 then it goes to the Scanning page/camera
 
 I am sorry for misunderstanding for iPad home button.
 Apple does not allow coding for "Home button in device".On pressing it app always in background.What  i am going to do that on touching(if you want then on action of "long Press") the banner in camera screen,app will navigate to Splash screen where all the favourites and enquiry data will remove.And on touching the Splash page,user will have camera screen for scanning.
 
 Let me know what you think?
 
 I am sorry for misunderstanding.
 */

#import "SplashScreenViewController.h"

@implementation SplashScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)goToScanning
{
     HomeViewController *homeController;
    if(iPad == 0)
    {
       
        homeController = [[HomeViewController alloc] init];
        //        [ZBarReaderViewController class];
        //        ZBarReaderViewController *reader;// = (ZBarReaderViewController*)self;
        //        //[self.tabBarController.viewControllers objectAtIndex: 0];
        //        reader.readerDelegate = self;
        //        reader.showsZBarControls = NO;
        //        reader.supportedOrientationsMask = ZBarOrientationMaskAll;
        
     
    }
    else
    {
        homeController = [[HomeViewController alloc] initWithNibName:@"HomeViewController_iPad"
                                                              bundle:nil];
        //        [ZBarReaderViewController class];
        //        ZBarReaderViewController *reader;// = (ZBarReaderViewController*)self;
        //        //[self.tabBarController.viewControllers objectAtIndex: 0];
        //        reader.readerDelegate = self;
        //        reader.showsZBarControls = NO;
        //        reader.supportedOrientationsMask = ZBarOrientationMaskAll;

    }
    [self.navigationController pushViewController:homeController
                                         animated:YES];
    
    [homeController release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget: self
                                                                        action: @selector(goToScanning)];
    
    [self.view addGestureRecognizer: g];
    
    
//    UIImageView *imageBackGrnd = [[UIImageView alloc] initWithFrame:self.view.frame];
//    imageBackGrnd.image = [UIImage imageNamed:@"DefaultDom.jpg"];
//    [self.view addSubview:imageBackGrnd];
//    

//    [NSTimer scheduledTimerWithTimeInterval:1
//                                     target:self
//                                   selector:@selector(goToScanning)
//                                   userInfo:nil
//                                    repeats:NO];
//    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
