//
//  SplashScreenViewController.m
//  BarCodeReader
//
//  Created by Rohit Dhawan on 04/10/11.
//  Copyright 2011sinhagaurav010@gmail.com. All rights reserved.
//

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
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//    UIImageView *imageBackGrnd = [[UIImageView alloc] initWithFrame:self.view.frame];
//    imageBackGrnd.image = [UIImage imageNamed:@"DefaultDom.jpg"];
//    [self.view addSubview:imageBackGrnd];
//    

    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(goToScanning)
                                   userInfo:nil
                                    repeats:NO];
    
    
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
