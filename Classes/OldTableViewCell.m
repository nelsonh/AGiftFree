//
//  OldTableViewCell.m
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "OldTableViewCell.h"


@implementation OldTableViewCell

@synthesize giftBoxImageView;
@synthesize senderImageView;
@synthesize senderNameLabel;
@synthesize numberOfGiftLabel;
@synthesize activityView;

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
	[senderImageView.layer setCornerRadius:10.0f];
	[senderImageView.layer setMasksToBounds:YES];
	[senderImageView setImage:[UIImage imageNamed:@"AUser2.png"]];
}


- (void)dealloc {
	
	[giftBoxImageView release];
	[senderImageView release];
	[senderNameLabel release];
	[numberOfGiftLabel release];
	[activityView release];
	
    [super dealloc];
}


@end
