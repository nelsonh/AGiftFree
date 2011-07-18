//
//  OldGiftEditController.h
//  AGiftFree
//
//  Created by Nelson on 5/16/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OldGiftEditController : UIViewController {

	UIButton *deleteButton;
	UIButton *neverDeleteButton;
	UIButton *autoDeleteButton;
	UIButton *confirmButton;
}

@property(nonatomic, retain) IBOutlet UIButton *deleteButton;
@property(nonatomic, retain) IBOutlet UIButton *neverDeleteButton;
@property(nonatomic, retain) IBOutlet UIButton *autoDeleteButton;
@property(nonatomic, retain) IBOutlet UIButton *confirmButton;

-(IBAction)deleteButtonPress;
-(IBAction)neverDeleteButtonPress;
-(IBAction)autoDeleteButtonPress;
-(IBAction)confirmButtonPress;

@end
