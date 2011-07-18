//
//  OldGiftItem.h
//  AGiftFree
//
//  Created by Nelson on 3/16/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OldTableViewCell.h"
#import "AGiftWebService.h"

@class OldGiftTableController;

@interface OldSenderInfo : NSObject <AGiftWebServiceDelegate>{
	
	NSString *senderPhoneNumber;
	NSString *senderPicURL;
	NSString *senderName;
	NSString *senderGiftPlist;
	NSString *numberOfGift;
	
	//use for table view cell
	NSMutableData *senderTempPhoto;
	
	NSURLConnection *downloadConnection;
	
	OldGiftTableController *oldGiftController;
	
	OldTableViewCell *cell;
	
	BOOL isfinishedPhotoDownload;
}

@property (nonatomic ,retain) NSString *senderPhoneNumber;
@property (nonatomic ,retain) NSString *senderPicURL;
@property (nonatomic ,retain) NSString *senderName;
@property (nonatomic ,retain) NSString *senderGiftPlist;
@property (nonatomic ,retain) NSMutableData *senderTempPhoto;
@property (nonatomic ,assign) NSURLConnection *downloadConnection;
@property (nonatomic ,retain) NSString *numberOfGift;
@property (nonatomic ,assign) OldGiftTableController *oldGiftController;
@property (nonatomic ,assign) BOOL isfinishedPhotoDownload;
@property (nonatomic ,assign) OldTableViewCell *cell;

-(void)loadSenderPhotoWithTable:(OldGiftTableController*)tableController;
-(void)updateSenderInfo:(OldTableViewCell*)inCell;

@end
