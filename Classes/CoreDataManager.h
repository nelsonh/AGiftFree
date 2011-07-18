//
//  CoreDataManager.h
//  AGiftFree
//
//  Created by Nelson on 3/8/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewGiftItem.h"
#import "OldSenderInfo.h"

@interface CoreDataManager : NSObject {

}

-(BOOL)addNewGiftItemWithArray:(NSArray*)giftList;
-(BOOL)updateNewGiftAnonymousStatus:(NSString*)anonymous WithGiftID:(NSString*)giftID;
-(NSMutableArray*)retrieveNewGiftList;
-(BOOL)updateNewGiftItemWithGift:(NewGiftItem*)inItem WithGiftID:(NSString*)giftID;
-(BOOL)moveNewGiftToOldWithGiftItem:(NewGiftItem*)inItem WithSenderPhoneNumber:(NSString*)senderPhoneNumber;
-(BOOL)removeNewGiftItemWithGiftID:(NSString*)giftID;
-(BOOL)removeSenderInfoAndGiftsWithSendrPhoneNumber:(NSString*)phoneNumber;
-(NSMutableArray*)retrieveSenderInfo;
-(NSMutableArray*)retrieveOldGiftItemsWithSenderPhoneNumber:(NSString*)phoneNumber;
-(BOOL)saveSenderGiftCollectionWithSenderPhoneNumber:(NSString*)phoneNumber WithGiftCollection:(NSArray*)giftList;
-(BOOL)removeAllSenderData;
-(BOOL)updateOldGiftAutoDeletion:(NSString*)deleteDate;
-(BOOL)removeOldGiftFromSenderID:(NSString*)senderID GiftID:(NSString*)giftID;
-(BOOL)updateOldGiftAutoDeletionFromSenderID:(NSString*)senderID GiftID:(NSString*)giftID AutoDeletionDate:(NSString*)deleteDate;

@end
