//
//  OldGiftTableController.m
//  AGiftFree
//
//  Created by Nelson on 2/22/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "OldGiftTableController.h"
#import "OldTableViewCell.h"
#import "GiftBoxSubViewController.h"
#import "GiftSectionRootViewController.h"
#import "AGiftFreeAppDelegate.h"
#import "OldSenderInfo.h"
#import "SenderGiftCollectionViewController.h"

@implementation OldGiftTableController


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
	
	self.tableSourceData=[appDelegate.dataManager retrieveSenderInfo];
	
	[super viewDidLoad];
}

-(void)viewDidUnload
{
	self.rootViewController=nil;
	self.hintButton=nil;
	self.hintController=nil;
	
	[super viewDidLoad];
}

#pragma mark methods
-(void)reloadSourceData
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	

	self.tableSourceData=[appDelegate.dataManager retrieveSenderInfo];
	
	[table reloadData];

	
	/*
	NSMutableArray *senderList=[appDelegate.dataManager retrieveSenderInfo];
	
	int startIndex;
	
	if(self.tableSourceData)
	{
		if([senderList count]>[tableSourceData count])
		{
			startIndex=[tableSourceData count];
			
		}
	}
	
	for(int i=startIndex; i<[senderList count]; i++)
	{
		[tableSourceData addObject:[senderList objectAtIndex:i]];
	}
	
	[table reloadData];
	 */
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
	static NSString *OldGiftTableCellIdentifer=@"OldGiftTableCellIdentifer";
	
	OldTableViewCell *cell=(OldTableViewCell*)[tableView dequeueReusableCellWithIdentifier:OldGiftTableCellIdentifer];
	
	if(cell==nil)
	{
		//create a new one
		NSArray *tableCellNib=[[NSBundle mainBundle] loadNibNamed:@"OldTableViewCell" owner:self options:nil];
		
		for(id tableCellModel in tableCellNib)
		{
			if([tableCellModel isKindOfClass:[OldTableViewCell class]])
			{
				cell=(OldTableViewCell*)tableCellModel;
				[cell.senderImageView.layer setCornerRadius:10.0f];
				[cell.senderImageView.layer setMasksToBounds:YES];
			}
		}
	}
	
	
	OldSenderInfo *senderInfo=[tableSourceData objectAtIndex:[indexPath row]];
	[senderInfo setOldGiftController:self];
	
	//NSString *senderName=senderInfo.senderName;
	
	int numberGift=[senderInfo.numberOfGift intValue];
	NSString *amountOfGift;
	
	if(numberGift<=1)
	{
		amountOfGift=[NSString stringWithFormat:@"%i Gift", numberGift];
	}
	else 
	{
		amountOfGift=[NSString stringWithFormat:@"%i Gifts", numberGift];
	}

	NSString *numberOfGift=[NSString stringWithFormat:@"%@", amountOfGift];
	
	
	//deal with sender photo
	if(senderInfo.senderTempPhoto==nil)
	{
		//no image temp data tell data side to load from server
		[senderInfo loadSenderPhotoWithTable:self];
	}
	else if(senderInfo.isfinishedPhotoDownload)
	{
		[cell.senderImageView setImage:[UIImage imageWithData:senderInfo.senderTempPhoto]];
	}
	else 
	{
		if(cell.senderImageView.image==nil)
			[cell.senderImageView setImage:[UIImage imageNamed:@"AUser2.png"]];
	}

	

	[cell.giftBoxImageView setImage:[UIImage imageNamed:@"gift1-2.png"]];
	[cell.senderNameLabel setText:@"Updating..."];
	[cell.numberOfGiftLabel setText:numberOfGift];
	
	[senderInfo updateSenderInfo:cell];
	
	return cell;
}

#pragma mark table view delegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kOldTableCellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//TODO: tell navi controller to push sender gifts collection view
	
	OldSenderInfo *senderInfo=[tableSourceData objectAtIndex:[indexPath row]];
	
	SenderGiftCollectionViewController *giftCollectionController=[[SenderGiftCollectionViewController alloc] initWithNibName:@"SenderGiftCollectionViewController" bundle:nil];
	
	[giftCollectionController setSenderInfo:senderInfo];
	
	[rootViewController.navigationController pushViewController:giftCollectionController animated:YES];
	
	[giftCollectionController release];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	if(editingStyle==UITableViewCellEditingStyleDelete)
	{
		//delete from core data
		OldSenderInfo *senderInfo=[tableSourceData objectAtIndex:[indexPath row]];
		
		[appDelegate.dataManager removeSenderInfoAndGiftsWithSendrPhoneNumber:senderInfo.senderPhoneNumber];
		
		
		NSArray *indexPathArray=[NSArray arrayWithObject:indexPath];
		
		//delete from source data
		[tableSourceData removeObjectAtIndex:[indexPath row]];
		
		//delete from table
		[tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
	}
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	

	[table release];
	[rootViewController release];
	[tableSourceData release];
	[hintButton release];
	[hintController release];
	
    [super dealloc];
}


@end
