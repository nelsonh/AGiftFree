//
//  NewTableViewCell.h
//  AGiftFree
//
//  Created by Nelson on 2/22/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewGiftItem.h"
#import <QuartzCore/QuartzCore.h>


@interface NewTableViewCell : UITableViewCell {
	
	UIImageView *giftBoxImageView;
	UIImageView *senderImageView;
	UILabel *senderNameLabel;
	UILabel *receiveDateTimeLabel;
	UIActivityIndicatorView *activityView;
	UIButton *downloadButton;
	UIActivityIndicatorView *downloadActivityView;
	
	NewGiftItem *giftItem;
}

@property (nonatomic, retain) IBOutlet UIImageView *giftBoxImageView;
@property (nonatomic, retain) IBOutlet UIImageView *senderImageView;
@property (nonatomic, retain) IBOutlet UILabel *senderNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *receiveDateTimeLabel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, retain) IBOutlet UIButton *downloadButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *downloadActivityView;
@property (nonatomic, assign) NewGiftItem *giftItem;

-(IBAction)downloadButtonPress;

@end
