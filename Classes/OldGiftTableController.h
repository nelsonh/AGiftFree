//
//  OldGiftTableController.h
//  AGiftFree
//
//  Created by Nelson on 2/22/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "OldGiftTableHintContrller.h"

#define kOldTableCellHeight 80

@class GiftSectionRootViewController;

@interface OldGiftTableController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
	
	UITableView *table;
	GiftSectionRootViewController *rootViewController;
	UIButton *hintButton;
	OldGiftTableHintContrller *hintController;
	
	//contain OldSenderInfo
	NSMutableArray *tableSourceData;

}


@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet GiftSectionRootViewController *rootViewController;
@property (nonatomic, retain) IBOutlet UIButton *hintButton;
@property (nonatomic, retain) IBOutlet OldGiftTableHintContrller *hintController;

@property (nonatomic, retain) NSMutableArray *tableSourceData;

-(void)reloadSourceData;
-(void)disableHint;

-(IBAction)hintButtonPress;

@end
