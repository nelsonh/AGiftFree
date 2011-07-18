//
//  TableHeaderView.m
//  AGiftFree
//
//  Created by Nelson on 5/11/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "TableHeaderView.h"


@implementation TableHeaderView

@synthesize backImageView;
@synthesize dateLabel;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	
	[backImageView release];
	[dateLabel release];
	
    [super dealloc];
}


@end
