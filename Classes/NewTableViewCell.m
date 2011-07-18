//
//  NewTableViewCell.m
//  AGiftFree
//
//  Created by Nelson on 2/22/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "NewTableViewCell.h"


@implementation NewTableViewCell

@synthesize giftBoxImageView;
@synthesize senderImageView;
@synthesize senderNameLabel;
@synthesize receiveDateTimeLabel;
@synthesize activityView;
@synthesize downloadButton;
@synthesize downloadActivityView;
@synthesize giftItem;

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
	senderImageView.image=nil;
	[activityView stopAnimating];
	[downloadButton setHidden:YES];
	[downloadActivityView setHidden:YES];
	[downloadActivityView stopAnimating];
	
	
	[senderImageView.layer setCornerRadius:10.0f];
	[senderImageView.layer setMasksToBounds:YES];
	[senderImageView setImage:[UIImage imageNamed:@"AUser2.png"]];
	
	giftBoxImageView.image=nil;
	
}

#pragma mark methods
-(IBAction)downloadButtonPress
{
	if(giftItem!=nil)
	{
		[downloadActivityView startAnimating];
		[downloadButton setHidden:YES];
		
		[giftItem downloadSecondData];
	}
}



- (void)dealloc {
	
	[giftBoxImageView release];
	[senderImageView release];
	[senderNameLabel release];
	[receiveDateTimeLabel release];
	[activityView release];
	[downloadButton release];
	[downloadActivityView release];
    [super dealloc];
}


@end
