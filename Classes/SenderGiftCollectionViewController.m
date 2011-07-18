//
//  SenderGiftCollectionViewController.m
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "SenderGiftCollectionViewController.h"
#import "AGiftFreeAppDelegate.h"
#import "GiftSubViewController.h"
#import "NewGiftItem.h"
#import "GiftSectionViewController.h"
#import "GiftCollectionTableCell.h"
#import "TableHeaderView.h"

@implementation SenderGiftCollectionViewController

@synthesize senderImageView;
@synthesize senderNameLabel;
@synthesize galleryScrollView;
@synthesize activityView;
@synthesize senderInfo;
@synthesize scrollviewSouceData;
@synthesize senderPhotoConnection;
@synthesize senderTempPhoto;
@synthesize table;
@synthesize tableSourceData;
@synthesize senderPhoneNumberLabel;
@synthesize selectedIndexPath;
@synthesize hintButton;
@synthesize hintController;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	
	UIBarButtonItem *editButton=[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editTable:)];
	self.navigationItem.rightBarButtonItem=editButton;
	[editButton release];
	 
	
	editTable=NO;
	
	[senderNameLabel setText:[NSString stringWithFormat:@"%@", senderInfo.senderName]];
	[senderPhoneNumberLabel setText:[NSString stringWithFormat:@"Phone number: %@", senderInfo.senderPhoneNumber]];
	
	//sender photo
	if([senderInfo.senderPhoneNumber isEqualToString:@"Anonymous"])
	{
		[senderImageView setImage:[UIImage imageNamed:@"AUser2.png"]];
	}
	else 
	{
		[activityView startAnimating];
		
		self.senderTempPhoto=[[NSMutableData alloc] init];
		NSURL *url=[NSURL URLWithString:senderInfo.senderPicURL];
		NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
		NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
		self.senderPhotoConnection=connection;
		[connection release];
	}


	[table setBackgroundColor:[UIColor clearColor]];
	//self.scrollviewSouceData=[appDelegate.dataManager retrieveOldGiftItemsWithSenderPhoneNumber:senderInfo.senderPhoneNumber];
	self.tableSourceData=[self sortByDate:[appDelegate.dataManager retrieveOldGiftItemsWithSenderPhoneNumber:senderInfo.senderPhoneNumber]];
	
	[senderImageView.layer setCornerRadius:10.0f];
	[senderImageView.layer setMasksToBounds:YES];
	
	/*
	//init scrollview
	[galleryScrollView initialize];
	 */
	
	[table setSeparatorColor:[UIColor grayColor]];
	
	
    [super viewDidLoad];
}

#pragma mark NSURLConnection delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[senderTempPhoto appendData:data];
	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{	
	[senderImageView setImage:[UIImage imageWithData:senderTempPhoto]];
	
	[activityView stopAnimating];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	
	self.senderImageView=nil;
	self.senderNameLabel=nil;
	self.galleryScrollView=nil;
	self.activityView=nil;
	self.table=nil;
	self.senderPhoneNumberLabel=nil;
	self.hintButton=nil;
	self.hintController=nil;
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark methods
-(void)editTable:(id)sender
{
	UIBarButtonItem *buttonItem=sender;
	/*
	
	
	if([scrollviewSouceData count]==0)
	{
		UIAlertView *noItemToEditAlert=[[UIAlertView alloc] initWithTitle:@"NO gift" message:@"No gift can edit" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[noItemToEditAlert show];
		[noItemToEditAlert release];
	}
	else 
	{
		if(editImage==NO)
		{
			editImage=YES;
			[galleryScrollView startEditItem];
			[buttonItem setTitle:@"Done"];
		}
		else if(editImage==YES)
		{
			editImage=NO;
			[galleryScrollView stopEditItem];
			[buttonItem setTitle:@"Edit"];
		}
	}
	 */
	
	
	if(editTable==NO)
	{
		editTable=YES;
		[buttonItem setStyle:UIBarButtonItemStyleDone];
		[buttonItem setTitle:@"Done"];
	}
	else if(editTable==YES)
	{
		editTable=NO;
		[buttonItem setStyle:UIBarButtonItemStylePlain];
		[buttonItem setTitle:@"Edit"];
	}
	
	[table reloadData];

}

-(NSMutableDictionary*)sortByDate:(NSMutableArray*)oldGiftList
{
	NSMutableDictionary *dictionary=[[[NSMutableDictionary alloc] init] autorelease];
	
	NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
	[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"US"] autorelease]];
	[dateFormatter setDateFormat:@"MMM yyyy"];
	
	for(int i=0; i<[oldGiftList count]; i++)
	{
		OldGiftItem *oldGift=[oldGiftList objectAtIndex:i];
		
		NSString *receiveDate=[dateFormatter stringFromDate:oldGift.receiveTime];
		
		//check date is in dic key
		if([dictionary objectForKey:receiveDate]!=nil)
		{
			//date key exist
			NSMutableArray *giftArray=[dictionary objectForKey:receiveDate];
			
			//add gift
			[giftArray addObject:oldGift];
		}
		else 
		{
			//date key is not exist
			NSMutableArray *giftArray=[NSMutableArray arrayWithObject:oldGift];
			
			//add key and object to dic
			[dictionary setObject:giftArray forKey:receiveDate];
			
		}
		
	}
	
	[dateFormatter release];
	
	return dictionary;
}

-(void)reloadData
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	self.tableSourceData=[self sortByDate:[appDelegate.dataManager retrieveOldGiftItemsWithSenderPhoneNumber:senderInfo.senderPhoneNumber]];
	[table reloadData];
}

#pragma mark IBAction Method
-(IBAction)hintButtonPress
{
	if(hintController)
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
		[UIView setAnimationDuration:1.0];
		
		[self.view addSubview:hintController.view];
		
		[UIView commitAnimations];
	}
}

#pragma mark UIScrollView delegate

#pragma mark GiftGalleryScrollViewSourceDataDelegate
-(NSUInteger)numberOfItemInContentWithGiftGalleryScrollView:(GiftGalleryScrollView*)giftGalleryScrollView
{
	return [scrollviewSouceData count];
}

-(NSString*)GalleryScrollView:(GiftGalleryScrollView*)giftGalleryScrollView giftImageFileNameForIndex:(NSUInteger)index
{
	OldGiftItem *item=[scrollviewSouceData objectAtIndex:index];
	
	NSString *imageFileName=[item.giftIconPrefix stringByAppendingString:[item.giftIconID stringByAppendingString:item.giftIconFormat]];
	
	return imageFileName;
}

#pragma mark GiftGalleryScrollViewDelegate
-(void)GalleryScrollView:(GiftGalleryScrollView*)giftGalleryScrollView didDeleteItemWithIndex:(NSUInteger)index
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[scrollviewSouceData removeObjectAtIndex:index];
	
	if([scrollviewSouceData count]==0)
	{
		//restore right bar button to default
		editTable=NO;
		[self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
	}
	
	//save giflt collection into device
	[appDelegate.dataManager saveSenderGiftCollectionWithSenderPhoneNumber:senderInfo.senderPhoneNumber WithGiftCollection:scrollviewSouceData];
	
}

-(void)GalleryScrollView:(GiftGalleryScrollView*)giftGalleryScrollView didSelectItemWithIndex:(NSUInteger)index
{
	//push gift sub controller
	OldGiftItem *item=[scrollviewSouceData objectAtIndex:index];
	
	GiftSubViewController *giftController=[[GiftSubViewController alloc] initWithNibName:@"GiftSubViewController" bundle:nil];
	[giftController setGiftItem:(NewGiftItem*)item];
	[giftController setPlayBoxOpenVideo:NO];
	[giftController setShouldPlayMusicBegin:YES];
	[self.navigationController pushViewController:giftController animated:YES];
	[giftController release];
	
}

#pragma mark table view data source methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [[tableSourceData allKeys] count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSArray *keys=[tableSourceData allKeys];
	NSString *date=[keys objectAtIndex:section];
	NSArray *giftList=[tableSourceData objectForKey:date];
	
	return [giftList count];
}

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSArray *keys=[tableSourceData allKeys];
	NSString *dateStr=[keys objectAtIndex:section];
	
	return dateStr;
}
*/

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *GiftCollectionTableCellIdentifer=@"GiftCollectionTableCell";
	
	GiftCollectionTableCell *cell=(GiftCollectionTableCell*)[tableView dequeueReusableCellWithIdentifier:GiftCollectionTableCellIdentifer];
	
	if(cell==nil)
	{
		//create a new one
		NSArray *tableCellNib=[[NSBundle mainBundle] loadNibNamed:@"GiftCollectionTableCell" owner:self options:nil];
		
		for(id tableCellModel in tableCellNib)
		{
			if([tableCellModel isKindOfClass:[GiftCollectionTableCell class]])
			{
				cell=(GiftCollectionTableCell*)tableCellModel;
				[cell.giftImageView.layer setCornerRadius:10.0f];
				[cell.giftImageView.layer setMasksToBounds:YES];
			}
		}
	}
	
	//AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory=[paths objectAtIndex:0];
	
	NSUInteger section=[indexPath section];
	NSUInteger row=[indexPath row];
	NSArray *keys=[tableSourceData allKeys];
	NSString *dateStr=[keys objectAtIndex:section];
	NSArray *giftList=[tableSourceData objectForKey:dateStr];
	OldGiftItem *giftItem=[giftList objectAtIndex:row];
	
	NSString *receiveDateStr;
	NSString *autoDeletionStr;
	NSString *beforeMsg;
	
	NSDateFormatter *dateFormatter=[[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"US"] autorelease]];
	[dateFormatter setDateFormat:@"MMM d, yyyy"];
	
	//receive time
	receiveDateStr=[dateFormatter stringFromDate:giftItem.receiveTime];
	
	//auto deletion
	/*
	NSUInteger autoDeletePeriod=appDelegate.userAutoDeletionPeriod;
	
	if(autoDeletePeriod==0)
	{
		autoDeletionStr=[NSString stringWithString:@"Never"];
	}
	else 
	{
		autoDeletionStr=[NSString stringWithFormat:@"%i months", autoDeletePeriod];
	}
	 */
	autoDeletionStr=giftItem.autoDeleteDate;
	
	//before msg
	beforeMsg=giftItem.giftBeforeText;
	
	//gift photo
	NSString *imageFileName=[giftItem.giftIconPrefix stringByAppendingString:[giftItem.giftIconID stringByAppendingString:giftItem.giftIconFormat]];
	NSString *imageFullPath=[docDirectory stringByAppendingPathComponent:imageFileName];
	
	//accessory view
	if(editTable)
	{
		UIImageView *accessoryImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pan.png"] highlightedImage:nil];
		[accessoryImageView setFrame:CGRectMake(0, 0, 25, 25)];
		[cell setAccessoryView:accessoryImageView];
		[accessoryImageView release];
	}
	else 
	{
		[cell setAccessoryView:nil];
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

	}

	
	
	[cell.receiveTimeLabel setText:receiveDateStr];
	[cell.autoDeletionLabel setText:autoDeletionStr];
	[cell.beforeMsgLabel setText:beforeMsg];
	[cell.giftImageView setImage:[UIImage imageWithContentsOfFile:imageFullPath]];
	
	return cell;
}

#pragma mark table view delegate methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kNewTableCellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	self.selectedIndexPath=indexPath;
	
	if(editTable)
	{
		UIActionSheet *editSheet=[[UIActionSheet alloc] initWithTitle:@"Edit" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles:@"Never delete", @"Auto delete", nil];
		[editSheet showInView:appDelegate.rootController.view];
		[editSheet release];
		
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
	else 
	{
		NSUInteger section=[indexPath section];
		NSUInteger row=[indexPath row];
		NSArray *keys=[tableSourceData allKeys];
		NSString *dateStr=[keys objectAtIndex:section];
		NSArray *giftList=[tableSourceData objectForKey:dateStr];
		OldGiftItem *item=[giftList objectAtIndex:row];
		
		GiftSubViewController *giftController=[[GiftSubViewController alloc] initWithNibName:@"GiftSubViewController" bundle:nil];
		[giftController setGiftItem:(NewGiftItem*)item];
		[giftController setPlayBoxOpenVideo:NO];
		[giftController setShouldPlayMusicBegin:YES];
		[self.navigationController pushViewController:giftController animated:YES];
		[giftController release];
		
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	}


}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	NSArray *keys=[tableSourceData allKeys];
	NSString *headerStr=[keys objectAtIndex:section];
	TableHeaderView *headerView;
	
	NSArray *fromNib=[[NSBundle mainBundle] loadNibNamed:@"TableHeader" owner:self options:nil];
	
	for(id viewModel in fromNib)
	{
		if([viewModel isKindOfClass:[TableHeaderView class]])
		{
			headerView=(TableHeaderView*)viewModel;
			[headerView.dateLabel setText:headerStr];
			
			return headerView;
		}
	}
	
	return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return kTableHeaderHeight;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	NSUInteger section=[selectedIndexPath section];
	NSUInteger row=[selectedIndexPath row];
	
	NSArray *keys=[tableSourceData allKeys];
	NSString *selectedKey=[keys objectAtIndex:section];
	
	NSMutableArray *objects=[tableSourceData objectForKey:selectedKey];
	OldGiftItem *selectedGift=[objects objectAtIndex:row];
	
	if(buttonIndex==0)
	{
		//delete old gift
		if(selectedIndexPath)
		{
			//dele from datatbase
			[appDelegate.dataManager removeOldGiftFromSenderID:selectedGift.senderID GiftID:selectedGift.giftID];
			
			[objects removeObjectAtIndex:row];
			
			[table deleteRowsAtIndexPaths:[NSArray arrayWithObject:selectedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			
			[self reloadData];
			
		}
		
	}
	else if(buttonIndex==1)
	{
		[appDelegate.dataManager updateOldGiftAutoDeletionFromSenderID:selectedGift.senderID GiftID:selectedGift.giftID AutoDeletionDate:@"Never"];
		[self reloadData];
	}
	else if(buttonIndex==2)
	{
		if(appDelegate.userAutoDeletionPeriod!=0)
		{
			NSCalendar *calendar=[NSCalendar currentCalendar];
			NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
			[comps setMonth:appDelegate.userAutoDeletionPeriod];
			
			NSDate *deleteDate=[calendar dateByAddingComponents:comps toDate:appDelegate.deletionStartDate options:0];
			NSDateFormatter *dateFormatter=[[[NSDateFormatter alloc] init] autorelease];
			
			[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"US"] autorelease]];
			[dateFormatter setDateFormat:@"MMM d, yyyy"];
			
			NSString *autoDeleteDate=[dateFormatter stringFromDate:deleteDate];
			
			[appDelegate.dataManager updateOldGiftAutoDeletionFromSenderID:selectedGift.senderID GiftID:selectedGift.giftID AutoDeletionDate:autoDeleteDate];
		}
		else 
		{
			[appDelegate.dataManager updateOldGiftAutoDeletionFromSenderID:selectedGift.senderID GiftID:selectedGift.giftID AutoDeletionDate:@"Never"];
		}
		
		[self reloadData];
	}

}


-(void)viewDidAppear:(BOOL)animated
{
	
}

-(void)viewWillAppear:(BOOL)animated
{
	//stop playing sound
	[(GiftSectionViewController*)self.navigationController stopPlayingSound];
	
	[self reloadData];
}

- (void)dealloc {
	
	[galleryScrollView release];
	[senderImageView release];
	[senderNameLabel release];
	[activityView release];
	[scrollviewSouceData release];
	[table release];
	[tableSourceData release];
	[senderPhoneNumberLabel release];
	[hintButton release];
	[hintController release];
	
	if(senderTempPhoto!=nil)
		[senderTempPhoto release];
	
	if(senderPhotoConnection)
	{
		self.senderPhotoConnection=nil;
	}
	
    [super dealloc];
}


@end
