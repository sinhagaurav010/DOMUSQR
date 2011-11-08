//
//  ResultViewController.m
//  BarCodeReader
//
//  Created by gaurav on 08/09/11.
//  Copyright 2011 dhillon. All rights reserved.
//

/*
 Requirements
 
 
 I am opening a new showroom in central London in November. In-store, there will be thousands of tiles, only tile sample colours, size 10cmx10cm, that visiting architects will browse and pick up off hangers to take away, free of charge.
 
 On the back of this tile will be a QR code. They should be able to scan this, and then see more information ONLINE about this tile, i.e size options, other colours available, other finishes, library insitu images. 
 
 The QR code will be linked to a web-product page which they can then navigate [on an iPad], this is being designed at present by my Webmaster. 3 or 4 iPADs will be fixed to our displays near the sample tiles. 
 
 The visitor can do two things:
 
 Scan and view more info about the TILE SAMPLE (ON LINE)
 Scan and save to a list of favourites, and then email the list/ links to themselves/ or others
 
 Staff should be able to: 
 
 Complete a SAMPLE ENQUIRY FORM by scanning the samples, creating a list of items to take-away free. The form is completed with customer and project info/data, and email to other members of staff.
 
 On the iPAD the customer or staff should be able to:
 
 Scan Tile Samples and view more info, make list and email, create enquiry form.
 Switch to iPAD website browser
 Switch to iPAD photo library.
 */


#import "ResultViewController.h"


@implementation ResultViewController
@synthesize stringUrl;
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
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	[self dismissModalViewControllerAnimated:YES];
}


-(void)EmailTheLink
{
    if ([MFMailComposeViewController canSendMail])
	{
		MFMailComposeViewController *mcvc = [[[MFMailComposeViewController alloc] init] autorelease];
		mcvc.mailComposeDelegate = self;
        //        if(isForErr == 1)
        //        {
        //            NSArray *arrayRec = [NSArray arrayWithObjects:@"info@ctlawinfogroup.com",nil];
        //            [mcvc setToRecipients:arrayRec];
        //            [mcvc setSubject:[NSString stringWithFormat:@"Reporting error:%@",self.navigationItem.title]];
        //        }
        //        else
        //        {
        //            [mcvc setSubject:[NSString stringWithFormat:@"%@",self.navigationItem.title]];
        //        }
        [mcvc setSubject:@"Please check out this"];
        
        //NSString *messageBdy = stringTestWeb;
        if([arrayFav count]>0)
            [mcvc setMessageBody:[arrayFav componentsJoinedByString:@"<br>"] isHTML:YES];
        else
            [mcvc setMessageBody:self.stringUrl isHTML:YES];
        
        
		//[mcvc addAttachmentData:UIImageJPEGRepresentation(imageToEmail, 1.0f) mimeType:@"image/jpeg" fileName:@"pickerimage.jpg"];
		[self presentModalViewController:mcvc animated:YES];
	}	
    else
    {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Info"
                                                           message:@"Please Configure Email" 
                                                          delegate:self 
                                                 cancelButtonTitle:@"OK" 
                                                 otherButtonTitles:nil];
        [alerView show];
        [alerView release];
    }
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    
    UIBarButtonItem *newBackButton				= [[UIBarButtonItem alloc] initWithTitle: @"Options" 
                                                                         style: UIBarButtonItemStyleBordered
                                                                        target:self  
                                                                        action:@selector(Options)];
    self.navigationItem.rightBarButtonItem = newBackButton;
    [newBackButton release];
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"Loading...";
    
    [webApp loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:stringUrl]]];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)Options
{
    if(isForStaff == 0)
    {
        UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil 
                                                         delegate:self 
                                                cancelButtonTitle:nil
                                           destructiveButtonTitle:nil 
                                                otherButtonTitles:@"Save to Favourites",@"Email",@"Cancel", nil];
        
        action.actionSheetStyle=UIActionSheetStyleDefault;
        [action showInView:self.view];
        [action release];
    }
    else
    {
        UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil 
                                                         delegate:self 
                                                cancelButtonTitle:nil
                                           destructiveButtonTitle:nil 
                                                otherButtonTitles:@"Save to Favourites",@"Enquiry Form",@"Cancel", nil];
        
        action.actionSheetStyle = UIActionSheetStyleDefault;
        [action showInView:self.view];
        [action release];   
    }
}
#pragma mark -action sheet delegate-

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(isForStaff == 0)
    {
        switch (buttonIndex) {
            case 1:
                [self EmailTheLink];
                break;
            case 0:
                [self  saveTheUrlInFav];
            default:
                break;
        }
    }
    else
    {
        switch (buttonIndex) {
            case 1:
            {
                EnquiryFormViewController *EnquiryFormController;
                
                if(iPad == 0)
                    EnquiryFormController = [[EnquiryFormViewController alloc] init];
                else
                    EnquiryFormController = [[EnquiryFormViewController alloc]initWithNibName:@"EnquiryViewController_iPad" bundle:nil];
                
                UINavigationController *navigationCont = [[UINavigationController alloc] initWithRootViewController:EnquiryFormController];
                [self.navigationController presentModalViewController:navigationCont animated:YES];
                [navigationCont release];
                [EnquiryFormController release];
            }
                break;
            case 0:
                [self  saveTheUrlInFav];
            default:
                break;
        }
    }
}

-(void)saveTheUrlInFav
{
    [arrayFav addObject:self.stringUrl];
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Saved"
                                                       message:nil 
                                                      delegate:self
                                             cancelButtonTitle:@"OK" 
                                             otherButtonTitles: nil];
    [alerView show];
    [alerView release];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -Webview Delegate-

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info"
                                                    message:@"Please Check network connection" 
                                                   delegate:self
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles: nil];
    [alert show];
    [alert release];
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
