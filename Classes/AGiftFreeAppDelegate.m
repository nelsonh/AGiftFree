//
//  AGiftFreeAppDelegate.m
//  AGiftFree
//
//  Created by Nelson on 2/17/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "AGiftFreeAppDelegate.h"
#import "NewGiftNotificationViewController.h"
#import "RegisterViewController.h"
#import "Reachability.h"
#import "UpdateGiftsViewController.h"
#import "SoapReachability.h"
#import "GiftSectionViewController.h"
#import "NSData+Base64.h"
#import "UserSectionVeiwController.h"
#import "UpgradeSectionViewController.h"

NSString *const RegisterStatusFileName=@"RegisterStatus";
NSString *const RegisterUserName=@"UserName";
NSString *const RegisterPhoneNumber=@"PhoneNumber";
NSString *const RegisterPhotoImage=@"PhotoImage";
NSString *const RegisterAuthorizedKey=@"AuthorizedKey";
NSString *const UserSettingInfoFileName=@"UserSettingInfo";
NSString *const UserSettingAutoDetectionPeriod=@"AutoDeletionPeriod";
NSString *const UserSettingNotification=@"Notification";
NSString *const UserDeletionStartDate=@"DeletionStartDate";
NSString *const VerifyName=@"VerifyUserName";
NSString *const VerifyCode=@"VerifyPassword";

@implementation AGiftFreeAppDelegate

@synthesize window;
@synthesize backViewController;
@synthesize registerStatus;
@synthesize userName;
@synthesize userPhoneNumber;
@synthesize userPhotoImage;
@synthesize userAuthorizedKey;
@synthesize userSettingInfo;
@synthesize userAutoDeletionPeriod;
@synthesize userNotification;
@synthesize rootController;
@synthesize verifyUserName;
@synthesize verifyPassword;
@synthesize hasNewGifts;
@synthesize dataManager;
@synthesize mainOpQueue;
@synthesize deletionStartDate;
@synthesize firstRegister;
@synthesize tryAgainButton;
@synthesize noConnectionImageView;
@synthesize instructionView;



#pragma mark Extend sync method
- (void)retrieveAuthorizeKey
{
	[self fetchVerifyInfo];
	
	[tryAgainButton setHidden:YES];
	[noConnectionImageView setHidden:YES];
	
	[backViewController.backImageView setImage:[UIImage imageNamed:@"SplashScreenImage.jpg"]];
	[backViewController.statusView setHidden:NO];
	[backViewController changeStatusMessage:@"Connect to server"];
	
	//NSOperationQueue *opQueue=[NSOperationQueue new];
	AGiftWebService *service=[[AGiftWebService alloc] initAGiftWebService];
	[service setDelegate:self];
	[mainOpQueue addOperation:service];
	[service retrieveAuthorizedKeyWithUsername:verifyUserName Password:verifyPassword];
	[service release];
}

- (void)syncDataAndInfo
{
	//[backViewController.backImageView setImage:[UIImage imageNamed:@"Loading1.png"]];
	[backViewController.statusView setHidden:NO];
	[backViewController changeStatusMessage:@"Loading data..."];
	
	[self fetchRegisterInfo];
	[self fetchSettingInfo];
	[self fetchCoreData];
	[self checkAutoDeletion];
	
	//check register status
	[self checkRegisterStatus];
}

- (void)fetchVerifyInfo
{
	NSString *verifyFilePath=[[NSBundle mainBundle] pathForResource:@"VerifyData" ofType:@"plist"];
	NSDictionary *verifyInfoData=[[NSDictionary alloc] initWithContentsOfFile:verifyFilePath];
	
	self.verifyUserName=[verifyInfoData valueForKey:VerifyName];
	self.verifyPassword=[verifyInfoData valueForKey:VerifyCode];
	
	[verifyInfoData release];
}

- (void)fetchRegisterInfo
{
	
	NSString *fileExtention=@"plist";
	
	NSArray *domainPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *fileDirPath=[domainPaths objectAtIndex:0];
	
	//check user has register plist info file in device
	if([self hasFileInPath:fileDirPath FileName:RegisterStatusFileName FileFormat:fileExtention])
	{
		//file existed in path
		
		NSString *preFileName=[RegisterStatusFileName stringByAppendingString:@"."];
		NSString *completeFileName=[preFileName stringByAppendingString:fileExtention];
		NSString *fullPath=[fileDirPath stringByAppendingPathComponent:completeFileName];
		
		//retrieve register info by path
		registerStatus=[[NSMutableDictionary alloc] initWithContentsOfFile:fullPath];
		
		//set user info so we can send to server to do verification
		self.userName=[registerStatus valueForKey:RegisterUserName];
		self.userPhoneNumber=[registerStatus valueForKey:RegisterPhoneNumber];
		self.userPhotoImage=[registerStatus valueForKey:RegisterPhotoImage];
		
		
	}
	else 
	{
		//file not existed in path
		registerStatus=nil;
		self.userName=nil;
		self.userPhoneNumber=nil;
		self.userPhotoImage=nil;
		
		
	}
}

- (void)fetchSettingInfo
{
	NSString *fileExtention=@"plist";
	
	NSArray *domainPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *fileDirPath=[domainPaths objectAtIndex:0];
	
	if([self hasFileInPath:fileDirPath FileName:UserSettingInfoFileName FileFormat:fileExtention])
	{
		//user setting file exist
		
		NSString *preFileName=[UserSettingInfoFileName stringByAppendingString:@"."];
		NSString *completeFileName=[preFileName stringByAppendingString:fileExtention];
		NSString *fullPath=[fileDirPath stringByAppendingPathComponent:completeFileName];
		
		//retrieve user setting info by path
		userSettingInfo=[[NSMutableDictionary alloc] initWithContentsOfFile:fullPath];
		
		userAutoDeletionPeriod=[(NSNumber*)[userSettingInfo valueForKey:UserSettingAutoDetectionPeriod] integerValue];
		userNotification=[(NSNumber*)[userSettingInfo valueForKey:UserSettingNotification] boolValue];
		deletionStartDate=[userSettingInfo valueForKey:UserDeletionStartDate];
	}
	else
	{
		//user setting file not exist read from default in bundle
		NSString *defaultSettingFilePath=[[NSBundle mainBundle] pathForResource:@"DefaultUserSetting" ofType:@"plist"];
		
		//retrieve it
		userSettingInfo=[[NSMutableDictionary alloc] initWithContentsOfFile:defaultSettingFilePath];
		
		userAutoDeletionPeriod=[(NSNumber*)[userSettingInfo valueForKey:UserSettingAutoDetectionPeriod] integerValue];
		userNotification=[(NSNumber*)[userSettingInfo valueForKey:UserSettingNotification] boolValue];
		deletionStartDate=[userSettingInfo valueForKey:UserDeletionStartDate];
	}
}

- (void)fetchCoreData
{
}

- (BOOL)saveRegisterInfo
{
	if(self.userPhoneNumber!=nil && self.userPhotoImage!=nil && self.userName!=nil)
	{
		
		NSMutableDictionary *registerInfo=[[NSMutableDictionary alloc] init];
		NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *docDirectory=[paths objectAtIndex:0];
		NSString *fileName=[RegisterStatusFileName stringByAppendingString:@".plist"];
		NSString *savingFullPath=[docDirectory stringByAppendingPathComponent:fileName];
		
		//set value
		[registerInfo setObject:self.userName forKey:RegisterUserName];
		[registerInfo setObject:self.userPhoneNumber forKey:RegisterPhoneNumber];
		[registerInfo setObject:self.userPhotoImage forKey:RegisterPhotoImage];
		[registerInfo setObject:self.userAuthorizedKey forKey:RegisterAuthorizedKey];
		
		//save to device
		[registerInfo writeToFile:savingFullPath atomically:NO];
		
		[registerInfo release];
		
		return YES;
	}
	else 
	{
		NSLog(@"Can not save register info as plist");
		return NO;
	}

}

- (BOOL)saveUserSettingInfo
{
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory=[paths objectAtIndex:0];
	NSString *fileName=[UserSettingInfoFileName stringByAppendingString:@".plist"];
	NSString *savingFullPath=[docDirectory stringByAppendingPathComponent:fileName];

	
	NSMutableDictionary *userSettingInfoSaveFile=[[NSMutableDictionary alloc] init];
	
	[userSettingInfoSaveFile setObject:[NSNumber numberWithInteger:userAutoDeletionPeriod] forKey:UserSettingAutoDetectionPeriod];
	[userSettingInfoSaveFile setObject:[NSNumber numberWithBool:userNotification] forKey:UserSettingNotification];
	[userSettingInfoSaveFile setObject:deletionStartDate forKey:UserDeletionStartDate];
	
	return [userSettingInfoSaveFile writeToFile:savingFullPath atomically:NO];
	
}

#pragma mark UITabBarDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
	if([viewController isKindOfClass:[UserSectionVeiwController class]])
	{
		[(UserSectionVeiwController*)viewController update];
	}
	
	if([viewController isKindOfClass:[UpgradeSectionViewController class]])
	{
		NSString *upgradeURL=@"http://the-asquare.com/demo/servicetest/Upgrade/mIPUpgrade.htm";
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:upgradeURL]];
	}
}

#pragma mark AGiftWebService delegate
-(void)aGiftWebService:(AGiftWebService*)webService AuthorizedKeyDictionary:(NSDictionary*)respondData
{
	
	//[backViewController.statusView setHidden:YES];
	
	if(respondData==nil)
		return;
	
	if([(NSString*)[respondData valueForKey:@"resbool"] boolValue])
	{
		
		self.userAuthorizedKey=[respondData valueForKey:@"resString"];
		
		[self saveRegisterInfo];
		
		
		//DebugLog
		//NSLog(@"authorized key:%@", userAuthorizedKey);
		
		
		// sync data and info
		[self syncDataAndInfo];
	}
	else
	{
		UIAlertView *authKeyAlert=[[UIAlertView alloc] initWithTitle:@"Authorized Key" message:@"Unable to get authorized key" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[authKeyAlert show];
		[authKeyAlert release];
	}
}

-(void)aGiftWebService:(AGiftWebService*)webService userExistedDictionary:(NSDictionary*)respondData
{
	//[backViewController.statusView setHidden:YES];
	
	/*
	if(respondData!=nil)
	{
		NSString *userPhoto64Encoding=[respondData valueForKey:@"ProfilePhoto"];
		
		self.userPhotoImage=[NSData dataWithBase64EncodedString:userPhoto64Encoding];
		self.userPhoneNumber=[respondData valueForKey:@"PhoneNumber"];
		self.userName=[respondData valueForKey:@"UserName"];
		
		[self saveRegisterInfo];
		
		[self updateGiftList];
	}
	else 
	{
		//show register view 
		RegisterViewController *registerController=[[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
		[backViewController presentModalViewController:registerController animated:YES];
		[registerController release];
	}
	 */
	
	if(respondData==nil)
		return;
	
	NSNumber *success=[respondData valueForKey:@"resbool"];
	
	if([success boolValue])
	{
		NSDictionary *userProfile=[respondData valueForKey:@"UserProfile"];
		
		NSString *savPhoneNumber=[userProfile valueForKey:@"PhoneNumber"];
		NSString *savUserName=[userProfile valueForKey:@"UserName"];
		NSString *photo64Encoding=[userProfile valueForKey:@"ProfilePhoto"];
		NSData *savUserPhoto=[NSData dataWithBase64EncodedString:photo64Encoding];
		
		if([savPhoneNumber isEqualToString:self.userPhoneNumber])
		{
			self.userPhoneNumber=savPhoneNumber;
			self.userName=savUserName;
			self.userPhotoImage=savUserPhoto;
			
			[self saveRegisterInfo];
			
			//info vaild access agift
			[self updateGiftList];
		}
		else 
		{
			if(self.firstRegister)
			{
				NSArray *phoneNumberSet=[savPhoneNumber componentsSeparatedByString:@"-"];
				
				
				RegisterViewController *registerController=[[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
				[registerController setInAreaCode:[phoneNumberSet objectAtIndex:0]];
				[registerController setInPhoneNumber:[phoneNumberSet objectAtIndex:1]];
				[registerController setInUserName:savUserName];
				[registerController setInUserPhoto:[UIImage imageWithData:savUserPhoto]];
				[backViewController presentModalViewController:registerController animated:YES];
				[registerController release];
			}
			else 
			{
				NSArray *phoneNumberSet=[savPhoneNumber componentsSeparatedByString:@"-"];
				
				NSString *msg=@"The previous phone number has been updated. Please re-register";
				UIAlertView *regAlert=[[UIAlertView alloc] initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[regAlert show];
				[regAlert release];
				
				RegisterViewController *registerController=[[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
				[registerController setInAreaCode:[phoneNumberSet objectAtIndex:0]];
				[registerController setInPhoneNumber:[phoneNumberSet objectAtIndex:1]];
				[registerController setInUserName:savUserName];
				[registerController setInUserPhoto:[UIImage imageWithData:savUserPhoto]];
				[backViewController presentModalViewController:registerController animated:YES];
				[registerController release];
			}


		}
		
	}
	else 
	{
		//invaildate register
		NSString *msg=@"The phone number is not existed please register again";
		UIAlertView *regAlert=[[UIAlertView alloc] initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[regAlert show];
		[regAlert release];
		
		RegisterViewController *registerController=[[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
		[backViewController presentModalViewController:registerController animated:YES];
		[registerController release];
	}

}

#pragma mark Extend method
- (void)checkAutoDeletion
{
	if(userAutoDeletionPeriod!=0)
	{
		//get time since user set auto deletion
		NSTimeInterval intervalTime=[[NSDate date] timeIntervalSinceDate:deletionStartDate];
		
		NSCalendar *sysCalendar = [NSCalendar currentCalendar];
		
		NSDate *date2 = [[NSDate alloc] initWithTimeInterval:intervalTime sinceDate:deletionStartDate];
		
		unsigned int unitFlags = NSMonthCalendarUnit;
		
		NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:deletionStartDate  toDate:date2  options:0];

		

		if([breakdownInfo month]>=userAutoDeletionPeriod)
		{
			//do auto deletion right away
			[dataManager removeAllSenderData];
			
			//reset deletion start date to now
			deletionStartDate=[NSDate date];
			
			//save it
			[self saveUserSettingInfo];
		}
		
		[date2 release];
	}
}

- (void)startNetworkActivity
{
	activityInvockCount+=1;
	
	if(activityInvockCount>0)
	{
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		[[UIApplication sharedApplication] setIdleTimerDisabled:YES];
	}
	
}

- (void)stopNetworkActivity
{
	activityInvockCount-=1;
	
	if(activityInvockCount==0)
	{
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		[[UIApplication sharedApplication] setIdleTimerDisabled:NO];
	}
}

- (BOOL)hasFileInPath:(NSString*)fileDirectoryPath FileName:(NSString*)fileName FileFormat:(NSString*)fileFormat
{
	NSString *fullPath;
	
	//default format is plist
	NSString *defaultFormat=[NSString stringWithString:@"plist"];
	
	if(fileFormat!=nil)
	{
		//deal with file name
		NSString *preCombineFileName=[fileName stringByAppendingString:@"."];
		NSString *completeFileName=[preCombineFileName stringByAppendingString:fileFormat];
		
		//append to file dictory path
		fullPath=[fileDirectoryPath stringByAppendingPathComponent:completeFileName];
	}
	else 
	{
		//deal with file name
		NSString *preCombineFileName=[fileName stringByAppendingString:@"."];
		NSString *completeFileName=[preCombineFileName stringByAppendingString:defaultFormat];
		
		//append to file dictory path
		fullPath=[fileDirectoryPath stringByAppendingPathComponent:completeFileName];
	}

	
	//retrieve default file manager
	NSFileManager *defaultFileManager=[NSFileManager defaultManager];
	
	//DebugLog
	//NSLog(@"file is existed? %i", [defaultFileManager fileExistsAtPath:fullPath]);
	return [defaultFileManager fileExistsAtPath:fullPath];

}

- (NSMutableDictionary*)registerStatusInfo
{
	return [self registerStatus];
}

-(void)checkRegisterStatus
{
	[backViewController.statusView setHidden:NO];
	[backViewController changeStatusMessage:@"Sync with server"];

	 if([self registerStatusInfo]!=nil)
	 {
		 
		 self.firstRegister=NO;
		
		 /*
		  [self updateGiftList];
		  */
		 

		 //check if this register info vaild
		 NSString *udid;
		 UIDevice *userDevice=[UIDevice currentDevice];
		 
		 udid=[userPhoneNumber stringByAppendingString:[NSString stringWithFormat:@"@%@", userDevice.uniqueIdentifier]];
		 
		 //send register info to server
		 //NSOperationQueue *opQueue=[[NSOperationQueue new] autorelease];
		 AGiftWebService *service=[[AGiftWebService alloc] initAGiftWebService];
		 [service setDelegate:self];
		 [mainOpQueue addOperation:service];
		 [service userExisted:udid];
		 [service release];

	 }
	 else
	 {
		 self.firstRegister=YES;
		 
		 /*
		 NSString *udid;
		 UIDevice *userDevice=[UIDevice currentDevice];
		 
		 udid=[NSString stringWithFormat:@"IPhone%@", userDevice.uniqueIdentifier];
		 
		 //check if register info is existed in server
		 AGiftWebService *service=[[AGiftWebService alloc] initAGiftWebService];
		 [service setDelegate:self];
		 [mainOpQueue addOperation:service];
		 [service checkDeviceIDExisted:udid];
		 [service release];
		  */
		 
		 /*
		 //show register view 
		 RegisterViewController *registerController=[[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
		 [backViewController presentModalViewController:registerController animated:YES];
		 [registerController release];
		  */
		 
		 NSString *udid;
		 UIDevice *userDevice=[UIDevice currentDevice];
		 
		 udid=[@"1111" stringByAppendingString:[NSString stringWithFormat:@"@%@", userDevice.uniqueIdentifier]];
		 
		 //send register info to server
		 //NSOperationQueue *opQueue=[[NSOperationQueue new] autorelease];
		 AGiftWebService *service=[[AGiftWebService alloc] initAGiftWebService];
		 [service setDelegate:self];
		 [mainOpQueue addOperation:service];
		 [service userExisted:udid];
		 [service release];
	 }
	
	
}

- (void)updateGiftList
{
	//register push notification
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
	
	//TODO:update new gift list from server
	UpdateGiftsViewController *updateController=[[UpdateGiftsViewController alloc] initWithNibName:@"UpdateGiftsViewController" bundle:nil];
	
	[backViewController presentModalViewController:updateController animated:YES];
}

- (void)presentNewGiftNotifyView
{
	
	NewGiftNotificationViewController *notifyController=[[NewGiftNotificationViewController alloc] initWithNibName:@"NewGiftNotificationViewController" bundle:nil];
	[notifyController setHasNewGifts:self.hasNewGifts];
	[backViewController presentModalViewController:notifyController animated:YES];
	[notifyController release];
}

- (void)presentAGiftRootView
{	
	[backViewController.statusView setHidden:YES];
	
	CGRect frame=rootController.view.frame;
	UIView *customTabView=[[UIView alloc] initWithFrame:frame];
	[customTabView setBackgroundColor:[UIColor colorWithRed:0.0f green:126.0f/255.0f blue:181.0f/255.0f alpha:1.0f]];
	[rootController.tabBar insertSubview:customTabView atIndex:0];
	[customTabView release];
	
	//add background
	UIImageView *tabbarBackground=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FreeBackground.png"]];
	[rootController.tabBar insertSubview:tabbarBackground atIndex:1];
	
	//present AGift view
	[rootController setSelectedIndex:1];
	[window addSubview:rootController.view];
	
	//add transition effct
	CATransition *animation = [CATransition animation];
	[animation setDelegate:self];
	[animation setDuration:2.0f];
	[animation setTimingFunction:UIViewAnimationCurveEaseInOut];
	[animation setType:@"rippleEffect" ];
	[window.layer addAnimation:animation forKey:NULL];
	
	/*
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(startInstructionAnim)];
	[UIView setAnimationCurve:UIViewAnimationTransitionCurlDown];
	[UIView setAnimationTransition:110 forView:window cache:YES];
	[UIView setAnimationDuration:1.5];
	//[UIView setAnimationDidStopSelector:@selector(editMessageAnimationDidStop)];
	//[rootController.tabBar setFrame:CGRectMake(originX, frame.origin.y, frame.size.width, frame.size.height)];
	[window addSubview:rootController.view];
	[UIView commitAnimations];
	 */
	

	
	
	
	//[backViewController presentModalViewController:rootController animated:YES];
	if([[rootController selectedViewController] isKindOfClass:[GiftSectionViewController class]])
	{
		[(GiftSectionViewController*)[rootController selectedViewController] update];
	}
	
}

#pragma mark CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
	[self startInstructionAnim];
}

- (void)startInstructionAnim
{
	[self performSelector:@selector(showInstructionAnim) withObject:nil afterDelay:0.0];
}

- (void)showInstructionAnim
{
	//add instruction view
	CGRect instructionRect=CGRectMake(0, window.frame.size.height-rootController.tabBar.frame.size.height-instructionView.frame.size.height, instructionView.frame.size.width, instructionView.frame.size.height);
	[instructionView setFrame:instructionRect];
	[instructionView setAlpha:0];
	[window addSubview:instructionView];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(instructionViewDidFinish)];
	[UIView setAnimationDuration:1.0];
	[instructionView setAlpha:1];
	[UIView commitAnimations];
}

- (void)instructionViewDidFinish
{
	[self performSelector:@selector(dismissInstructionViewAnim) withObject:nil afterDelay:3];
}

- (void)dismissInstructionViewAnim
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(dismissInstructionViewDidFinish)];
	[UIView setAnimationDuration:1.0];
	[instructionView setAlpha:0];
	[UIView commitAnimations];
}

- (void)dismissInstructionViewDidFinish
{
	[instructionView removeFromSuperview];
}

- (void)presentNewController:(UIViewController*)newController animated:(BOOL)animation
{
	//tell root controller to present a new controller no retain
	[rootController presentModalViewController:newController animated:animation];
}

- (BOOL)isNetworkVaild
{
	return [SoapReachability connectedToNetwork];
}



- (void)createCoreDataManager
{
	self.dataManager=[[CoreDataManager alloc] init];
}

- (void)webServiceError:(NSString*)title message:(NSString*)msg
{
	UIAlertView *serviceErrorAlert=[[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[serviceErrorAlert show];
	[serviceErrorAlert release];
}

- (void)networkConnectionError
{
	NSString *msg=[NSString stringWithString:@"Unable to connect to internet. Please check your internet connection"];
	
	UIAlertView *networkFailAlert=[[UIAlertView alloc] initWithTitle:@"Internet fail" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[networkFailAlert show];
	[networkFailAlert release];
	
	[self internetFail];
}

- (void)internetFail
{
	if(rootController.modalViewController)
	{
		[rootController.modalViewController dismissModalViewControllerAnimated:NO];
	}
	
	[rootController.view removeFromSuperview];
	
	[backViewController dismissModalViewControllerAnimated:NO];
	backViewController.backImageView.image=nil;
	[backViewController.statusView setHidden:YES];
	
	//[rootController release];
	
	activityInvockCount=0;
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[[UIApplication sharedApplication] setIdleTimerDisabled:NO];
	
	[tryAgainButton setHidden:NO];
	[noConnectionImageView setHidden:NO];
	[window bringSubviewToFront:tryAgainButton];
	[window bringSubviewToFront:noConnectionImageView];
	[tryAgainButton setHidden:NO];
	[noConnectionImageView setHidden:NO];
}
#pragma mark IBAction method
- (IBAction)tryAgainButtonPress
{
	[window sendSubviewToBack:tryAgainButton];
	[window sendSubviewToBack:noConnectionImageView];
	[tryAgainButton setHidden:YES];
	[noConnectionImageView setHidden:YES];
	
	[self retrieveAuthorizeKey];
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

	[[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
	
	[window addSubview:backViewController.view];
	
	self.mainOpQueue=[[NSOperationQueue alloc] init];
	
	//init core data manager
	[self createCoreDataManager];
	
	//get key from server
	[self retrieveAuthorizeKey];
	
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	
	if(rootController.modalViewController)
	{
		[rootController.modalViewController dismissModalViewControllerAnimated:NO];
	}
	
	[rootController.view removeFromSuperview];
	
	[backViewController dismissModalViewControllerAnimated:NO];
	//backViewController.backImageView.image=nil;
	[backViewController.backImageView setImage:[UIImage imageNamed:@"SplashScreenImage.jpg"]];
	[instructionView removeFromSuperview];
	//[rootController release];
	
	activityInvockCount=0;
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[[UIApplication sharedApplication] setIdleTimerDisabled:NO];
	
	[window sendSubviewToBack:tryAgainButton];
	[window sendSubviewToBack:noConnectionImageView];
	[tryAgainButton setHidden:YES];
	[noConnectionImageView setHidden:YES];
	
    [self saveContext];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
	
	[[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
	
	//[self updateGiftList];
	[self retrieveAuthorizeKey];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
	
	//save register info again
	NSArray *domainPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *fileDirPath=[domainPaths objectAtIndex:0];
	
	NSString *preFileName=[RegisterStatusFileName stringByAppendingString:@"."];
	NSString *completeFileName=[preFileName stringByAppendingString:@"plist"];
	NSString *fullPath=[fileDirPath stringByAppendingString:completeFileName];
	
	[[self registerStatusInfo] writeToFile:fullPath atomically:NO];
}

#pragma mark register notification delegate
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken
{
	//NSLog(@"token %@", devToken);
	
	//NSOperationQueue *opQueue=[[NSOperationQueue new] autorelease];
	AGiftWebService *service=[[AGiftWebService alloc] initAGiftWebService];
	[service setDelegate:self];
	[mainOpQueue addOperation:service];
	[service registerDeviceToken:devToken phoneNumber:self.userPhoneNumber];
	[service release];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
	//NSLog(@"notification error %@", err);

}

- (void)saveContext {
    
    NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}    


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AGiftFree" withExtension:@"momd"];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"AGiftFree.sqlite"];
	
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
							 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
							 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,nil];
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    
	[registerStatus release];
	[userSettingInfo release];
	[userName release];
	[userPhoneNumber release];
	[userPhotoImage release];
	[userAuthorizedKey release];
	[backViewController release];
	[rootController release];
	[verifyUserName release];
	[verifyPassword release];
	[dataManager release];
	[mainOpQueue release];
	[deletionStartDate release];
	
    [window release];
    [super dealloc];
}


@end

