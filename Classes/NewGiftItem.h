//
//  NewGiftItem.h
//  AGiftFree
//
//  Created by Nelson on 3/8/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGiftWebService.h"

@class NewGiftTableController;

@interface NewGiftItem : NSObject <AGiftWebServiceDelegate>{
	
	//first download data
	NSString *giftID;
	NSString *giftIconID;
	NSString *senderID;
	NSString *senderPicURL;
	NSString *senderName;
	NSDate *strCanOpenTime;
	NSString *giftDefMusicNum;
	NSString *giftNum;
	NSString *giftBoxNum;
	NSString *giftBox3DNum;
	NSString *gift3DNum;
	NSString *anonymous;
	NSDate *receiveTime;
	NSString *autoDeleteDate;
	
	//second download data
	NSString *giftBeforeText;
	NSString *giftAfterText;
	NSString *giftPhotoName;
	NSData *giftPhoto;
	//if has build in then this will be 1~10 otherwise -1
	NSString *giftSoundID;
	NSString *giftSoundName;
	NSData *giftSound;
	NSString *objNumber;
	NSString *giftBoxVideoFileName;
	
	//third download data
	NSString *giftBoxVideoNum;
	NSString *giftVideoNum;
	
	NSURLConnection *downloadConnection;

	
	//download check point
	BOOL isFirsDownloadComplete;
	BOOL isSecondDownloadComplete;
	BOOL isThirdDownloadComplete;
	BOOL isTotalDownloadComplete;
	
	//use for table view cell
	NSMutableData *senderTempPhoto;
	NewGiftTableController *newGiftController;
	BOOL isDownloadingSecondData;
	
	//prefix
	NSString *boxPrefix;
	NSString *giftPrefix;
	NSString *giftIconPrefix;
	NSString *giftIconFormat;
	
	BOOL isfinishedPhotoDownload;

}

@property (nonatomic ,retain) NSString *giftID;
@property (nonatomic ,retain) NSString *giftIconID;
@property (nonatomic ,retain) NSString *senderID;
@property (nonatomic ,retain) NSString *senderPicURL;
@property (nonatomic ,retain) NSString *senderName;
@property (nonatomic ,retain) NSDate *strCanOpenTime;
@property (nonatomic ,retain) NSString *giftBeforeText;
@property (nonatomic ,retain) NSString *giftAfterText;
@property (nonatomic ,retain) NSString *giftPhotoName;
@property (nonatomic ,retain) NSData *giftPhoto;
@property (nonatomic ,retain) NSString *giftSoundID;
@property (nonatomic ,retain) NSString *giftSoundName;
@property (nonatomic ,retain) NSData *giftSound;
@property (nonatomic ,retain) NSString *giftBoxVideoNum;
@property (nonatomic ,retain) NSString *giftVideoNum;
@property (nonatomic ,retain) NSString *giftBox3DNum;
@property (nonatomic ,retain) NSString *gift3DNum;
@property (nonatomic ,retain) NSString *objNumber;
@property (nonatomic ,retain) NSString *giftBoxVideoFileName;
@property (nonatomic ,retain) NSString *giftDefMusicNum;
@property (nonatomic ,retain) NSString *giftNum;
@property (nonatomic ,retain) NSString *giftBoxNum;
@property (nonatomic ,retain) NSString *anonymous;
@property (nonatomic ,assign) BOOL isFirsDownloadComplete;
@property (nonatomic ,assign) BOOL isSecondDownloadComplete;
@property (nonatomic ,assign) BOOL isThirdDownloadComplete;
@property (nonatomic ,assign) BOOL isTotalDownloadComplete;
@property (nonatomic ,assign) NSURLConnection *downloadConnection;
@property (nonatomic ,retain) NSDate *receiveTime;
@property (nonatomic, retain) NSString *autoDeleteDate;; 

@property (nonatomic ,retain) NSMutableData *senderTempPhoto;
@property (nonatomic ,assign) NewGiftTableController *newGiftController;
@property (nonatomic ,assign) BOOL isDownloadingSecondData;
@property (nonatomic ,retain) NSString *boxPrefix;
@property (nonatomic ,retain) NSString *giftPrefix;
@property (nonatomic ,retain) NSString *giftIconPrefix;
@property (nonatomic ,retain) NSString *giftIconFormat;
@property (nonatomic ,assign) BOOL isfinishedPhotoDownload;

-(void)updateStatus;
-(BOOL)checkFirstDownloadPoint;
-(BOOL)checkThirdDownloadPoint;
-(BOOL)checkTotalDownloadPoint;

-(void)loadSenderPhotoWithTable:(NewGiftTableController*)tableController;


-(void)downloadSecondData;


@end
