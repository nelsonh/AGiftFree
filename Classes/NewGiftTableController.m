//
//  NewGiftTableController.m
//  AGiftFree
//
//  Created by Nelson on 2/22/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "NewGiftTableController.h"
#import "NewTableViewCell.h"
#import "GiftBoxSubViewController.h"
#import "GiftSectionRootViewController.h"
#import "AGiftFreeAppDelegate.h"
#import "NewGiftItem.h"

@implementation NewGiftTableController


@synthesize table;
@synthesize rootViewController;
@synthesize tableSourceData;
@synthesize hintButton;
@synthesize hintController;



-(void)viewDidLoad
{

	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	//set background image
	UIImageView *tableBackground=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
	[table setBackgroundView:tableBackground];
	[tableBackground release];
	
	
	self.tableSourceData=[appDelegate.dataManager retrieveNewGiftList];
	
	[super viewDidLoad];
}

-(void)viewDidUnload
{

	self.rootViewController=nil;
	self.hintButton=nil;
	self.hintController=nil;
	
	[super viewDidLoad];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

#pragma mark methods
-(void)reloadSourceData
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	NSMutableArray *newGiftList=[appDelegate.dataManager retrieveNewGiftList];
	
	int startIndex;
	
	if(self.tableSourceData)
	{
		if([newGiftList count]>[tableSourceData count])
		{
			startIndex=[tableSourceData count];
			
		}
	}
	
	for(int i=startIndex; i<[newGiftList count]; i++)
	{
		[tableSourceData addObject:[newGiftList objectAtIndex:i]];
	}
	
	[table reloadData];
}

-(void)removeGiftFromSourceDataWithGiftID:(NSString*)giftID
{
	int removedIndex=-1;
	
	for(int i=0; i<[tableSourceData count]; i++)
	{
		NewGiftItem *item=[tableSourceData objectAtIndex:i];
		
		if([giftID isEqualToString:item.giftID])
		{
			removedIndex=i;
			break;
		}
	}
	
	if(removedIndex!=-1)
	{
		[tableSourceData removeObjectAtIndex:removedIndex];
	}
}

-(void)disableHint
{
	[hintController closeButtonPress];
}

#pragma mark IBAction methods
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

#pragma mark table view data source methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	if(tableSourceData==nil)
		return 0;
		
	return [tableSourceData count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *NewGiftTableCellIdentifer=@"NewGiftTableCellIdentifier";
	
	NewTableViewCell *cell=(NewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:NewGiftTableCellIdentifer];
	
	if(cell==nil)
	{
		//create a new one
		NSArray *tableCellNib=[[NSBundle mainBundle] loadNibNamed:@"NewTableViewCell" owner:self options:nil];
		
		for(id tableCellModel in tableCellNib)
		{
			if([tableCellModel isKindOfClass:[NewTableViewCell class]])
			{
				cell=(NewTableViewCell*)tableCellModel;
				[cell.senderImageView.layer setCornerRadius:10.0f];
				[cell.senderImageView.layer setMasksToBounds:YES];
			}
		}
	}
	
	//get data by index and fill into cell
	NewGiftItem *item=[tableSourceData objectAtIndex:[indexPath row]];
	
	/*
	//temp not use
	UserPhotoURL *photoURL=[[UserPhotoURL alloc] init];
	[photoURL setIndex:[indexPath row]];
	[photoURL setCell:cell];
	*/
	
	NSString *senderName;
	
	if([item.anonymous isEqualToString:@"1"])
	{
		senderName=@"Anonymous";
	}
	else 
	{
		senderName=item.senderName;
	}

	
	NSDateFormatter *openDateTime=[[NSDateFormatter alloc] init];
	[openDateTime setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"US"] autorelease]];
	[openDateTime setDateFormat:@"MM/dd/yyyy HH:mm:ss aa"];
	NSString *openTime=[openDateTime stringFromDate:item.strCanOpenTime];
	[openDateTime release];
	
	[cell setGiftItem:item];
	
	NSTimeInterval intervalTime=[item.strCanOpenTime timeIntervalSinceNow];
	
	if(intervalTime<=0)
	{
		[cell.giftBoxImageView setImage:[UIImage imageNamed:@"gift1.png"]];
	}
	else
	{
		[cell.giftBoxImageView setImage:[UIImage imageNamed:@"gift2.png"]];
	}
	
	
	if(item.isSecondDownloadComplete)
	{
		//hide dowanload button
		[cell.downloadButton setHidden:YES];
		[cell.downloadActivityView setHidden:YES];
		[cell.downloadActivityView stopAnimating];
		
	}
	else 
	{
		//check if second data is downloading or not
		if(item.isDownloadingSecondData)
		{
			//hide download button
			[cell.downloadButton setHidden:YES];
			
			//start download activity
			[cell.downloadActivityView setHidden:NO];
			[cell.downloadActivityView startAnimating];
			
		}
		else
		{
			//Show download button
			[cell.downloadButton setHidden:NO];
			[cell.downloadActivityView setHidden:YES];
			[cell.downloadActivityView stopAnimating];
			
		}
	}

	//deal with sender photo
	if([item.anonymous isEqualToString:@"1"])
	{
		[cell.senderImageView setImage:[UIImage imageNamed:@"AUser2.png"]];
	}
	else 
	{
		if(item.senderTempPhoto==nil)
		{
			//no image temp data tell data side to load from server
			[item loadSenderPhotoWithTable:self];
		}
		else if(item.isfinishedPhotoDownload)
		{
			[cell.senderImageView setImage:[UIImage imageWithData:item.senderTempPhoto]];
		}
		else 
		{
			if(cell.senderImageView.image==nil)
				[cell.senderImageView setImage:[UIImage imageNamed:@"AUser2.png"]];
		}
	}




	[cell.senderNameLabel setText:senderName];
	[cell.receiveDateTimeLabel setText:openTime];
	
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
	
	//tell navi controller to push gift box sub view
	
	
	NewGiftItem *item=[tableSourceData objectAtIndex:[indexPath row]];
	
	if(item.isSecondDownloadComplete)
	{
		if([item.anonymous isEqualToString:@"1"])
		{
			[appDelegate.dataManager updateNewGiftAnonymousStatus:@"0" WithGiftID:item.giftID];
		}
		
		
		GiftBoxSubViewController *boxController=[[GiftBoxSubViewController alloc] initWithNibName:@"GiftBoxSubViewController" bundle:nil];

		[boxController setGiftItem:item];
		
		[rootViewController.navigationController pushViewController:boxController animated:YES];
		[boxController release];
	}
	else 
	{
		NSString *msg=@"Please click download to download data first";
		UIAlertView *downloadAlert=[[UIAlertView alloc] initWithTitle:@"Download first" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[downloadAlert show];
		[downloadAlert release];
	}

	


	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NewGiftItem *item=[tableSourceData objectAtIndex:[indexPath row]];
	
	if(item.isDownloadingSecondData)
	{
		return UITableViewCellEditingStyleNone;
	}
	
	return UITableViewCellEditingStyleDelete;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	if(editingStyle==UITableViewCellEditingStyleDelete)
	{
		NewGiftItem *item=[tableSourceData objectAtIndex:[indexPath row]];
		
		// tell server to delete this gift
		//NSOperationQueue *opQueue=[NSOperationQueue new];
		AGiftWebService *service=[[AGiftWebService alloc] initAGiftWebService];
		[appDelegate.mainOpQueue addOperation:service];
		[service unOpenDeleteGift:item.giftID];
		[service release];
		
		//delete from core data
		[appDelegate.dataManager removeNewGiftItemWithGiftID:item.giftID];
		
		
		NSArray *indexPathArray=[NSArray arrayWithObject:indexPath];
		
		//delete from source data
		[tableSourceData removeObjectAtIndex:[indexPath row]];
		
		//delete from table
		[tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
		
	}
}

- (void)dealloc {
	
	[table release];
	[rootViewController release];
	[tableSourceData release];
	[hintButton release];
	[hintController release];
	
    [super dealloc];
}

@end
