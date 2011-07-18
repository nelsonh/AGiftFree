//
//  GiftCollectionTableCell.h
//  AGiftFree
//
//  Created by Nelson on 5/10/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GiftCollectionTableCell : UITableViewCell {
	
	UIImageView *giftImageView;
	UILabel *receiveTimeLabel;
	UILabel *autoDeletionLabel;
	UILabel *beforeMsgLabel;

}

@property (nonatomic, retain) IBOutlet UIImageView *giftImageView;
@property (nonatomic, retain) IBOutlet UILabel *receiveTimeLabel;
@property (nonatomic, retain) IBOutlet UILabel *autoDeletionLabel;
@property (nonatomic, retain) IBOutlet UILabel *beforeMsgLabel;




@end
