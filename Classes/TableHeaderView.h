//
//  TableHeaderView.h
//  AGiftFree
//
//  Created by Nelson on 5/11/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TableHeaderView : UIView {
	
	UIImageView *backImageView;
	UILabel *dateLabel;

}

@property (nonatomic, retain) IBOutlet UIImageView *backImageView;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;

@end
