//
//  OldGiftItem.m
//  AGiftFree
//
//  Created by Nelson on 3/16/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "OldSenderInfo.h"
#import "OldTableViewCell.h"
#import "OldGiftTableController.h"
#import "AGiftFreeAppDelegate.h"


@implementation OldSenderInfo

@synthesize senderPhoneNumber;
@synthesize senderPicURL;
@synthesize senderName;
@synthesize senderGiftPlist;
@synthesize senderTempPhoto;
@synthesize downloadConnection;
@synthesize numberOfGift;
@synthesize oldGiftController;
@synthesize isfinishedPhotoDownload;
@synthesize cell;


-(void)loadSenderPhotoWithTable:(OldGiftTableController*)tableController
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	self.oldGiftController=tableController;
	
	/*
	//thread to load user photo avoid freezing
	NSOperationQueue *opQueue=[[NSOperationQueue new] autorelease];
	NSInvocationOperation *operation=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doLoadSenderPhotoFromURL) object:nil];
	[opQueue addOperation:operation];
	[operation release];
	 */
	
	self.senderTempPhoto=[[NSMutableData alloc] init];
	NSURL *url=[NSURL URLWithString:senderPicURL];
	NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
	NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
	self.downloadConnection=connection;
	[connection release];
	
	[appDelegate startNetworkActivity];
	
	self.isfinishedPhotoDownload=NO;
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
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	/*
	//visually
	if(cell!=nil)
	{
		[cell.senderImageView setImage:[UIImage imageWithData:senderTempPhoto]];
		[cell.activityView stopAnimating];
	}
	 */
	[appDelegate stopNetworkActivity];
	self.isfinishedPhotoDownload=YES;
	[oldGiftController.table reloadData];
	
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"sender photo download fail");
}

-(void)updateSenderInfo:(OldTableViewCell*)inCell
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	self.cell=inCell;
	
	//NSOperationQueue *opQueue=[[NSOperationQueue new] autorelease];
	AGiftWebService *service=[[AGiftWebService alloc] initAGiftWebService];
	[service setDelegate:self];
	[appDelegate.mainOpQueue addOperation:service];
	[service trackFriendInfo:appDelegate.userPhoneNumber FriendID:senderPhoneNumber];
	[service release];
}

#pragma mark AGiftWebServiceDelegate
-(void)aGiftWebService:(AGiftWebService*)webService trackFriendInfoDictionary:(NSDictionary*)respondData
{
	if(respondData)
	{
		NSString *strName=[NSString stringWithString:[respondData valueForKey:@"FriendName"]];
		
		[cell.senderNameLabel setText:strName];
	}
	else 
	{
		[cell.senderNameLabel setText:@"Not exist"];
	}

}

-(void)dealloc
{
	[senderPhoneNumber release];
	[senderPicURL release];
	[senderName release];
	[senderGiftPlist release];
	[numberOfGift release];
	
	if(senderTempPhoto!=nil)
		[senderTempPhoto release];
	
	if(downloadConnection)
	{
		//[downloadConnection cancel];
		self.downloadConnection=nil;
	}
	
	[super dealloc];
}

@end
