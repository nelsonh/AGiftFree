//
//  NewGiftItem.m
//  AGiftFree
//
//  Created by Nelson on 3/8/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "NewGiftItem.h"
#import "NewTableViewCell.h"
#import "AGiftFreeAppDelegate.h"
#import "NSData+Base64.h"
#import "AGiftWebService.h"
#import "NewGiftTableController.h"
#import "GiftSectionViewController.h"
#import "GiftSectionRootViewController.h"



@implementation NewGiftItem

@synthesize giftID;
@synthesize giftIconID;
@synthesize senderID;
@synthesize senderPicURL;
@synthesize senderName;
@synthesize strCanOpenTime;
@synthesize giftBeforeText;
@synthesize giftAfterText;
@synthesize giftPhotoName;
@synthesize giftPhoto;
@synthesize giftSoundID;
@synthesize giftSoundName;
@synthesize giftSound;
@synthesize giftBoxVideoNum;
@synthesize giftVideoNum;
@synthesize giftBox3DNum;
@synthesize gift3DNum;
@synthesize objNumber;
@synthesize giftBoxVideoFileName;
@synthesize giftDefMusicNum;
@synthesize giftNum;
@synthesize giftBoxNum;
@synthesize anonymous;
@synthesize isFirsDownloadComplete;
@synthesize isSecondDownloadComplete;
@synthesize isThirdDownloadComplete;
@synthesize isTotalDownloadComplete;
@synthesize downloadConnection;
@synthesize receiveTime;
@synthesize autoDeleteDate;

@synthesize senderTempPhoto;
@synthesize newGiftController;
@synthesize isDownloadingSecondData;
@synthesize boxPrefix;
@synthesize giftPrefix;
@synthesize giftIconPrefix;
@synthesize giftIconFormat;
@synthesize isfinishedPhotoDownload;

-(id)init
{
	if(self=[super init])
	{
		self.boxPrefix=[[NSString alloc] initWithString:@"box"];
		self.giftPrefix=[[NSString alloc] initWithString:@"gift"];
		self.giftIconPrefix=[[NSString alloc] initWithString:@"giftIcon"];
		self.giftIconFormat=[[NSString alloc] initWithString:@".png"];
	}
	return self;
}

#pragma mark methods
-(void)updateStatus
{
	self.isFirsDownloadComplete=[self checkFirstDownloadPoint];
	self.isThirdDownloadComplete=[self checkThirdDownloadPoint];
	self.isTotalDownloadComplete=[self checkTotalDownloadPoint];
}

-(BOOL)checkFirstDownloadPoint
{
	if(giftID!=nil && senderID!=nil && senderName!=nil && senderPicURL!=nil && strCanOpenTime!=nil && giftDefMusicNum!=nil && giftNum!=nil && giftBoxNum!=nil && giftBox3DNum!=nil && gift3DNum!=nil)
	{
		return YES;
	}
	else 
	{
		return NO;
	}

}



-(BOOL)checkThirdDownloadPoint
{
	if(giftNum!=nil && giftBoxNum!=nil && giftSoundID!=nil)
	{
		return YES;
	}
	else
	{
		return NO;
	}
}

-(BOOL)checkTotalDownloadPoint
{
	if(isFirsDownloadComplete && isSecondDownloadComplete && isThirdDownloadComplete)
	{
		return YES;
	}
	else 
	{
		return NO;
	}

}

-(void)loadSenderPhotoWithTable:(NewGiftTableController*)tableController
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	self.newGiftController=tableController;
	
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
	[newGiftController.table reloadData];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"sender photo download fail");
}

-(void)downloadSecondData
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	BOOL downloadBox3DObj=YES;
	BOOL downloadBoxVideo=YES;
	BOOL downloadGiftIcon=YES;
	
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory=[paths objectAtIndex:0];
	
	//check if gift icon exist or not
	NSString *giftIconName=[giftIconPrefix stringByAppendingString:self.giftIconID];
	downloadGiftIcon=![appDelegate hasFileInPath:docDirectory FileName:giftIconName FileFormat:@"png"];
	
	
	//check if 3d obj and box video exist or not
	NSString *objName=[boxPrefix stringByAppendingString:self.giftBox3DNum];
	NSString *videoName=[boxPrefix stringByAppendingString:self.giftBoxNum];
	downloadBox3DObj=![appDelegate hasFileInPath:docDirectory FileName:objName FileFormat:@"obj"];
	downloadBoxVideo=![appDelegate hasFileInPath:docDirectory FileName:videoName FileFormat:@"mp4"];
	
	
	self.isDownloadingSecondData=YES;
	
	GiftSectionRootViewController*giftRootController=(GiftSectionRootViewController*)[(GiftSectionViewController*)appDelegate.rootController.selectedViewController topViewController];
	self.newGiftController=giftRootController.newGiftViewController;
	
	
	//NSOperationQueue *opQueue=[[NSOperationQueue new] autorelease];
	AGiftWebService *service=[[AGiftWebService alloc] initAGiftWebService];
	[service setDelegate:self];
	[appDelegate.mainOpQueue addOperation:service];
	[service ReceiveFirstData:self.giftID DownloadBox3DObj:downloadBox3DObj DownloadBoxVideo:downloadBoxVideo DownloadGiftIcon:downloadGiftIcon];
	[service release];
}



#pragma mark AGiftWebServiceDelegate
-(void)aGiftWebService:(AGiftWebService*)webService ReceiveFirstDataDictionary:(NSDictionary*)respondData
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory=[paths objectAtIndex:0];
	
	
	if([respondData valueForKey:@"SmallGiftPhoto"]!=[NSNull null])
	{
		NSString *giftIcon64Encoding=[respondData valueForKey:@"SmallGiftPhoto"];
		NSData *giftIcon=[NSData dataWithBase64EncodedString:giftIcon64Encoding];
		
		//save gift icon to device
		NSString *giftIconFullName=[giftIconPrefix stringByAppendingString:[self.giftIconID stringByAppendingString:giftIconFormat]];
		NSString *giftIconSavePath=[docDirectory stringByAppendingPathComponent:giftIconFullName];
		[giftIcon writeToFile:giftIconSavePath atomically:NO];
	}

	NSData *photo=nil;
	if([respondData valueForKey:@"senderPhoto"]!=[NSNull null])
	{
		NSString *photo64Encoding=[respondData valueForKey:@"senderPhoto"];
		photo=[NSData dataWithBase64EncodedString:photo64Encoding];
	}

	if([respondData valueForKey:@"giftAfterText"]!=[NSNull null])
	{
		self.giftAfterText=[respondData valueForKey:@"giftAfterText"];
	}
	else 
	{
		[self setGiftAfterText:nil];
	}

	if([respondData valueForKey:@"giftBeforeText"]!=[NSNull null])
	{
		self.giftBeforeText=[respondData valueForKey:@"giftBeforeText"];
	}
	else 
	{
		[self setGiftBeforeText:nil];
	}

	
	
	
	if([respondData valueForKey:@"senderPhotoName"]!=[NSNull null])
	{
		self.giftPhotoName=[respondData valueForKey:@"senderPhotoName"];
	}
	else 
	{
		self.giftPhotoName=nil;
	}

	
	[self setGiftPhoto:photo];
	
	BOOL proccessObj=YES;
	
	if([respondData valueForKey:@"GiftBox3d"]==[NSNull null])
		proccessObj=NO;
	
	if(proccessObj)
	{
		//unpack with GiftBox3D
		NSDictionary *giftBox3D=[respondData valueForKey:@"GiftBox3d"];
		
		//convert 3d obj binary data to NSData
		NSString *box3D64Obj=[giftBox3D valueForKey:@"obj"];
		NSString *box3D64Mtl=[giftBox3D valueForKey:@"mtl"];
		NSData *box3DObj=[NSData dataWithBase64EncodedString:box3D64Obj];
		NSData *box3DMtl=[NSData dataWithBase64EncodedString:box3D64Mtl];
		
		
		//3d obj and mtl save path
		
		NSString *box3DObjFullName=[boxPrefix stringByAppendingString:[self.giftBox3DNum stringByAppendingString:@".obj"]];
		NSString *box3DMtlName=[giftBox3D valueForKey:@"mtlName"];
		NSString *box3DObjSavePath=[docDirectory stringByAppendingPathComponent:box3DObjFullName];
		NSString *box3DMtlSavePath=[docDirectory stringByAppendingPathComponent:box3DMtlName];
		
		//save 3d object into device
		[box3DObj writeToFile:box3DObjSavePath atomically:NO];
		[box3DMtl writeToFile:box3DMtlSavePath atomically:NO];
		
		NSNumber *objNum=[giftBox3D valueForKey:@"objNumber"];
		self.objNumber=[objNum stringValue];
	}
	
	BOOL proccessVideo=YES;
	
	if([respondData valueForKey:@"GiftBoxVideo"]==[NSNull null])
		proccessVideo=NO;
	
	if(proccessVideo)
	{
		//conver box video binary data to NSData
		NSString *box64Video=[respondData valueForKey:@"GiftBoxVideo"];
		NSData *boxVideo=[NSData dataWithBase64EncodedString:box64Video];
		
		//box video save file name
		self.giftBoxVideoFileName=[boxPrefix stringByAppendingString:[giftBoxNum stringByAppendingString:@".mp4"]];
		
		//box video save path
		NSString *boxVideoSavePath=[docDirectory stringByAppendingPathComponent:giftBoxVideoFileName];
		
		//save video into device
		[boxVideo writeToFile:boxVideoSavePath atomically:NO];
	}

	self.isSecondDownloadComplete=YES;
	
	[appDelegate.dataManager updateNewGiftItemWithGift:self WithGiftID:self.giftID];
	
	self.isDownloadingSecondData=NO;
	
	/*
	if(cell!=nil)
	{
		[cell.downloadActivityView stopAnimating];
		
	}
	 */
	[newGiftController.table reloadData];
	
	
}

-(void)dealloc
{
	[giftID release];
	[giftIconID release];
	[senderID release];
	[senderPicURL release];
	[senderName release];
	[strCanOpenTime release];
	[giftBeforeText release];
	[giftAfterText release];
	[giftPhotoName release];
	[giftPhoto release];
	[giftSoundID release];
	[giftSoundName release];
	[giftSound release];
	[giftBoxVideoNum release];
	[giftVideoNum release];
	[giftBox3DNum release];
	[gift3DNum release];
	[objNumber release];
	[anonymous release];
	[giftBoxVideoFileName release];
	[giftDefMusicNum release];
	[giftNum release];
	[giftBoxNum release];
	[receiveTime release];
	[autoDeleteDate release];
	
	if(senderTempPhoto!=nil)
		[senderTempPhoto release];
	
	if(downloadConnection)
	{
		//[downloadConnection cancel];
		self.downloadConnection=nil;
	}
	
	[boxPrefix release];
	[giftPrefix release];
	[giftIconPrefix release];
	[giftIconFormat release];
	
	[super dealloc];
}

@end
