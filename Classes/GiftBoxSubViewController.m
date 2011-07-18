//
//  GiftBoxSubView.m
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "GiftBoxSubViewController.h"
#import "RenderingEngine.h"
#import "GiftSubViewController.h"
#import "GiftMessageBeforeSubViewController.h"
#import "GiftMessageAfterSubViewController.h"
#import "AGiftFreeAppDelegate.h"
#import "NSData+Base64.h"
#import "GiftSectionViewController.h"
#import "GiftSectionRootViewController.h"
#import "NewGiftTableController.h"



@implementation GiftBoxSubViewController

@synthesize senderImageView;
@synthesize senderNameLabel;
@synthesize beforeMessageButton;
@synthesize afterMessageButton;
@synthesize openGLESReferenceView;
@synthesize lockTimeLabel;
@synthesize openButton;
@synthesize activityView;
@synthesize downloadActivityView;
@synthesize modelRenderingEngine;
@synthesize countDownTimer;
@synthesize giftItem;
@synthesize shouldReloadRnderEngine;
@synthesize objectLoadingView;
@synthesize senderPhotoConnection;
@synthesize senderTempPhoto;
//@synthesize isDownloadingThirdData;
@synthesize patientMsgLabel;
@synthesize beforeMsgController;
@synthesize hasShowMessage;
@synthesize hintButton;
@synthesize hintController;
@synthesize videoPlayer;


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
	

	if([giftItem.anonymous isEqualToString:@"1"])
	{
		[senderNameLabel setText:@"Anonymous"];
	}
	else 
	{
		[senderNameLabel setText:giftItem.senderName];
	}

	
	
	//round corner for loading view
	[objectLoadingView.layer setCornerRadius:10.0f];
	[objectLoadingView.layer setMasksToBounds:YES];
	
	self.shouldReloadRnderEngine=YES;
	
	//self.navigationItem.title=@"Gift box";
	
	[senderImageView.layer setCornerRadius:7.0f];
	[senderImageView.layer setMasksToBounds:YES];
	
	//sender photo
	if([giftItem.anonymous isEqualToString:@"1"])
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
	self.lockTimeLabel=nil;
	self.openButton=nil;
	self.activityView=nil;
	self.downloadActivityView=nil;
	self.objectLoadingView=nil;
	self.patientMsgLabel=nil;
	self.hintButton=nil;
	self.hintController=nil;
	
	[self dismissMoviePlayerViewControllerAnimated];
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark IBAction motheds
-(IBAction)openButtonPress
{

	//check if this gift can be open or not if can open present gift sub view
	
	NSTimeInterval intervalTime=[giftItem.strCanOpenTime timeIntervalSinceNow];
	
	if(intervalTime<=0)
	{
		//open box play gift box video first
		NSString *videoFileName=[giftItem.boxPrefix stringByAppendingString:[giftItem.giftBoxNum stringByAppendingString:@".mp4"]];
		[self playVideo:videoFileName Target:self finishPerformAction:@selector(giftBoxVideoFinished)];
		
		[self.navigationItem setHidesBackButton:YES];
		[beforeMessageButton setEnabled:NO];
		[openButton setEnabled:NO];
		

		/*
		//check if downloaded
		if(giftItem.isThirdDownloadComplete)
		{
			AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
			
			GiftSubViewController *giftController=[[GiftSubViewController alloc] initWithNibName:@"GiftSubViewController" bundle:nil];
			[giftController setGiftItem:giftItem];
			[giftController setPlayBoxOpenVideo:YES];
			[self.navigationController pushViewController:giftController animated:YES];
			[giftController release];
			
			//move new gift item to old
			[appDelegate.dataManager moveNewGiftToOldWithGiftItem:giftItem WithSenderPhoneNumber:giftItem.senderID];
		}
		else 
		{
			[beforeMessageButton setEnabled:NO];
			[self.navigationItem setHidesBackButton:YES animated:YES];
			//download gift
			[self downloadGift];
			
			[self performSelector:@selector(fadeInPatientMsg) withObject:nil afterDelay:patientMsgDelay];
		}
		 */

	}
	else 
	{
		NSString *msg=@"The gift is locked you have to wait until the time it can be opened";
		UIAlertView *notReachOpenTimeAlert=[[UIAlertView alloc] initWithTitle:@"Locked" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[notReachOpenTimeAlert show];
		[notReachOpenTimeAlert release];
	}
	
	shouldReloadRnderEngine=YES;
}

-(IBAction)beforeMessageButtonPress
{
	if([self shouldShowMessage])
	{
		[self showMessage];
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
	[self.navigationController pushViewController:messageAfterController animated:YES];
	[messageAfterController release];
	 */
}

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

#pragma mark methods
-(void)fadeInPatientMsg
{
	[patientMsgLabel setAlpha:0.0f];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationOptionCurveEaseIn];
	[UIView setAnimationDuration:patientMsgFadeInDuration];
	[UIView setAnimationDidStopSelector:@selector(fadeInPatientMsgDidFinish)];
	[patientMsgLabel setAlpha:1.0f];
	[UIView commitAnimations];
}

-(void)fadeOutPatientMsg
{
	[patientMsgLabel setAlpha:1.0];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationOptionCurveEaseIn];
	[UIView setAnimationDuration:patientMsgFadeOutDuration];
	[UIView setAnimationDidStopSelector:@selector(fadeOutPatientMsgDidFinish)];
	[patientMsgLabel setAlpha:0.0f];
	[UIView commitAnimations];
}

-(void)fadeInPatientMsgDidFinish
{
	[self performSelector:@selector(fadeOutPatientMsg) withObject:nil afterDelay:patientMsgPresentTime];
}

-(void)fadeOutPatientMsgDidFinish
{
	[patientMsgLabel setAlpha:1.0];
	[patientMsgLabel setHidden:YES];
}

-(void)giftBoxVideoFinished
{
	[self.navigationItem setHidesBackButton:NO];
	[beforeMessageButton setEnabled:YES];
	[openButton setEnabled:YES];
	
	self.videoPlayer=nil;
	
	[openGLESReferenceView setHidden:YES];
	[self.view sendSubviewToBack:openGLESReferenceView];
	
	GiftSubViewController *giftController=[[GiftSubViewController alloc] initWithNibName:@"GiftSubViewController" bundle:nil];
	[giftController setGiftItem:giftItem];
	[giftController setPlayBoxOpenVideo:NO];
	[giftController setShouldDoActionBegin:YES];
	[self.navigationController pushViewController:giftController animated:YES];
	[giftController release];
}

-(void)countDown
{
	if([countDownTimer isValid])
	{
		NSTimeInterval intervalTime=[giftItem.strCanOpenTime timeIntervalSinceNow];
		
		NSCalendar *sysCalendar = [NSCalendar currentCalendar];
		
		NSDate *date1 = [[NSDate alloc] init];
		NSDate *date2 = [[NSDate alloc] initWithTimeInterval:intervalTime sinceDate:date1];
		
		unsigned int unitFlags =NSDayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
		
		NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:date1  toDate:date2  options:0];
		
		NSString *dayStr;
		NSString *hourStr;
		NSString *minStr;
		NSString *secStr;
		
		//day
		if([breakdownInfo day]>1)
		{
			dayStr=[NSString stringWithFormat:@"%iDays", [breakdownInfo day]];
		}
		else
		{
			dayStr=[NSString stringWithFormat:@"%iDay", [breakdownInfo day]];
		}
		
		//hour
		if([breakdownInfo hour]<10)
		{
			hourStr=[NSString stringWithFormat:@"0%i", [breakdownInfo hour]];
		}
		else
		{
			hourStr=[NSString stringWithFormat:@"%i", [breakdownInfo hour]];
		}
		
		//min
		if([breakdownInfo minute]<10)
		{
			minStr=[NSString stringWithFormat:@"0%i", [breakdownInfo minute]];
		}
		else
		{
			minStr=[NSString stringWithFormat:@"%i", [breakdownInfo minute]];
		}
		
		//sec
		if([breakdownInfo second]<10)
		{
			secStr=[NSString stringWithFormat:@"0%i", [breakdownInfo second]];
		}
		else
		{
			secStr=[NSString stringWithFormat:@"%i", [breakdownInfo second]];
		}
		
		NSString *lockTime=[NSString stringWithFormat:@"%@ %@:%@:%@", dayStr, hourStr, minStr, secStr];
		
		[lockTimeLabel setText:lockTime];
		
		[lockTimeLabel setHidden:NO];
		
		[openButton setHidden:NO];
		
		[date1 release];
		[date2 release];
		
		if([breakdownInfo hour]<=0 && [breakdownInfo minute]<=0 && [breakdownInfo second]<=0)
		{
			[self unlockGiftBox];
			
			[lockTimeLabel setText:@""];
			[lockTimeLabel setHidden:YES];

		}
	}


}

-(void)unlockGiftBox
{
	if([countDownTimer isValid])
	{
		[countDownTimer invalidate];
		self.countDownTimer=nil;
	}
	
	[openButton setTransform:CGAffineTransformMakeScale(1, 1)];
	[openButton setImage:[UIImage imageNamed:@"hand.png"] forState:UIControlStateNormal];
	
}

/*
-(void)downloadGift
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	self.isDownloadingThirdData=YES;
	
	//hide button
	[openButton setHidden:YES];
	[downloadActivityView startAnimating];
	
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
}
*/

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

-(BOOL)shouldShowMessage
{
	//check if has message from sender or has photo
	if(![giftItem.giftBeforeText isEqualToString:@""] || giftItem.giftPhoto!=nil)
	{
		if(self.beforeMsgController==nil)
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

-(void)showMessage
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	//present message
	[appDelegate.window addSubview:beforeMsgController.view];
}

/*
#pragma mark AGiftWebServiceDelegate
-(void)aGiftWebService:(AGiftWebService*)webService ReceiveThirdDataDictionary:(NSDictionary*)respondData
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	[self fadeOutPatientMsgDidFinish];
	
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
		
	
	GiftSubViewController *giftController=[[GiftSubViewController alloc] initWithNibName:@"GiftSubViewController" bundle:nil];
	[giftController setGiftItem:giftItem];
	[giftController setPlayBoxOpenVideo:YES];
	[self.navigationController pushViewController:giftController animated:YES];
	[giftController release];
	
}
*/

-(void)viewWillAppear:(BOOL)animated
{
	if(shouldReloadRnderEngine)
	{
		[self.view bringSubviewToFront:objectLoadingView];
		[objectLoadingView setHidden:NO];
	}
	
	//stop playing sound
	[(GiftSectionViewController*)self.navigationController stopPlayingSound];
}

- (void)viewDidAppear:(BOOL)animated
{
	
	NSString *giftBox3D=[giftItem.boxPrefix stringByAppendingString:giftItem.giftBox3DNum];
	
	
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
			
			[modelRenderingEngine set3DObjectToShowForName:giftBox3D];
			[self.modelRenderingEngine startRender];
			 
		}
		
		shouldReloadRnderEngine=NO;
	}
	
	
	//count down
	NSDate *nowDate=[NSDate date];
	NSLog(@"local time :%@",[nowDate description]);
	
	
	
	
	
	NSTimeInterval intervalTime=[giftItem.strCanOpenTime timeIntervalSinceNow];
	
	if(intervalTime>0)
	{
		//start check count down
		countDownTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
		//[openButton setTransform:CGAffineTransformMakeScale(0.3, 1)];
		[openButton setImage:[UIImage imageNamed:@"Locker.png"] forState:UIControlStateNormal];
		[openButton setTitle:@"" forState:UIControlStateNormal];
		
	}
	else 
	{
		[lockTimeLabel setText:@""];
		[lockTimeLabel setHidden:YES];
		[openButton setHidden:NO];
	}

	[self.view bringSubviewToFront:lockTimeLabel];
	[self.view bringSubviewToFront:openButton];
	[self.view bringSubviewToFront:hintButton];
	[self.view bringSubviewToFront:downloadActivityView];

	[objectLoadingView setHidden:YES];
	
	if([self shouldShowMessage] && hasShowMessage!=YES)
	{
		self.hasShowMessage=YES;
		[self showMessage];
	}
	
}

-(void)viewWillDisappear:(BOOL)animated
{
	
	if(videoPlayer)
	{
		[videoPlayer.moviePlayer stop];
		self.videoPlayer=nil;
	}
	
	if(countDownTimer)
	{
		if([countDownTimer isValid] && countDownTimer!=nil)
		{
			[countDownTimer invalidate];
			
		}
	}
	
}

-(void)viewDidDisappear:(BOOL)animated
{
	
}



#pragma mark  GLView delegate
-(void)glView:(GLView*)glView withTapCount:(NSUInteger)tapCount
{
	/*
	[hourLabel setHidden:!hourLabel.hidden];
	[minuteLabel setHidden:!minuteLabel.hidden];
	[secondLabel setHidden:!secondLabel.hidden];
	
	if(isDownloadingThirdData)
	{
		[openButton setHidden:YES];
	}
	else 
	{
		[openButton setHidden:!openButton.hidden];
	}
	 */
}


- (void)dealloc {
	
	if(modelRenderingEngine)
	{
		[modelRenderingEngine stopRender];
		self.modelRenderingEngine=nil;
	}

	
	[senderNameLabel release];
	[beforeMessageButton release];
	[afterMessageButton release];
	[openGLESReferenceView release];
	[lockTimeLabel release];
	[openButton release];
	[activityView release];
	[downloadActivityView release];
	[objectLoadingView release];
	[patientMsgLabel release];
	[giftItem release];
	[beforeMsgController release];
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
