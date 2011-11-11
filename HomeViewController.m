//
//  HomeViewController.m
//  BarCodeReader
//
//  Created by Rohit Dhawan on 06/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"


@implementation HomeViewController
@synthesize readerView;
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
    [readerView release];
    [cameraSim release];
    [super dealloc];
}

- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) orient
                                 duration: (NSTimeInterval) duration
{
    NSLog(@"here orientation");
    
    orient = UIInterfaceOrientationPortrait;
    // compensate for view rotation so camera preview is not rotated
    [readerView willRotateToInterfaceOrientation: orient
                                        duration: duration];
}

- (void) viewDidAppear: (BOOL) animated
{
    [readerView start];
    
    // run the reader when the view is visible
    //
}

- (void) viewWillDisappear: (BOOL) animated
{
    //if([readerView is])
    [readerView stop] ;
    //readerView.readerDelegate = nil;
    
}

- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
//    if(isStartScan == 1)
//    {
        // do something useful with results
        for(ZBarSymbol *sym in syms) 
        {
            NSLog(@"%@",sym.data);
            
            ///Let the user know scan has successed
            AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);

            //  ResultViewController *ResultController;
            
            //        if(iPad == 0)
            //            ResultController = [[ResultViewController alloc] init];
            //        else
            //            ResultController = [[ResultViewController alloc] initWithNibName:@"ResultViewController_iP6ad" bundle:nil];
            
            imageQRCode = [[UIImage alloc] initWithData:[[NSData alloc]initWithData:UIImagePNGRepresentation(img)]];
            //imageQRCode = img;
            stringScanned = [[NSString alloc] initWithString:sym.data];
            
            isStartScan = 0;
            
            viewBlink = [[AdScreenFlash alloc] initWithFrame:self.view.frame];
            [viewBlink setBackgroundColor:[UIColor whiteColor]];
            [self.view addSubview:viewBlink];
            
            //Set the delegate
            viewBlink.delegate = self;
            
            [viewBlink startFlashAnimation]; 
            
                       
            //[self.navigationController pushViewController:tabBar animated:YES];
            
            //        ResultController.stringUrl = sym.data;
            //        [self.navigationController pushViewController:ResultController animated:YES];
            //        [ResultController release];
            break;
        }
    //}
}

-(void)removeViewFlash 
{
    
    [viewBlink removeFromSuperview];

//    SystemSoundID soundID = 0;
//    NSString* str =  [[NSBundle mainBundle] pathForResource:@"CameraClick" ofType:@"mp3"];
//    CFURLRef soundFileURL = (CFURLRef)[NSURL URLWithString:str ];
//    OSStatus errorCode = AudioServicesCreateSystemSoundID(soundFileURL, &soundID);
//    if (errorCode != 0) {
//        NSLog(@"erorororrrrrrr");
//    }
//    else
//        AudioServicesPlaySystemSound(soundID);

    NSString *path = [[NSBundle mainBundle] pathForResource:@"CameraClick" ofType:@"mp3"];
    AVAudioPlayer* theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
   // theAudio.delegate = self;
    [theAudio play];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    WebBrowserViewController *WebBrowserController = [[WebBrowserViewController alloc] init];
    [self.navigationController pushViewController:WebBrowserController animated:YES];
}
  
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -options-

-(void)Options
{
    pickerOptions.hidden = NO;
}

#pragma mark -EmailTheLink-

-(void)pressDoneForSel:(NSString *)stringSel withindex:(NSInteger)indexRow
{
    pickerOptions.hidden = YES;
    
    if(indexRow == 0)
        isForStaff = 0;
    else
        isForStaff = 1;
}
#pragma mark -Reset-
-(void)Reset
{
    arrayFav = [[NSMutableArray alloc] init];
    //[arrayFav removeAllObjects];
}

-(IBAction)startScan:(id)sender
{
    isStartScan = 1;
}

#pragma mark -ToolBar button-

-(IBAction)clickToFav:(id)sender
{
    FavViewController *favController = [[FavViewController alloc] init];
    [self.navigationController pushViewController:favController
                                         animated:YES];
    [favController release];
}

-(IBAction)clickToEnquiry:(id)sender
{
    EnquiryFormViewController *EnquiryViewController = [[EnquiryFormViewController alloc] initWithNibName:@"EnquiryViewController_iPad" bundle:nil];
    
    [self.navigationController pushViewController:EnquiryViewController animated:YES];
    [EnquiryViewController release];
}


#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad
{
    
    self.navigationItem.backBarButtonItem    = [[UIBarButtonItem alloc] initWithTitle:@"SCAN"
                                                                                style:UIBarButtonItemStyleDone
                                                                               target:nil 
                                                                               action:nil];
    
    //UIView *viewTitle = [[UIView alloc] initWithFrame:self.navigationItem.titleView.frame];
    
    UIImageView *imageViewDomus = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                                0, 
                                                                                768, 
                                                                                44)];
    imageViewDomus.image = [UIImage imageNamed:@"BannerImageDomus.png"];
    [self.view addSubview:imageViewDomus];
   
    //self.navigationItem.titleView = viewTitle;
    //[self.navigationItem setTitleView]
    
    isStartScan = 0;
    isForStaff = 0;
    
    //    arrayOptions = [[NSMutableArray alloc] init];
    //    [arrayOptions addObject:@"Customer"];
    //    [arrayOptions addObject:@"Staff"];
    //    
    //    pickerOptions = [[ViewPickerTool alloc] initWithFrame:CGRectMake(0, 120, 320, 194)];
    //    [self.view addSubview:pickerOptions];
    //    [pickerOptions setClient:self];
    //    pickerOptions.hidden = YES;
    //    
    //    [pickerOptions addTheElement:arrayOptions];
    //    
    //    UIBarButtonItem *newBackButton				= [[UIBarButtonItem alloc] initWithTitle: @"Options" 
    //                                                                         style: UIBarButtonItemStyleBordered
    //                                                                        target:self  
    //                                                                        action:@selector(Options)];
    //    self.navigationItem.rightBarButtonItem = newBackButton;
    //    [newBackButton release];
    //    
    //    UIBarButtonItem *refreshButton				= [[UIBarButtonItem alloc] initWithTitle: @"Reset Favourites" 
    //                                                                         style:UIBarButtonItemStyleBordered
    //                                                                        target:self  
    //                                                                        action:@selector(Reset)];
    //    self.navigationItem.leftBarButtonItem = refreshButton;
    //    [refreshButton release];
    
//    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:.96 green:.643 blue:0.0 alpha:1.0]];
//    [self.navigationItem setTitle:@"Scan"];
    
    arrayFav = [[NSMutableArray alloc] init];
    
    [ZBarReaderView class];
    readerView.readerDelegate = self;
    //readerView.supportedOrientationsMask = supportedOrientationsMask;
    ZBarImageScanner *scanner = readerView.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: 0
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    [scanner setSymbology: ZBAR_QRCODE
                   config: ZBAR_CFG_ENABLE
                       to: 1];    
    //[scanner setSymbology:ZBAR_QRCODE config:ZBAR_CFG_ENABLE to:0];
    
    ///readerView.showsFPS = YES;
    //readerView.scanCrop = CGRectMake(0, 0, 320, 200);
    // you can use this to support the simulator
    
    if(TARGET_IPHONE_SIMULATOR)
    {
        cameraSim = [[ZBarCameraSimulator alloc]
                     initWithViewController: self];
        cameraSim.readerView = readerView;
    }
    
    //[ZBarReaderViewController class];
    //    ZBarReaderViewController *reader = [[ZBarReaderViewController alloc] init];
    //    //[self.tabBarController.viewControllers objectAtIndex: 0];
    //    reader.readerDelegate = self;
    //    reader.showsZBarControls = NO;
    //    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    //    ZBarImageScanner *scanner = reader.scanner;
    //    // TODO: (optional) additional reader configuration here
    //    
    //    // EXAMPLE: disable rarely used I2/5 to improve performance
    //    [scanner setSymbology: ZBAR_I25
    //                   config: ZBAR_CFG_ENABLE
    //                       to: 0];
    //    
    //    // present and release the controller
    //    UINavigationController *navigationCon = [[UINavigationController alloc] initWithRootViewController:reader];
    //    [self.navigationController presentModalViewController: navigationCon
    //                            animated: YES];
    //    [navigationCon release];
    //    [reader release];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
//- (void)  imagePickerController: (UIImagePickerController*) picker
//  didFinishPickingMediaWithInfo: (NSDictionary*) info
//{
//    // do something useful with results
////    UITabBarController *tabs = self.tabBarController;
////    tabs.selectedIndex = 1;
////    UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
////    results.resultImage.image = image;
//    
//    id <NSFastEnumeration> syms =
//    [info objectForKey: ZBarReaderControllerResults];
//    for(ZBarSymbol *sym in syms) {
//        NSLog(@"%@",sym.data);
//  //      results.resultText.text = sym.data;
//        break;
//    }
//}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
//    if(interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
//    {
//        isPort = 1;
//        
//    }
//    else
//    {
//        isPort = 0;
//        //[[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATIONMODELAND      
//        //object:nil];
//    }
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATIONMODEPORT         
//                                                        object:nil];
//    // Return YES for supported orientations
//    return YES;
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);

}

@end
