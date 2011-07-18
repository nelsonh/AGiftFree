//
//  NewGiftTableController.h
//  AGiftFree
//
//  Created by Nelson on 2/22/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NewGiftTableHintContrller.h"

#define kNewTableCellHeight 90

@class GiftSectionRootViewController;
@class NewTableViewCell;

@interface NewGiftTableController : UIViewController <UITableViewDelegate, UITableViewDataSource>{	

	UITableView *table;
	GiftSectionRootViewController *rootViewController;
	UIButton *hintButton;
	NewGiftTableHintContrller *hintController;
	
	//contain NewGiftItem
	NSMutableArray *tableSourceData;
}

@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet GiftSectionRootViewController *rootViewController;
@property (nonatomic, retain) IBOutlet UIButton *hintButton;
@property (nonatomic, retain) IBOutlet NewGiftTableHintContrller *hintController;

@property (nonatomic, retain) NSMutableArray *tableSourceData;

-(void)reloadSourceData;
-(void)removeGiftFromSourceDataWithGiftID:(NSString*)giftID;
-(void)disableHint;

-(IBAction)hintButtonPress;

@end
