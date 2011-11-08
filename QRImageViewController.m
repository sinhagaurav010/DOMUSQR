//
//  QRImageViewController.m
//  TestWebTab
//
//  Created by gaurav on 18/09/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "QRImageViewController.h"


@implementation QRImageViewController

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

-(void)Email
{
    if ([MFMailComposeViewController canSendMail])
	{
		MFMailComposeViewController *mcvc = [[[MFMailComposeViewController alloc] init] autorelease];
		mcvc.mailComposeDelegate = self;
        
       // NSString *stringMsg = @"";
//        for(int i=0;i<[arrayElement count];i++)
//        {
//            stringMsg = [stringMsg stringByAppendingString:[arrayElement objectAtIndex:i]];
//            stringMsg = [stringMsg stringByAppendingString:@"<br>"];
//            if(i==0)
//            {
//                stringMsg = [stringMsg stringByAppendingString:[arrayFav componentsJoinedByString:@"<br>"]];
//            }
//            else
//            {
//                UITextField *fieldT = [arrayText objectAtIndex:i-1];
//                if([fieldT.text length]>0)
//                {
//                    stringMsg = [stringMsg stringByAppendingString:fieldT.text];
//                }
//            }
//            stringMsg =[ stringMsg stringByAppendingString:@"<br><br>"];
//            
//        }
        [mcvc setSubject:@"Please check out this"];
        
        //NSString *messageBdy = stringTestWeb;
        //if([arrayFav count]>0)
       // [mcvc setMessageBody:stringMsg isHTML:YES];
        //else
        //{}//[mcvc setMessageBody:self.stringUrl isHTML:YES];
        
        
		[mcvc addAttachmentData:UIImageJPEGRepresentation(imageQRCode, 1.0f) mimeType:@"image/jpeg" fileName:@"pickerimage.jpg"];
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

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationItem setTitle:@"Scanned QRCode"];

    imageQR.image = imageQRCode;
    
    UIBarButtonItem *mailButton				= [[UIBarButtonItem alloc] initWithTitle: @"Email" 
                                                                      style: UIBarButtonItemStyleBordered
                                                                     target:self  
                                                                     action:@selector(Email)];
    self.navigationItem.rightBarButtonItem = mailButton;
    [mailButton release];

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
