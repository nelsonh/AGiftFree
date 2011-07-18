//
//  AGiftFreeAppDelegate.h
//  AGiftFree
//
//  Created by Nelson on 2/17/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataManager.h"
#import "BackViewController.h"
#import "AGiftWebService.h"

extern NSString *const RegisterStatusFileName;
extern NSString *const RegisterUserName;
extern NSString *const RegisterPhoneNumber;
extern NSString *const RegisterPhotoImage;
extern NSString *const RegisterAuthorizedKey;
extern NSString *const UserSettingInfoFileName;
extern NSString *const UserSettingAutoDetectionPeriod;
extern NSString *const UserSettingNotification;
extern NSString *const UserDeletionStartDate;
extern NSString *const VerifyName;
extern NSString *const VerifyCode;



@interface AGiftFreeAppDelegate : NSObject <UITabBarDelegate, UIApplicationDelegate, AGiftWebServiceDelegate> {
    
    UIWindow *window;
	
	UIButton *tryAgainButton;
	UIImageView *noConnectionImageView;
	
	//back view
	BackViewController *backViewController;
	
	//AGift root 
	UITabBarController *rootController;
	
	//instruction
	UIView *instructionView;
	
	//store user reigster info storage
	NSMutableDictionary *registerStatus;
	
	//user setting info storage
	NSMutableDictionary *userSettingInfo;
	
	//user's info temp
	NSString *userName;
	NSString *userPhoneNumber;
	NSData *userPhotoImage;
	NSString *userAuthorizedKey;
	
	//user setting temp
	NSUInteger userAutoDeletionPeriod;
	BOOL userNotification;
	NSDate *deletionStartDate;
	
	//constent pass key;
	NSString *verifyUserName;
	NSString *verifyPassword;
	

	
	//determind if receive new gift
	BOOL hasNewGifts;
	
	//core data manager
	CoreDataManager *dataManager;
	
	NSUInteger activityInvockCount;
	
	NSOperationQueue *mainOpQueue;
	
	BOOL firstRegister;
	
    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet BackViewController *backViewController;
@property (nonatomic, retain) IBOutlet UITabBarController *rootController;
@property (nonatomic, retain) IBOutlet UIButton *tryAgainButton;
@property (nonatomic, retain) IBOutlet UIImageView *noConnectionImageView;
@property (nonatomic, retain) IBOutlet UIView *instructionView;
@property (nonatomic, retain) NSMutableDictionary *registerStatus;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *userPhoneNumber;
@property (nonatomic, retain) NSData *userPhotoImage;
@property (nonatomic, retain) NSString *userAuthorizedKey;
@property (nonatomic, readwrite) NSUInteger userAutoDeletionPeriod;
@property (nonatomic, readwrite) BOOL userNotification;
@property (nonatomic, retain) NSDate *deletionStartDate;
@property (nonatomic, retain) NSMutableDictionary *userSettingInfo;
@property (nonatomic, retain) NSString *verifyUserName;
@property (nonatomic, retain) NSString *verifyPassword;
@property (nonatomic, retain) NSOperationQueue *mainOpQueue;
@property (nonatomic, assign) BOOL firstRegister;

@property (nonatomic, assign) BOOL hasNewGifts;
@property (nonatomic, retain) CoreDataManager *dataManager;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;
- (void)syncDataAndInfo;
- (BOOL)hasFileInPath:(NSString*)fileDirectoryPath FileName:(NSString*)fileName FileFormat:(NSString*)fileFormat;
- (NSMutableDictionary*)registerStatusInfo;
- (void)fetchVerifyInfo;
- (void)fetchRegisterInfo;
- (void)fetchSettingInfo;
- (void)fetchCoreData;
- (BOOL)saveRegisterInfo;
- (BOOL)saveUserSettingInfo;
- (void)checkRegisterStatus;
- (void)updateGiftList;
- (void)presentNewGiftNotifyView;
- (void)presentAGiftRootView;
- (BOOL)isNetworkVaild;
- (void)createCoreDataManager;
- (void)presentNewController:(UIViewController*)newController animated:(BOOL)animation;
- (void)webServiceError:(NSString*)title message:(NSString*)msg;
- (void)networkConnectionError;
- (NSMutableDictionary*)registerStatusInfo;
- (void)startNetworkActivity;
- (void)stopNetworkActivity;
- (void)checkAutoDeletion;
- (void)retrieveAuthorizeKey;
- (void)internetFail;
- (void)startInstructionAnim;
- (void)showInstructionAnim;
- (void)instructionViewDidFinish;
- (void)dismissInstructionViewAnim;
- (void)dismissInstructionViewDidFinish;
- (IBAction)tryAgainButtonPress;

@end

