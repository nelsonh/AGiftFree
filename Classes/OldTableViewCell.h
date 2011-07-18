//
//  OldTableViewCell.h
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface OldTableViewCell : UITableViewCell {
	
	UIImageView *giftBoxImageView;
	UIImageView *senderImageView;
	UILabel *senderNameLabel;
	UILabel *numberOfGiftLabel;
	UIActivityIndicatorView *activityView;
}

@property (nonatomic, retain) IBOutlet UIImageView *giftBoxImageView;
@property (nonatomic, retain) IBOutlet UIImageView *senderImageView;
@property (nonatomic, retain) IBOutlet UILabel *senderNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *numberOfGiftLabel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;

@end
