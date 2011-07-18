//
//  GiftSectionRootViewController.h
//  AGiftFree
//
//  Created by Nelson on 2/22/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewGiftTableController;
@class OldGiftTableController;

@interface GiftSectionRootViewController : UIViewController <UINavigationControllerDelegate>{
	
	UISegmentedControl *segmentedController;
	NewGiftTableController *newGiftViewController;
	OldGiftTableController *oldGiftViewController;
	NSArray *viewControllers;

}
@property (nonatomic, retain) IBOutlet NewGiftTableController *newGiftViewController;
@property (nonatomic, retain) IBOutlet OldGiftTableController *oldGiftViewController;

@property (nonatomic, retain) UISegmentedControl *segmentedController;
@property (nonatomic, retain) NSArray *viewControllers;


-(void)toggleView:(id)sender;
-(void)updateViewControllers;


@end
