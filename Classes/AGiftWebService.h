//
//  AGiftWebService.h
//  AGiftFree
//
//  Created by Nelson on 3/7/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoapRequest.h"

@protocol AGiftWebServiceDelegate;

@class SDZaGiftService;

@interface AGiftWebService : NSOperation {
	
	SDZaGiftService *webService;
	SoapRequest *currentRequest;
	id<AGiftWebServiceDelegate> delegate;

}

@property (nonatomic, retain) SDZaGiftService *webService;
@property (nonatomic, assign) SoapRequest *currentRequest;
@property (nonatomic, retain) id<AGiftWebServiceDelegate> delegate;

-(id)initAGiftWebService;
-(BOOL)cancelCurrentRequest;
-(BOOL)retrieveAuthorizedKeyWithUsername:(NSString*)username Password:(NSString*)password;
-(void)retrieveAuthorizedKeyRespond:(NSString*)jsonPackage;
-(BOOL)registerWithPhoneNumber:(NSString*)phoneNumber userName:(NSString*)username profilePhoto:(NSData*)photo deviceID:(NSString*)udid;
-(void)registerRespond:(NSString*)jsonPackage;
-(BOOL)editProfileWithPhoneNumber:(NSString*)phoneNumber userName:(NSString*)username profilePhoto:(NSData*)photo;
-(void)editProfileRespond:(NSString*)jsonPackage;
-(BOOL)ReceiveNewGiftList:(NSString*)phoneNumber;
-(void)ReceiveNewGiftListRespond:(NSString*)jsonPackage;
-(BOOL)ReceiveFirstData:(NSString*)giftID DownloadBox3DObj:(BOOL)objYesOrNo DownloadBoxVideo:(BOOL)videoYesOrNo DownloadGiftIcon:(BOOL)iconYesOrNo;
-(void)ReceiveFirstDataRespond:(NSString*)jsonPackage;
-(BOOL)ReceiveThirdData:(NSString*)giftID DownloadGift3DObj:(BOOL)objYesOrNo DownloadGiftVideo:(BOOL)videoYesOrNo;
-(void)ReceiveThirdDataRespond:(NSString*)jsonPackage;
-(BOOL)setGiftStatusWithGiftID:(NSString*)giftID Status:(NSString*)status;
-(void)setGiftStatusRespond:(NSString*)jsonPackage;
-(BOOL)deleteGift:(NSString*)giftID;
-(void)deleteGiftRespond:(NSString*)jsonPackage;
-(BOOL)unOpenDeleteGift:(NSString*)giftID;
-(void)unOpenDeleteGiftRespond:(NSString*)jsonPackage;
-(BOOL)userExisted:(NSString*)deviceID;
-(void)userExistedRespond:(NSString*)jsonPackage;
-(BOOL)registerDeviceToken:(NSData*)token phoneNumber:(NSString*)userPhoneNumber;
-(void)registerDeviceTokenRespond:(NSString*)jsonPackage;
-(BOOL)sendPushNotificationToSender:(NSString*)senderID;
-(void)sendPushNotificationToSenderRespond:(NSString*)jsonPackage;
-(BOOL)trackFriendInfo:(NSString*)clientPhoneNumber FriendID:(NSString*)friendID;
-(void)trackFriendInfoDataRespond:(NSString*)jsonPackage;

@end


@protocol AGiftWebServiceDelegate

@optional

-(void)aGiftWebService:(AGiftWebService*)webService AuthorizedKeyDictionary:(NSDictionary*)respondData;
-(void)aGiftWebService:(AGiftWebService*)webService RegisterDictionary:(NSDictionary*)respondData;
-(void)aGiftWebService:(AGiftWebService*)webService EditProfileDictionary:(NSDictionary*)respondData;
-(void)aGiftWebService:(AGiftWebService*)webService ReceiveNewGiftsArray:(NSArray*)respondData;
-(void)aGiftWebService:(AGiftWebService*)webService ReceiveFirstDataDictionary:(NSDictionary*)respondData;
-(void)aGiftWebService:(AGiftWebService*)webService ReceiveThirdDataDictionary:(NSDictionary*)respondData;
-(void)aGiftWebService:(AGiftWebService*)webService userExistedDictionary:(NSDictionary*)respondData;
-(void)aGiftWebService:(AGiftWebService*)webService trackFriendInfoDictionary:(NSDictionary*)respondData;

@end
 