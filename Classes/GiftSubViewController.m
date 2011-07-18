//
//  GiftSubView.m
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "GiftSubViewController.h"
#import "RenderingEngine.h"
#import "GiftMessageBeforeSubViewController.h"
#import "GiftMessageAfterSubViewController.h"
#import "AGiftFreeAppDelegate.h"
#import "GiftSectionViewController.h"
#import "NSData+Base64.h"
#import "GiftSectionRootViewController.h"
#import "NewGiftTableController.h"
#import "GiftBoxSubViewController.h"


@implementation GiftSubViewController

@synthesize senderImageView;
@synthesize senderNameLabel;
@synthesize beforeMessageButton;
@synthesize afterMessageButton;
@synthesize openGLESReferenceView;
@synthesize playVideoButton;
@synthesize activityView;
@synthesize modelRenderingEngine;
@synthesize playBoxOpenVideo;
@synthesize giftItem;
@synthesize objectLoadingView;
@synthesize shouldReloadRnderEngine;
@synthesize senderPhotoConnection;
@synthesize senderTempPhoto;
@synthesize shouldPlayMusicBegin;
@synthesize isDataReady;
@synthesize activityMsgLabel;
@synthesize afterMagController;
@synthesize beforeMsgController;
@synthesize shouldDoActionBegin;
@synthesize hintButton;
@synthesize hintController;
@synthesize videoPlayer;
@synthesize isVideoPlaying;



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
	
	[senderNameLabel setText:giftItem.senderName];
	
	//round corner for loading view
	[objectLoadingView.layer setCornerRadius:10.0f];
	[objectLoadingView.layer setMasksToBounds:YES];
	
	self.shouldReloadRnderEngine=YES;
	
	[senderImageView.layer setCornerRadius:7.0f];
	[senderImageView.layer setMasksToBounds:YES];
	
	//sender photo
	if([giftItem.senderID isEqualToString:@"Anonymous"])
	{
		[senderImageView setImage:[UIImage imageNamed:@"AUser2.png"]];
	}
	else 
	{
		[activityView startAnimating];
		
		self.senderTempPhoto=[[NSMutableData alloc] init];
		NSURL *url=[NSURL URLWithString:giftItem.senderPicURL];
		NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
		NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
		self.senderPhotoConnection=connection;
		[connection release];
	}


	
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
	self.beforeMessageButton=nil;
	self.afterMessageButton=nil;
	self.openGLESReferenceView=nil;
	self.playVideoButton=nil;
	self.activityView=nil;
	self.objectLoadingView=nil;
	self.activityMsgLabel=nil;
	self.hintButton=nil;
	self.hintController=nil;
	
	[self dismissMoviePlayerViewControllerAnimated];
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark IBAction motheds
-(IBAction)playButtonPress
{
	if(videoPlayer)
	{
		if(isVideoPlaying)
		{
			//stop
			[videoPlayer.moviePlayer stop];
			self.isVideoPlaying=NO;
			[playVideoButton setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
			
			//stop sound
			[(GiftSectionViewController*)self.navigationController stopPlayingSound];
		}
		else 
		{
			self.isVideoPlaying=YES;
			
			[playVideoButton setImage:[UIImage imageNamed:@"Stop.png"] forState:UIControlStateNormal];
			
			//TODO: play gift video
			NSString *videoFileName=[giftItem.giftPrefix stringByAppendingString:[giftItem.giftNum stringByAppendingString:@".mp4"]];
			//[self playVideo:videoFileName Target:self finishPerformAction:@selector(giftVideoDidFinish)];
			[self playVideo:videoFileName Target:self finishPerformAction:@selector(giftVideoDidFinish)];
			
			[self playSound];
			
			[self.view bringSubviewToFront:playVideoButton];
			[self.view bringSubviewToFront:hintButton];
		}
	}
	else 
	{
		self.isVideoPlaying=YES;
		
		[playVideoButton setImage:[UIImage imageNamed:@"Stop.png"] forState:UIControlStateNormal];
		
		//TODO: play gift video
		NSString *videoFileName=[giftItem.giftPrefix stringByAppendingString:[giftItem.giftNum stringByAppendingString:@".mp4"]];
		//[self playVideo:videoFileName Target:self finishPerformAction:@selector(giftVideoDidFinish)];
		[self playVideo:videoFileName Target:self finishPerformAction:@selector(giftVideoDidFinish)];
		
		[self playSound];
		
		[self.view bringSubviewToFront:playVideoButton];
		[self.view bringSubviewToFront:hintButton];
	}

	
	
	
}

-(IBAction)beforeMessageButtonPress
{
	/*
	GiftMessageBeforeSubViewController *messageBeforeController=[[GiftMessageBeforeSubViewController alloc] initWithNibName:@"GiftMessageBeforeSubViewController" bundle:nil];
	[messageBeforeController setGiftItem:giftItem];
	[self.navigationController pushViewController:messageBeforeController animated:YES];
	[messageBeforeController release];
	 */
	
	if([self shouldShowBeforeMessage])
	{
		[self presentBeforeMessage];
	}
	else 
	{
		NSString *msg=@"There is no message for you";
		UIAlertView *noMsgAlert=[[UIAlertView alloc] initWithTitle:@"No message" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[noMsgAlert show];
		[noMsgAlert release];
	}

}

-(IBAction)afterMessageButtonPress
{
	/*
	GiftMessageAfterSubViewController *messageAfterController=[[GiftMessageAfterSubViewController alloc] initWithNibName:@"GiftMessageAfterSubViewController" bundle:nil];
	[messageAfterController setGiftItem:giftItem];
	[self.navigationController pushViewController:messageAfterController animated:YES];
	[messageAfterController release];
	 */
	
	if([self shouldShowAfterMessage])
	{
		[afterMagController setEnablePerformActionWhenDismiss:NO];
		[self presentAfterMessage];
	}
	else 
	{
		NSString *msg=@"There is no message for you";
		UIAlertView *noMsgAlert=[[UIAlertView alloc] initWithTitle:@"No message" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[noMsgAlert show];
		[noMsgAlert release];
	}

}

-(IBAction)hintButtonPress
{
	if(hintController)
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view.superview cache:YES];
		[UIView setAnimationDuration:1.0];
		
		[self.view addSubview:hintController.view];
		
		[UIView commitAnimations];
	}
}

#pragma mark methods

-(void)playVideo:(NSString*)videoFileName
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	//TODO get video from device by given name and play
	NSArray *domainPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *fileDirPath=[domainPaths objectAtIndex:0];
	
	NSString *videoPath=[fileDirPath stringByAppendingPathComponent:videoFileName];
	NSURL *movieURL=[NSURL fileURLWithPath:videoPath];
	MPMoviePlayer *movieViewPlayer=[[MPMoviePlayer alloc] initWithContentURL:movieURL];
	
	//in order to rotate video
	[appDelegate.window bringSubviewToFront:appDelegate.backViewController.view];
	[appDelegate.backViewController.view setAlpha:0.0];
	
	[appDelegate.backViewController presentMoviePlayerViewControllerAnimated:movieViewPlayer];
}

-(void)playVideo:(NSString *)videoFileName Target:(id)target finishPerformAction:(SEL)action
{
	//AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	//TODO get video from device by given name and play
	NSArray *domainPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *fileDirPath=[domainPaths objectAtIndex:0];
	
	NSString *videoPath=[fileDirPath stringByAppendingPathComponent:videoFileName];
	NSURL *movieURL=[NSURL fileURLWithPath:videoPath];
	MPMoviePlayer *movieViewPlayer=[[MPMoviePlayer alloc] initWithContentURL:movieURL Target:target Action:action];
	[movieViewPlayer.view setFrame:CGRectMake(0, 0, openGLESReferenceView.frame.size.width, openGLESReferenceView.frame.size.height)];
	[movieViewPlayer.moviePlayer setFullscreen:NO];
	[movieViewPlayer.moviePlayer setScalingMode:MPMovieScalingModeFill];
	[movieViewPlayer.moviePlayer setControlStyle:MPMovieControlStyleNone];
	
	self.videoPlayer=movieViewPlayer;
	
	/*
	//in order to rotate video
	[appDelegate.window bringSubviewToFront:appDelegate.backViewController.view];
	[appDelegate.backViewController.view setAlpha:0.0];
	
	[appDelegate.backViewController presentMoviePlayerViewControllerAnimated:movieViewPlayer];
	 */
	
	[openGLESReferenceView setHidden:NO];
	[openGLESReferenceView setBackgroundColor:[UIColor clearColor]];
	[self.view bringSubviewToFront:openGLESReferenceView];
	[openGLESReferenceView addSubview:movieViewPlayer.view];
	
}

-(BOOL)shouldShowAfterMessage
{
	if(![giftItem.giftAfterText isEqualToString:@""])
	{
		if(afterMagController==nil)
		{
			GiftMessageAfterIndividualViewController *msgController=[[GiftMessageAfterIndividualViewController alloc] initWithNibName:@"GiftMessageAfterIndividualViewController" bundle:nil];
			[msgController setGiftItem:giftItem];
			[msgController setEnablePerformActionWhenDismiss:YES];
			[msgController performAcionWhenDismissWithTarget:self Action:@selector(playButtonPress)];
			
			self.afterMagController=msgController;
			
			[msgController release];
		}
		
		return YES;
	}
	
	return NO;

}

-(BOOL)shouldShowBeforeMessage
{
	if(![giftItem.giftBeforeText isEqualToString:@""] || giftItem.giftPhoto!=nil)
	{
		if(beforeMsgController==nil)
		{
			//create message view controller
			GiftMessageBeforeIndividualViewController *msgController=[[GiftMessageBeforeIndividualViewController alloc] initWithNibName:@"GiftMessageBeforeIndividualViewController" bundle:nil];
			[msgController setGiftItem:giftItem];
			
			self.beforeMsgController=msgController;
			
			[msgController release];
		}
		
		return YES;
	}
	
	return NO;
}

-(void)presentAfterMessage
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[appDelegate.window addSubview:afterMagController.view];

	
}

-(void)presentBeforeMessage
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[appDelegate.window addSubview:beforeMsgController.view];

	
}

-(void)checkShouldStartThirdDownload
{
	if(!giftItem.isThirdDownloadComplete)
	{
		[self startThirdDownload];
	}
	else 
	{
		if(!isDataReady)
		{
			[activityMsgLabel setText:@"Loading gift"];
			
			[self performSelector:@selector(prepareData) withObject:nil afterDelay:1];
		}
		
	}

}

-(void)startThirdDownload
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	//show download message
	
	BOOL downloadGift3DObj=YES;
	BOOL downloadGiftVideo=YES;
	
	//check if 3d gift and video is exist in device
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory=[paths objectAtIndex:0];
	
	//check if gift 3d obj and  video exist or not
	NSString *objName=[giftItem.giftPrefix stringByAppendingString:giftItem.gift3DNum];
	NSString *videoName=[giftItem.giftPrefix stringByAppendingString:giftItem.giftNum];
	downloadGift3DObj=![appDelegate hasFileInPath:docDirectory FileName:objName FileFormat:@"obj"];
	downloadGiftVideo=![appDelegate hasFileInPath:docDirectory FileName:videoName FileFormat:@"mp4"];
	
	//NSOperationQueue *opQueue=[NSOperationQueue new];
	AGiftWebService *service=[[AGiftWebService alloc] initAGiftWebService];
	[service setDelegate:self];
	[appDelegate.mainOpQueue addOperation:service];
	[service ReceiveThirdData:giftItem.giftID DownloadGift3DObj:downloadGift3DObj DownloadGiftVideo:downloadGiftVideo];
	[service release];
	
	[activityMsgLabel setText:@"Downloading data"];
}

-(void)giftVideoDidFinish
{
	self.isVideoPlaying=NO;
	[playVideoButton setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
	self.videoPlayer=nil;
	[openGLESReferenceView setHidden:YES];
	[self.view sendSubviewToBack:openGLESReferenceView];
	
	//[(GiftSectionViewController*)self.navigationController stopPlayingSound];
}

-(void)playSound
{
	//play sound
	if([giftItem.giftSoundID isEqualToString:@"0"])
	{
		if(giftItem.giftSound!=nil)
		{
			//custom music paly away
			[(GiftSectionViewController*)self.navigationController playSoundWithData:giftItem.giftSound];
		}
	}
	else
	{
		NSString *bundleResourcePath=[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", giftItem.giftSoundID] ofType:@"mp3"];
		
		NSData *musicData;
		
		if(bundleResourcePath)
		{
			//music in bundle
			
			//in bundle 
			musicData=[[[NSData alloc] initWithContentsOfFile:bundleResourcePath] autorelease];
			
			[(GiftSectionViewController*)self.navigationController playSoundWithData:musicData];
		}
		else 
		{
			//music in disk
			
			//build in music get from disk
			NSArray *domainPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *docDirectory=[domainPaths objectAtIndex:0];
			
			NSString *musicFilePath=[docDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3", giftItem.giftSoundID]];
			musicData=[[[NSData alloc] initWithContentsOfFile:musicFilePath] autorelease];
			
			[(GiftSectionViewController*)self.navigationController playSoundWithData:musicData];
		}
	}
}

-(void)prepareData
{
	
	NSString *gift3D=[giftItem.giftPrefix stringByAppendingString:giftItem.gift3DNum];
	/*
	if(playBoxOpenVideo)
	{
		//play box open video only once
		NSString *videoFileName=[giftItem.boxPrefix stringByAppendingString:[giftItem.giftBoxNum stringByAppendingString:@".mp4"]];
		playBoxOpenVideo=NO;
		[self playVideo:videoFileName Target:self finishPerformAction:@selector(presentAfterMessage)];
	}
	 */
	if(modelRenderingEngine!=nil && shouldReloadRnderEngine)
	{
		[modelRenderingEngine resetContext];
		
		shouldReloadRnderEngine=NO;
	}
	else 
	{
		if(modelRenderingEngine==nil)
		{
			RenderingEngine *engine=[[[RenderingEngine alloc] initRenderingEngineWithRenderingFrame:openGLESReferenceView.frame EnableDepthBuffer:YES Controller:self] autorelease];
			self.modelRenderingEngine=engine;
			[engine release];
			
			[modelRenderingEngine set3DObjectToShowForName:gift3D];
			[modelRenderingEngine startRender];
		}
		
		shouldReloadRnderEngine=NO;
	}

	
	/*
	if(shouldPlayMusicBegin)
	{
		//play sound
		if([giftItem.giftSoundID isEqualToString:@"0"])
		{
			if(giftItem.giftSound!=nil)
			{
				//custom music paly away
				[(GiftSectionViewController*)self.navigationController playSoundWithData:giftItem.giftSound];
			}
			
		}
		else
		{
			NSData *musicData;
			
			NSString *bundleResourcePath=[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", giftItem.giftSoundID] ofType:@"mp3"];
			
			//check build in music is in bundle or disk
			if(bundleResourcePath)
			{
				//in bundle 
				musicData=[[[NSData alloc] initWithContentsOfFile:bundleResourcePath] autorelease];
				
				[(GiftSectionViewController*)self.navigationController playSoundWithData:musicData];
			}
			else 
			{
				//in disk
				//build in music get from disk
				NSArray *domainPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
				NSString *docDirectory=[domainPaths objectAtIndex:0];
				
				NSString *musicFilePath=[docDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3", giftItem.giftSoundID]];
				musicData=[[[NSData alloc] initWithContentsOfFile:musicFilePath] autorelease];
				
				[(GiftSectionViewController*)self.navigationController playSoundWithData:musicData];
			}
			
			
			
		}
		
		self.shouldPlayMusicBegin=NO;
	}
	 */
	
	if(shouldDoActionBegin)
	{
		if([self shouldShowAfterMessage])
		{
			[self presentAfterMessage];
		}
		else 
		{
			//play gift video
			[self playButtonPress];
		}
	}
	

	[self.view bringSubviewToFront:hintButton];
	[self.view bringSubviewToFront:playVideoButton];
	[playVideoButton setHidden:NO];
	
	
	[objectLoadingView setHidden:YES];
	
	self.isDataReady=YES;
}

-(void)viewWillAppear:(BOOL)animated
{
	if(shouldReloadRnderEngine)
	{
		[objectLoadingView setHidden:NO];
	}
	
	
	[(GiftSectionViewController*)self.navigationController removeController:[GiftBoxSubViewController class]];
}

- (void)viewDidAppear:(BOOL)animated
{
	[self checkShouldStartThirdDownload];
}

-(void)viewWillDisappear:(BOOL)animated
{
	if(videoPlayer)
	{
		[videoPlayer.moviePlayer stop];
		self.videoPlayer=nil;
		
		self.isVideoPlaying=NO;
		
		[playVideoButton setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
	}
	
	[(GiftSectionViewController*)self.navigationController stopPlayingSound];
}

#pragma mark AGiftWebServiceDelegate
-(void)aGiftWebService:(AGiftWebService*)webService ReceiveThirdDataDictionary:(NSDictionary*)respondData
{
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory=[paths objectAtIndex:0];
	
	
	NSData *sound;
	
	//proccess build ing or custom sound
	NSNumber *buildinSound=[respondData valueForKey:@"giftSoundID"];
	
	if([buildinSound intValue]==0)
	{
		
		[giftItem setGiftSoundID:[NSString stringWithFormat:@"%i", [buildinSound intValue]]];
		
		//custom sound
		if([respondData valueForKey:@"giftSound"]!=[NSNull null])
		{
			NSString *sound64Encoding=[respondData valueForKey:@"giftSound"];
			sound=[NSData dataWithBase64EncodedString:sound64Encoding];
			giftItem.giftSound=sound;
		}
	}
	else
	{
		//build in music
		NSString *savePath=[docDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%i.mp3", [buildinSound intValue]]];
		NSFileManager *fileManager=[NSFileManager defaultManager];
		NSString *bundleMusicPath=[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%i", [buildinSound intValue]] ofType:@"mp3"];
		
		if([respondData valueForKey:@"giftSound"]!=[NSNull null])
		{
			if(bundleMusicPath==nil)
			{
				//not in bundle
				//check build in music existed
				if(![fileManager fileExistsAtPath:savePath])
				{
					//save sound to disk
					NSString *sound64Encoding=[respondData valueForKey:@"giftSound"];
					sound=[NSData dataWithBase64EncodedString:sound64Encoding];
					
					[sound writeToFile:savePath atomically:NO];
					
					//assign music id
					[giftItem setGiftSoundID:[NSString stringWithFormat:@"%i", [buildinSound intValue]]];
				}
				else 
				{
					//assign music id
					[giftItem setGiftSoundID:[NSString stringWithFormat:@"%i", [buildinSound intValue]]];
				}
			}
			else 
			{
				//assign music id
				[giftItem setGiftSoundID:[NSString stringWithFormat:@"%i", [buildinSound intValue]]];
			}
			
		}
		else 
		{
			if(bundleMusicPath)
			{
				//music in bundle
				//assign music id
				[giftItem setGiftSoundID:[NSString stringWithFormat:@"%i", [buildinSound intValue]]];
			}
			
		}
		
	}
	
	
	//proccess 3d object
	BOOL proccessObj=YES;
	
	if([respondData valueForKey:@"Gift3d"]==[NSNull null])
		proccessObj=NO;
	
	if(proccessObj)
	{
		//unpack with Gift3d
		NSDictionary *gift3D=[respondData valueForKey:@"Gift3d"];
		
		//convert 3d obj binary data to NSData
		NSString *gift3D64Obj=[gift3D valueForKey:@"obj"];
		NSString *gift3D64Mtl=[gift3D valueForKey:@"mtl"];
		NSData *gift3DObj=[NSData dataWithBase64EncodedString:gift3D64Obj];
		NSData *gift3DMtl=[NSData dataWithBase64EncodedString:gift3D64Mtl];
		
		
		//3d obj and mtl save path
		NSString *gift3DObjFullName=[giftItem.giftPrefix stringByAppendingString:[giftItem.gift3DNum stringByAppendingString:@".obj"]];
		NSString *gift3DMtlName=[gift3D valueForKey:@"mtlName"];
		NSString *gift3DObjSavePath=[docDirectory stringByAppendingPathComponent:gift3DObjFullName];
		NSString *gift3DMtlSavePath=[docDirectory stringByAppendingPathComponent:gift3DMtlName];
		
		//save 3d object into device
		[gift3DObj writeToFile:gift3DObjSavePath atomically:NO];
		[gift3DMtl writeToFile:gift3DMtlSavePath atomically:NO];
	}
	
	//proccess video
	BOOL proccessVideo=YES;
	
	if([respondData valueForKey:@"Gift"]==[NSNull null])
		proccessVideo=NO;
	
	if(proccessVideo)
	{
		//conver gift video binary data to NSData
		NSString *gift64Video=[respondData valueForKey:@"Gift"];
		NSData *giftVideo=[NSData dataWithBase64EncodedString:gift64Video];
		
		//gift video save file name
		NSString *videoFullName =[giftItem.giftPrefix stringByAppendingString:[giftItem.giftNum stringByAppendingString:@".mp4"]];
		
		//gift video save path
		NSString *giftVideoSavePath=[docDirectory stringByAppendingPathComponent:videoFullName];
		
		//save video into device
		[giftVideo writeToFile:giftVideoSavePath atomically:NO];
		
	}
	
	[giftItem updateStatus];
	
	//update new gift item
	[appDelegate.dataManager updateNewGiftItemWithGift:giftItem	WithGiftID:giftItem.giftID];
	

	
	[self.navigationItem setHidesBackButton:NO animated:YES];
	
	[beforeMessageButton setEnabled:YES];
	
	//move new gift item to old
	[appDelegate.dataManager moveNewGiftToOldWithGiftItem:giftItem WithSenderPhoneNumber:giftItem.senderID];
	
	
	//remove data source
	NewGiftTableController *newTableController;
	
	if([[self.navigationController.viewControllers objectAtIndex:0] isKindOfClass:[GiftSectionRootViewController class]])
	{
		GiftSectionRootViewController *rootController=(GiftSectionRootViewController*)[self.navigationController.viewControllers objectAtIndex:0];
		
		newTableController=rootController.newGiftViewController;
	}
	
	if(newTableController)
	{
		[newTableController removeGiftFromSourceDataWithGiftID:giftItem.giftID];
	}
	
	// send push to sender
	//NSOperationQueue *opQueue=[NSOperationQueue new];
	AGiftWebService *service=[[AGiftWebService alloc] initAGiftWebService];
	[service setDelegate:self];
	[appDelegate.mainOpQueue addOperation:service];
	[service deleteGift:giftItem.giftID];
	[service release];
	
	
	// tell server to remove this gift
	//NSOperationQueue *opQueue=[NSOperationQueue new];
	AGiftWebService *pushService=[[AGiftWebService alloc] initAGiftWebService];
	[pushService setDelegate:self];
	[appDelegate.mainOpQueue addOperation:pushService];
	[pushService sendPushNotificationToSender:giftItem.senderID];
	[pushService release];
	
	[activityMsgLabel setText:@"Loading gift"];
	
	[self performSelector:@selector(prepareData) withObject:nil afterDelay:1];
	
}


#pragma mark  GLView delegate
-(void)glView:(GLView*)glView withTapCount:(NSUInteger)tapCount
{
	/*
	[playVideoButton setHidden:!playVideoButton.hidden];
	 */
}


- (void)dealloc {

	if(modelRenderingEngine)
	{
		[modelRenderingEngine stopRender];
		self.modelRenderingEngine=nil;
	}

	
	[senderImageView release];
	[senderNameLabel release];
	[beforeMessageButton release];
	[afterMessageButton release];
	[openGLESReferenceView release];
	[playVideoButton release];
	[activityView release];
	[objectLoadingView release];
	[activityMsgLabel release];
	[afterMagController release];
	[beforeMsgController release];
	[hintButton release];
	[hintController release];
	[giftItem release];
	
	if(senderTempPhoto!=nil)
		[senderTempPhoto release];
	
	if(senderPhotoConnection)
	{
		
		self.senderPhotoConnection=nil;
	}
	
    [super dealloc];
}


@end
