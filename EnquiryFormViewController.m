//
//  EnquiryFormViewController.m
//  BarCodeReader
//
//  Created by gaurav on 14/09/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "EnquiryFormViewController.h"


@implementation EnquiryFormViewController

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
    
    [fieldTxt1 resignFirstResponder];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -Done-

-(void)Done
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

#pragma mark -Email-

-(void)Email
{
    if ([MFMailComposeViewController canSendMail])
	{
		MFMailComposeViewController *mcvc = [[[MFMailComposeViewController alloc] init] autorelease];
		mcvc.mailComposeDelegate = self;
        
        NSString *stringMsg = @"";
        for(int i=0;i<[arrayElement count];i++)
        {
            stringMsg = [stringMsg stringByAppendingString:[arrayElement objectAtIndex:i]];
            stringMsg = [stringMsg stringByAppendingString:@"<br>"];
            if(i==0)
            {
                stringMsg = [stringMsg stringByAppendingString:[arrayFav componentsJoinedByString:@"<br>"]];
            }
            else
            {
                UITextField *fieldT = [arrayText objectAtIndex:i-1];
                if([fieldT.text length]>0)
                {
                    stringMsg = [stringMsg stringByAppendingString:fieldT.text];
                }
            }
            stringMsg =[ stringMsg stringByAppendingString:@"<br><br>"];
            
        }
        [mcvc setSubject:@"Customer Enquiry Record"];
        
        //NSString *messageBdy = stringTestWeb;
        //if([arrayFav count]>0)
        [mcvc setMessageBody:stringMsg isHTML:YES];
        //else
        //{}//[mcvc setMessageBody:self.stringUrl isHTML:YES];
        
        
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

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [fieldTxt1 resignFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
}
-(void)back
{
    NSMutableDictionary *dictEnq = [[NSMutableDictionary alloc] init];
    for(int i=0;i<[arrayText count];i++)
    {
        if([[[arrayText objectAtIndex:i] text] length]>0)
            [dictEnq setObject:[[arrayText objectAtIndex:i] text] forKey:[arrayElement objectAtIndex:i]];
        else
            [dictEnq setObject:@"" forKey:[arrayElement objectAtIndex:i]];
        
    }
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:dictEnq forKey:ENQDOM];
    
    [prefs synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}


#define mark -getContforKey-

+(id)getContforKey:(NSString*)stringKey
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:stringKey];
}

#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    //[tableViewScan reloadData];
    //NSLog(@"will appear");
}
- (void)viewDidLoad
{
    
    UIBarButtonItem *newBackButton				= [[UIBarButtonItem alloc] initWithTitle: @"Back" 
                                                                         style: UIBarButtonItemStyleBordered
                                                                        target:self  
                                                                        action:@selector(back)];
    self.navigationItem.leftBarButtonItem = newBackButton;
    [newBackButton release];
    
    
    //    arrayFav = [[NSMutableArray alloc] init];
    //    [arrayFav addObject:@"sdf"];
    //    [arrayFav addObject:@"dsf"];
    //    [arrayFav addObject:@"fvfvsdf"];
    
    [self.navigationItem setTitle:@"Enquiry Form"];
    
    //[self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:.96 green:.643 blue:0.0 alpha:1.0]];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    //    UIBarButtonItem *newBackButton				= [[UIBarButtonItem alloc] initWithTitle: @"Done" 
    //                                                                         style: UIBarButtonItemStyleBordered
    //                                                                        target:self  
    //                                                                        action:@selector(Done)];
    //    self.navigationItem.rightBarButtonItem = newBackButton;
    //    [newBackButton release];
    //    
    
    fieldTxt1 = [[UITextField alloc] init];
    
    UIBarButtonItem *mailButton				= [[UIBarButtonItem alloc] initWithTitle: @"Email" 
                                                                      style: UIBarButtonItemStyleBordered
                                                                     target:self  
                                                                     action:@selector(Email)];
    self.navigationItem.rightBarButtonItem = mailButton;
    [mailButton release];
    
    
    arrayText = [[NSMutableArray alloc] init];
    
    arrayElement = [[NSMutableArray alloc] init];
    
    [arrayElement addObject:@"QR PRODUCTS SCANNED"];
    [arrayElement addObject:@"1.PROJECT NAME/TYPE/DETAILS"];
    //[arrayElement addObject:@"CLIENT PROJECT DETAILS"];
    [arrayElement addObject:@"2.PROJECT ADDRESS"];
    [arrayElement addObject:@"3.COMPANY NAME-CLIENT/DESIGNER"];
    [arrayElement addObject:@"4.CONTACT NAME"];
    [arrayElement addObject:@"5.EMAIL"];
    [arrayElement addObject:@"6.TELEPHONE"];
    //[arrayElement addObject:@"NAME"];
    [arrayElement addObject:@"7.ADDRESS"];
    [arrayElement addObject:@"8.POSTCODE"];
    [arrayElement addObject:@"9.DOMUS STAFF/AUTHOR"];
    [arrayElement addObject:@"10.Notes and Follow up"];
    
    //    [arrayElement addObject:@"STAFF NAME"];
    
    NSDictionary *dictEn = [EnquiryFormViewController getContforKey:ENQDOM];
    
    for(int i=0;i<[arrayElement count]-1;i++)
    {
        
        UITextField *fieldTxt = [[UITextField alloc] init];
        if(i==0)
            [fieldTxt becomeFirstResponder];
        if([dictEn objectForKey:[arrayElement objectAtIndex:i]])
            fieldTxt.text = [dictEn objectForKey:[arrayElement objectAtIndex:i]];
        fieldTxt.clearButtonMode = UITextFieldViewModeAlways;
        [arrayText addObject:fieldTxt];
    }
    
    //[fieldTxt1 resignFirstResponder];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -tableview code-

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return [arrayFav count];
    else
        return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [arrayElement objectAtIndex:section];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
	return [arrayElement count];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    NSString *stringCell = @"cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:nil];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringCell];
        if(indexPath.section == 0)
        {
            cell.textLabel.text = [arrayFav objectAtIndex:indexPath.row];
        }
        else
        {
            UITextField *field = [arrayText objectAtIndex:indexPath.section-1];
            
            
            field.frame = CGRectMake(0, 10, 700, 44);
            [cell.contentView addSubview:field];
            
        }
    }
    
    //    fieldBook.frame = CGRectMake(12, 10, cell.frame.size.width-24, cell.frame.size.height);
    //    [cell addSubview:fieldBook];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
	//cell.textLabel.text = [arrayItems objectAtIndex:indexPath.row];
    //    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    //	cell.accessoryType = 1;
	return cell;
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
