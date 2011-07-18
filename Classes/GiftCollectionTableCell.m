//
//  GiftCollectionTableCell.m
//  AGiftFree
//
//  Created by Nelson on 5/10/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "GiftCollectionTableCell.h"


@implementation GiftCollectionTableCell

@synthesize giftImageView;
@synthesize receiveTimeLabel;
@synthesize autoDeletionLabel;
@synthesize beforeMsgLabel;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (void)prepareForReuse
{
	[giftImageView setImage:nil];
	[receiveTimeLabel setText:@""];
	[autoDeletionLabel setText:@""];
	[beforeMsgLabel setText:@""];
	
	[giftImageView.layer setCornerRadius:10.0f];
	[giftImageView.layer setMasksToBounds:YES];
}


- (void)dealloc {
	
	[giftImageView release];
	[receiveTimeLabel release];
	[autoDeletionLabel release];
	[beforeMsgLabel release];

	
    [super dealloc];
}


@end
