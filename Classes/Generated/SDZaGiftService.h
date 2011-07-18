/*
	SDZaGiftService.h
	The interface definition of classes and methods for the aGiftService web service.
	Generated by SudzC.com
*/
				
#import "Soap.h"
	
/* Add class references */
				

/* Interface for the service */
				
@interface SDZaGiftService : SoapService
		
	/* Returns NSString*.  */
	- (SoapRequest*) Auth: (id <SoapDelegate>) handler username: (NSString*) username passwod: (NSString*) passwod;
	- (SoapRequest*) Auth: (id) target action: (SEL) action username: (NSString*) username passwod: (NSString*) passwod;

	/* Returns NSString*.  */
	- (SoapRequest*) UserIsExist: (id <SoapDelegate>) handler key: (NSString*) key v_jsonProfile: (NSString*) v_jsonProfile;
	- (SoapRequest*) UserIsExist: (id) target action: (SEL) action key: (NSString*) key v_jsonProfile: (NSString*) v_jsonProfile;

	/* Returns NSString*.  */
	- (SoapRequest*) Register: (id <SoapDelegate>) handler key: (NSString*) key v_jsonProfile: (NSString*) v_jsonProfile;
	- (SoapRequest*) Register: (id) target action: (SEL) action key: (NSString*) key v_jsonProfile: (NSString*) v_jsonProfile;

	/* Returns NSString*.  */
	- (SoapRequest*) EditProfile: (id <SoapDelegate>) handler key: (NSString*) key v_jsonEditProfile: (NSString*) v_jsonEditProfile;
	- (SoapRequest*) EditProfile: (id) target action: (SEL) action key: (NSString*) key v_jsonEditProfile: (NSString*) v_jsonEditProfile;

	/* Returns NSString*.  */
	- (SoapRequest*) GetPickGiftList: (id <SoapDelegate>) handler key: (NSString*) key;
	- (SoapRequest*) GetPickGiftList: (id) target action: (SEL) action key: (NSString*) key;

	/* Returns NSString*.  */
	- (SoapRequest*) GetPickGiftBoxList: (id <SoapDelegate>) handler key: (NSString*) key;
	- (SoapRequest*) GetPickGiftBoxList: (id) target action: (SEL) action key: (NSString*) key;

	/* Returns NSString*.  */
	- (SoapRequest*) GetPickGiftVideo: (id <SoapDelegate>) handler key: (NSString*) key v_jsonVideoItem: (NSString*) v_jsonVideoItem;
	- (SoapRequest*) GetPickGiftVideo: (id) target action: (SEL) action key: (NSString*) key v_jsonVideoItem: (NSString*) v_jsonVideoItem;

	/* Returns NSString*.  */
	- (SoapRequest*) GetPickGiftBoxVideo: (id <SoapDelegate>) handler key: (NSString*) key v_jsonVideoItem: (NSString*) v_jsonVideoItem;
	- (SoapRequest*) GetPickGiftBoxVideo: (id) target action: (SEL) action key: (NSString*) key v_jsonVideoItem: (NSString*) v_jsonVideoItem;

	/* Returns NSString*.  */
	- (SoapRequest*) IpGetPickGiftVideoUrl: (id <SoapDelegate>) handler key: (NSString*) key v_jsonVideoNo: (NSString*) v_jsonVideoNo;
	- (SoapRequest*) IpGetPickGiftVideoUrl: (id) target action: (SEL) action key: (NSString*) key v_jsonVideoNo: (NSString*) v_jsonVideoNo;

	/* Returns NSString*.  */
	- (SoapRequest*) IpGetPickGiftBoxVideoUrl: (id <SoapDelegate>) handler key: (NSString*) key v_jsonVideoNo: (NSString*) v_jsonVideoNo;
	- (SoapRequest*) IpGetPickGiftBoxVideoUrl: (id) target action: (SEL) action key: (NSString*) key v_jsonVideoNo: (NSString*) v_jsonVideoNo;

	/* Returns NSString*.  */
	- (SoapRequest*) GetPickGift3Dobj: (id <SoapDelegate>) handler key: (NSString*) key v_strGift3dID: (NSString*) v_strGift3dID;
	- (SoapRequest*) GetPickGift3Dobj: (id) target action: (SEL) action key: (NSString*) key v_strGift3dID: (NSString*) v_strGift3dID;

	/* Returns NSString*.  */
	- (SoapRequest*) GetPickGiftBox3Dobj: (id <SoapDelegate>) handler key: (NSString*) key v_strGiftBox3dID: (NSString*) v_strGiftBox3dID;
	- (SoapRequest*) GetPickGiftBox3Dobj: (id) target action: (SEL) action key: (NSString*) key v_strGiftBox3dID: (NSString*) v_strGiftBox3dID;

	/* Returns NSString*.  */
	- (SoapRequest*) GetPickGiftMusicList: (id <SoapDelegate>) handler key: (NSString*) key;
	- (SoapRequest*) GetPickGiftMusicList: (id) target action: (SEL) action key: (NSString*) key;

	/* Returns NSString*.  */
	- (SoapRequest*) SendGift: (id <SoapDelegate>) handler key: (NSString*) key v_jsonGiftObj: (NSString*) v_jsonGiftObj;
	- (SoapRequest*) SendGift: (id) target action: (SEL) action key: (NSString*) key v_jsonGiftObj: (NSString*) v_jsonGiftObj;

	/* Returns NSString*.  */
	- (SoapRequest*) GetGiftSumList: (id <SoapDelegate>) handler key: (NSString*) key v_jsonFreeUserPhoneNumber: (NSString*) v_jsonFreeUserPhoneNumber;
	- (SoapRequest*) GetGiftSumList: (id) target action: (SEL) action key: (NSString*) key v_jsonFreeUserPhoneNumber: (NSString*) v_jsonFreeUserPhoneNumber;

	/* Returns NSString*.  */
	- (SoapRequest*) GetGiftFirstMedia: (id <SoapDelegate>) handler key: (NSString*) key v_jsonDLMediaOption: (NSString*) v_jsonDLMediaOption;
	- (SoapRequest*) GetGiftFirstMedia: (id) target action: (SEL) action key: (NSString*) key v_jsonDLMediaOption: (NSString*) v_jsonDLMediaOption;

	/* Returns NSString*.  */
	- (SoapRequest*) GetOpenGift: (id <SoapDelegate>) handler key: (NSString*) key v_jsonDLMediaOption: (NSString*) v_jsonDLMediaOption;
	- (SoapRequest*) GetOpenGift: (id) target action: (SEL) action key: (NSString*) key v_jsonDLMediaOption: (NSString*) v_jsonDLMediaOption;

	/* Returns NSString*.  */
	- (SoapRequest*) CancelSendGift: (id <SoapDelegate>) handler key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid;
	- (SoapRequest*) CancelSendGift: (id) target action: (SEL) action key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid;

	/* Returns NSString*.  */
	- (SoapRequest*) DeleteGift: (id <SoapDelegate>) handler key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid;
	- (SoapRequest*) DeleteGift: (id) target action: (SEL) action key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid;

	/* Returns NSString*.  */
	- (SoapRequest*) UnOpenDeleteGift: (id <SoapDelegate>) handler key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid;
	- (SoapRequest*) UnOpenDeleteGift: (id) target action: (SEL) action key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid;

	/* Returns NSString*.  */
	- (SoapRequest*) SetGiftStatusList: (id <SoapDelegate>) handler key: (NSString*) key v_jsonUpdateGiftStatusList: (NSString*) v_jsonUpdateGiftStatusList;
	- (SoapRequest*) SetGiftStatusList: (id) target action: (SEL) action key: (NSString*) key v_jsonUpdateGiftStatusList: (NSString*) v_jsonUpdateGiftStatusList;

	/* Returns NSString*.  */
	- (SoapRequest*) SetGiftStatus: (id <SoapDelegate>) handler key: (NSString*) key v_jsonUpdateGiftStatusModel: (NSString*) v_jsonUpdateGiftStatusModel;
	- (SoapRequest*) SetGiftStatus: (id) target action: (SEL) action key: (NSString*) key v_jsonUpdateGiftStatusModel: (NSString*) v_jsonUpdateGiftStatusModel;

	/* Returns NSString*.  */
	- (SoapRequest*) DeleteGiftStatus: (id <SoapDelegate>) handler key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid;
	- (SoapRequest*) DeleteGiftStatus: (id) target action: (SEL) action key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid;

	/* Returns NSString*.  */
	- (SoapRequest*) QueryGiftStatus: (id <SoapDelegate>) handler key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid;
	- (SoapRequest*) QueryGiftStatus: (id) target action: (SEL) action key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid;

	/* Returns NSString*.  */
	- (SoapRequest*) QueryGiftStatusList: (id <SoapDelegate>) handler key: (NSString*) key v_jsonGiftGuidList: (NSString*) v_jsonGiftGuidList;
	- (SoapRequest*) QueryGiftStatusList: (id) target action: (SEL) action key: (NSString*) key v_jsonGiftGuidList: (NSString*) v_jsonGiftGuidList;

	/* Returns NSString*.  */
	- (SoapRequest*) FindFriend: (id <SoapDelegate>) handler key: (NSString*) key v_jsonFindUser: (NSString*) v_jsonFindUser;
	- (SoapRequest*) FindFriend: (id) target action: (SEL) action key: (NSString*) key v_jsonFindUser: (NSString*) v_jsonFindUser;

	/* Returns NSString*.  */
	- (SoapRequest*) RegClientChannelUri: (id <SoapDelegate>) handler key: (NSString*) key v_jsonChinnelUri: (NSString*) v_jsonChinnelUri;
	- (SoapRequest*) RegClientChannelUri: (id) target action: (SEL) action key: (NSString*) key v_jsonChinnelUri: (NSString*) v_jsonChinnelUri;

	/* Returns NSString*.  */
	- (SoapRequest*) SendTileMsg: (id <SoapDelegate>) handler key: (NSString*) key v_jsonPNModel: (NSString*) v_jsonPNModel;
	- (SoapRequest*) SendTileMsg: (id) target action: (SEL) action key: (NSString*) key v_jsonPNModel: (NSString*) v_jsonPNModel;

	/* Returns NSString*.  */
	- (SoapRequest*) SendToastMsg: (id <SoapDelegate>) handler key: (NSString*) key v_jsonPNModel: (NSString*) v_jsonPNModel;
	- (SoapRequest*) SendToastMsg: (id) target action: (SEL) action key: (NSString*) key v_jsonPNModel: (NSString*) v_jsonPNModel;

	/* Returns NSString*.  */
	- (SoapRequest*) TestToastPushNotify: (id <SoapDelegate>) handler;
	- (SoapRequest*) TestToastPushNotify: (id) target action: (SEL) action;

	/* Returns NSString*.  */
	- (SoapRequest*) TestTilePushNotify: (id <SoapDelegate>) handler;
	- (SoapRequest*) TestTilePushNotify: (id) target action: (SEL) action;

	/* Returns NSString*.  */
	- (SoapRequest*) TestApplePushNotify: (id <SoapDelegate>) handler;
	- (SoapRequest*) TestApplePushNotify: (id) target action: (SEL) action;

	/* Returns NSString*.  */
	- (SoapRequest*) SendAPN: (id <SoapDelegate>) handler key: (NSString*) key v_jsonAPN: (NSString*) v_jsonAPN;
	- (SoapRequest*) SendAPN: (id) target action: (SEL) action key: (NSString*) key v_jsonAPN: (NSString*) v_jsonAPN;

		
	+ (SDZaGiftService*) service;
	+ (SDZaGiftService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password;
@end
	