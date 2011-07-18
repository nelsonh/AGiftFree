//
//  SenderGiftCollectionViewController.h
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftGalleryScrollView.h"
#import "OldGiftItem.h"
#import "OldSenderInfo.h"
#import "NewGiftItem.h"
#import <QuartzCore/QuartzCore.h>
#import "GiftCollectionHintController.h"


#define kNewTableCellHeight 120
#define kTableHeaderHeight 25

@interface SenderGiftCollectionViewController : UIViewController <UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, GiftGalleryScrollViewDelegate, GiftGalleryScrollViewSourceDataDelegate>{
	
	UIImageView *senderImageView;
	UILabel *senderNameLabel;
	UILabel *senderPhoneNumberLabel;
	GiftGalleryScrollView *galleryScrollView;
	UIActivityIndicatorView *activityView;
	BOOL editTable;
	UIButton *hintButton;
	GiftCollectionHintController *hintController;
	

	
	OldSenderInfo *senderInfo;
	
	UITableView *table;
	
	//contain OldGiftItem
	NSMutableArray *scrollviewSouceData;
	NSMutableDictionary *tableSourceData;
	
	NSMutableData *senderTempPhoto;
	NSURLConnection *senderPhotoConnection;
	
	NSIndexPath *selectedIndexPath;
}

@property (nonatomic, retain) IBOutlet UIImageView *senderImageView;
@property (nonatomic, retain) IBOutlet UILabel *senderNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *senderPhoneNumberLabel;
@property (nonatomic, retain) IBOutlet GiftGalleryScrollView *galleryScrollView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UIButton *hintButton;
@property (nonatomic, retain) IBOutlet GiftCollectionHintController *hintController;
@property (nonatomic ,retain) NSMutableData *senderTempPhoto;
@property (nonatomic ,assign) NSURLConnection *senderPhotoConnection;
@property (nonatomic, assign) OldSenderInfo *senderInfo;
@property (nonatomic, retain) NSMutableArray *scrollviewSouceData;
@property (nonatomic, retain) NSMutableDictionary *tableSourceData;
@property (nonatomic, assign) NSIndexPath *selectedIndexPath;


-(IBAction)hintButtonPress;

-(void)editTable:(id)sender;
-(NSMutableDictionary*)sortByDate:(NSMutableArray*)oldGiftList;
-(void)reloadData;

@end
