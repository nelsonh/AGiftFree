//
//  UpdateGiftsViewController.m
//  AGiftFree
//
//  Created by Nelson on 2/17/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "UpdateGiftsViewController.h"
#import "AGiftFreeAppDelegate.h"
#import "NewGiftItem.h"
#import "NSData+Base64.h"
#import "AGiftWebService.h"

@implementation UpdateGiftsViewController

@synthesize updateLabel;
@synthesize activityView;

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
	
	[activityView startAnimating];
	
    [super viewDidLoad];
	
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
	
	self.updateLabel=nil;
	self.activityView=nil;
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark methods
-(void)receiveNewGiftList
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	//send request gift list to server
	//NSOperationQueue *opQueue=[[NSOperationQueue new] autorelease];
	AGiftWebService *service=[[AGiftWebService alloc] initAGiftWebService];
	[service setDelegate:self];
	[appDelegate.mainOpQueue addOperation:service];
	[service ReceiveNewGiftList:appDelegate.userPhoneNumber];
	[service release];

}

#pragma mark IBAction methods

#pragma mark AGiftWebServiceDelegate
-(void)aGiftWebService:(AGiftWebService*)webService ReceiveNewGiftsArray:(NSArray*)respondData
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];

	//first download respond data
	
	if([respondData count]==0)
	{
		//has no new gifts
		[appDelegate setHasNewGifts:NO];
		
		[self dismissModalViewControllerAnimated:YES];
	}
	else 
	{
		appDelegate.hasNewGifts=YES;
		
		//update gift status
		for(int j=0; j<[respondData count]; j++)
		{
			NSDictionary *inputData=[respondData objectAtIndex:j];
			NSString *giftID;
			NSString *status=@"1";
			
			giftID=[inputData valueForKey:@"GiftID"];
			
			//NSOperationQueue *opQueue=[[NSOperationQueue new] autorelease];
			AGiftWebService *service=[[AGiftWebService alloc] initAGiftWebService];
			[service setDelegate:self];
			[appDelegate.mainOpQueue addOperation:service];
			[service setGiftStatusWithGiftID:giftID Status:status];
			[service release];
		}
		
		//gift item container
		NSMutableArray *giftItemContainer=[[NSMutableArray alloc] init];
		
		for(int i=0; i<[respondData count]; i++)
		{
			NewGiftItem *giftItem=[[NewGiftItem alloc] init];
			NSDictionary *inputData=[respondData objectAtIndex:i];
			NSDateFormatter *dateTimeFormatter=[[NSDateFormatter alloc] init];
			NSDate *giftOpenDateTime;
			
			//setup date time format
			[dateTimeFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"US"] autorelease]];
			[dateTimeFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss aa"];
			[dateTimeFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
			[dateTimeFormatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
			
			//fill data
			[giftItem setReceiveTime:[NSDate date]];
			
			[giftItem setGiftID:[inputData valueForKey:@"GiftID"]];
			
			NSNumber *iconID=[inputData valueForKey:@"smallGiftNum"];
			[giftItem setGiftIconID:[iconID stringValue]];
			
			[giftItem setSenderID:[inputData valueForKey:@"SenderID"]];
			
			[giftItem setSenderPicURL:[inputData valueForKey:@"SenderPicUri"]];
			
			[giftItem setSenderName:[inputData valueForKey:@"SenderName"]];
			
			NSNumber *defMusic=[inputData valueForKey:@"giftDefMusicNum"];
			NSNumber *giftNum=[inputData valueForKey:@"giftNum"];
			NSNumber *giftBoxNum=[inputData valueForKey:@"giftBoxNum"];
			NSNumber *gift3DNum=[inputData valueForKey:@"gift3dNum"];
			NSNumber *giftBox3DNum=[inputData valueForKey:@"giftBox3dNum"];
			
			[giftItem setGiftDefMusicNum:[defMusic stringValue]];
			[giftItem setGiftNum:[giftNum stringValue]];
			[giftItem setGiftBoxNum:[giftBoxNum stringValue]];
			[giftItem setGift3DNum:[gift3DNum stringValue]];
			[giftItem setGiftBox3DNum:[giftBox3DNum stringValue]];
			
			//convert date format
			NSString *dateString=[inputData valueForKey:@"strCanOpenTime"];
			
			giftOpenDateTime=[dateTimeFormatter dateFromString:dateString];
			[giftItem setStrCanOpenTime:giftOpenDateTime];
			
			
			//update gift item status
			[giftItem updateStatus];
			
			//add to gift container
			[giftItemContainer addObject:giftItem];
			
			[dateTimeFormatter release];
			[giftItem release];
			
			//anonymous
			NSNumber *anonymousCode=[inputData valueForKey:@"AnonymousCode"];
			
			if([anonymousCode intValue]==2)
			{
				[giftItem setAnonymous:[NSString stringWithFormat:@"%i", [anonymousCode integerValue]]];
				[giftItem setSenderName:@"Anonymous"];
				[giftItem setSenderID:@"Anonymous"];
			}
			else 
			{
				[giftItem setAnonymous:[NSString stringWithFormat:@"%i", [anonymousCode integerValue]]];
			}
			
		}
		
		//has new gift save those gift info into core data
		[appDelegate.dataManager addNewGiftItemWithArray:giftItemContainer];
		
		[giftItemContainer release];
		
		[self dismissModalViewControllerAnimated:YES];
	}

}

-(void)viewDidAppear:(BOOL)animated
{
	[self performSelector:@selector(receiveNewGiftList)];
}

-(void)viewDidDisappear:(BOOL)animated
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	[appDelegate presentNewGiftNotifyView];
}

- (void)dealloc {
	
	[updateLabel release];
	[activityView release];
	
    [super dealloc];
}


@end
