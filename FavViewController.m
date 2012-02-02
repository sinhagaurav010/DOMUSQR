//
//  FavViewController.m
//  TestWebTab
//
//  Created by gaurav on 18/09/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "FavViewController.h"


@implementation FavViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    //[tableViewScan reloadData];
    //NSLog(@"will appear");
}
#pragma mark - View lifecycle

//- (void)viewWillAppear:(BOOL)animated
//{
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//}
- (void)viewDidLoad
{
    [self.navigationItem setTitle:@"Favourites"];
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"Email" 
                                                                         style: UIBarButtonItemStyleBordered
                                                                        target:self  
                                                                        action:@selector(EmailTheLink)];
    self.navigationItem.rightBarButtonItem = newBackButton;
    [newBackButton release];
    
    arrayDel = [[NSMutableArray alloc] init];
    
    for(int i=0;i<[arrayFav count];i++)
    {
        UIButton  *buttonDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonDelete setBackgroundImage:[UIImage imageNamed:@"Delete.png"]
                                forState:UIControlStateNormal];
        [buttonDelete setTag:i];
        [buttonDelete addTarget:self
                         action:@selector(deletefav:)
               forControlEvents:UIControlEventTouchUpInside];
        
        [arrayDel addObject:buttonDelete];
        
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)deletefav:(id)sender
{
    [arrayDel removeObjectAtIndex:[sender tag]];
    [arrayFav removeObjectAtIndex:[sender tag]];
     
    for(int i=0;i<[arrayDel count];i++)
    {
        UIButton *buttonFav = [arrayDel objectAtIndex:i];
        buttonFav.tag = i;
    }
    [tableViewScan reloadData];
}

#define mark -MailComposer-


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    if(result == MFMailComposeResultSent)
    {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Email Sent"
                                                           message:nil 
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK" 
                                                 otherButtonTitles:nil];
        [alerView show];
        [alerView release];

    }
    
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
        [mcvc setSubject:@"List of Domus samples scanned"];
        
        //NSString *messageBdy = stringTestWeb;
        if([arrayFav count]>0)
            [mcvc setMessageBody:[arrayFav componentsJoinedByString:@"<br>"] isHTML:YES];
        
        
        
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

#pragma mark -TableView Code-


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //   if(section == 0)
    return [arrayFav count];
}

-(IBAction)deleteAll:(id)sender
{
    arrayFav = [[NSMutableArray alloc] init];
    [tableViewScan reloadData];
}

-(IBAction)deleteOneByOne:(id)sender
{
    if([[buttonDel title] isEqualToString:@"Delete"])
    {
        isDeleting = 1;
        [tableViewScan reloadData];
        //tableViewScan.editing = YES;
        [buttonDel setTitle:@"Done"];
    }
    else
    {
        isDeleting = 0;
        [tableViewScan reloadData];
        
        [buttonDel setTitle:@"Delete"]; 
        tableViewScan.editing = NO;
        
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [arrayFav removeObjectAtIndex:indexPath.row];
    [tableViewScan reloadData];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    NSString *stringCell = @"cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:nil];
    if(!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringCell] autorelease];
        //cell.textLabel.text = [ar]
    }
    
    if(isDeleting == 1)
    {
        UIButton *button = (UIButton*)[arrayDel objectAtIndex:indexPath.row];
        button.frame = CGRectMake(0, 5, 66, 38);
        [cell.contentView addSubview:button];
        
        [cell.textLabel setFrame:CGRectMake(cell.textLabel.frame.origin.x+40, 
                                            cell.textLabel.frame.origin.y,
                                            cell.textLabel.frame.size.width,
                                            cell.textLabel.frame.size.height)];
        
    }
    //    fieldBook.frame = CGRectMake(12, 10, cell.frame.size.width-24, cell.frame.size.height);
    //    [cell addSubview:fieldBook];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [arrayFav objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
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
