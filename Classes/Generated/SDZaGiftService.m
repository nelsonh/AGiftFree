/*
	SDZaGiftService.m
	The implementation classes and methods for the aGiftService web service.
	Generated by SudzC.com
*/

#import "SDZaGiftService.h"
				
#import "Soap.h"
	

/* Implementation of the service */
				
@implementation SDZaGiftService

	- (id) init
	{
		if(self = [super init])
		{
			self.serviceUrl = @"http://the-asquare.com/services/agift/aGiftService.asmx";
			self.namespace = @"http://the-asquare.com/";
			self.headers = nil;
			self.logging = NO;
		}
		return self;
	}
	
	- (id) initWithUsername: (NSString*) username andPassword: (NSString*) password {
		if(self = [super initWithUsername:username andPassword:password]) {
		}
		return self;
	}
	
	+ (SDZaGiftService*) service {
		return [SDZaGiftService serviceWithUsername:nil andPassword:nil];
	}
	
	+ (SDZaGiftService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password {
		return [[[SDZaGiftService alloc] initWithUsername:username andPassword:password] autorelease];
	}

		
	/* Returns NSString*.  */
	- (SoapRequest*) Auth: (id <SoapDelegate>) handler username: (NSString*) username passwod: (NSString*) passwod
	{
		return [self Auth: handler action: nil username: username passwod: passwod];
	}

	- (SoapRequest*) Auth: (id) _target action: (SEL) _action username: (NSString*) username passwod: (NSString*) passwod
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: username forName: @"username"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: passwod forName: @"passwod"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"Auth" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/Auth" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) UserIsExist: (id <SoapDelegate>) handler key: (NSString*) key v_jsonProfile: (NSString*) v_jsonProfile
	{
		return [self UserIsExist: handler action: nil key: key v_jsonProfile: v_jsonProfile];
	}

	- (SoapRequest*) UserIsExist: (id) _target action: (SEL) _action key: (NSString*) key v_jsonProfile: (NSString*) v_jsonProfile
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonProfile forName: @"v_jsonProfile"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"UserIsExist" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/UserIsExist" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) Register: (id <SoapDelegate>) handler key: (NSString*) key v_jsonProfile: (NSString*) v_jsonProfile
	{
		return [self Register: handler action: nil key: key v_jsonProfile: v_jsonProfile];
	}

	- (SoapRequest*) Register: (id) _target action: (SEL) _action key: (NSString*) key v_jsonProfile: (NSString*) v_jsonProfile
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonProfile forName: @"v_jsonProfile"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"Register" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/Register" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) EditProfile: (id <SoapDelegate>) handler key: (NSString*) key v_jsonEditProfile: (NSString*) v_jsonEditProfile
	{
		return [self EditProfile: handler action: nil key: key v_jsonEditProfile: v_jsonEditProfile];
	}

	- (SoapRequest*) EditProfile: (id) _target action: (SEL) _action key: (NSString*) key v_jsonEditProfile: (NSString*) v_jsonEditProfile
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonEditProfile forName: @"v_jsonEditProfile"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"EditProfile" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/EditProfile" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) GetPickGiftList: (id <SoapDelegate>) handler key: (NSString*) key
	{
		return [self GetPickGiftList: handler action: nil key: key];
	}

	- (SoapRequest*) GetPickGiftList: (id) _target action: (SEL) _action key: (NSString*) key
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"GetPickGiftList" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/GetPickGiftList" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) GetPickGiftBoxList: (id <SoapDelegate>) handler key: (NSString*) key
	{
		return [self GetPickGiftBoxList: handler action: nil key: key];
	}

	- (SoapRequest*) GetPickGiftBoxList: (id) _target action: (SEL) _action key: (NSString*) key
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"GetPickGiftBoxList" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/GetPickGiftBoxList" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) GetPickGiftVideo: (id <SoapDelegate>) handler key: (NSString*) key v_jsonVideoItem: (NSString*) v_jsonVideoItem
	{
		return [self GetPickGiftVideo: handler action: nil key: key v_jsonVideoItem: v_jsonVideoItem];
	}

	- (SoapRequest*) GetPickGiftVideo: (id) _target action: (SEL) _action key: (NSString*) key v_jsonVideoItem: (NSString*) v_jsonVideoItem
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonVideoItem forName: @"v_jsonVideoItem"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"GetPickGiftVideo" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/GetPickGiftVideo" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) GetPickGiftBoxVideo: (id <SoapDelegate>) handler key: (NSString*) key v_jsonVideoItem: (NSString*) v_jsonVideoItem
	{
		return [self GetPickGiftBoxVideo: handler action: nil key: key v_jsonVideoItem: v_jsonVideoItem];
	}

	- (SoapRequest*) GetPickGiftBoxVideo: (id) _target action: (SEL) _action key: (NSString*) key v_jsonVideoItem: (NSString*) v_jsonVideoItem
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonVideoItem forName: @"v_jsonVideoItem"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"GetPickGiftBoxVideo" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/GetPickGiftBoxVideo" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) IpGetPickGiftVideoUrl: (id <SoapDelegate>) handler key: (NSString*) key v_jsonVideoNo: (NSString*) v_jsonVideoNo
	{
		return [self IpGetPickGiftVideoUrl: handler action: nil key: key v_jsonVideoNo: v_jsonVideoNo];
	}

	- (SoapRequest*) IpGetPickGiftVideoUrl: (id) _target action: (SEL) _action key: (NSString*) key v_jsonVideoNo: (NSString*) v_jsonVideoNo
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonVideoNo forName: @"v_jsonVideoNo"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"IpGetPickGiftVideoUrl" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/IpGetPickGiftVideoUrl" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) IpGetPickGiftBoxVideoUrl: (id <SoapDelegate>) handler key: (NSString*) key v_jsonVideoNo: (NSString*) v_jsonVideoNo
	{
		return [self IpGetPickGiftBoxVideoUrl: handler action: nil key: key v_jsonVideoNo: v_jsonVideoNo];
	}

	- (SoapRequest*) IpGetPickGiftBoxVideoUrl: (id) _target action: (SEL) _action key: (NSString*) key v_jsonVideoNo: (NSString*) v_jsonVideoNo
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonVideoNo forName: @"v_jsonVideoNo"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"IpGetPickGiftBoxVideoUrl" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/IpGetPickGiftBoxVideoUrl" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) GetPickGift3Dobj: (id <SoapDelegate>) handler key: (NSString*) key v_strGift3dID: (NSString*) v_strGift3dID
	{
		return [self GetPickGift3Dobj: handler action: nil key: key v_strGift3dID: v_strGift3dID];
	}

	- (SoapRequest*) GetPickGift3Dobj: (id) _target action: (SEL) _action key: (NSString*) key v_strGift3dID: (NSString*) v_strGift3dID
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_strGift3dID forName: @"v_strGift3dID"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"GetPickGift3Dobj" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/GetPickGift3Dobj" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) GetPickGiftBox3Dobj: (id <SoapDelegate>) handler key: (NSString*) key v_strGiftBox3dID: (NSString*) v_strGiftBox3dID
	{
		return [self GetPickGiftBox3Dobj: handler action: nil key: key v_strGiftBox3dID: v_strGiftBox3dID];
	}

	- (SoapRequest*) GetPickGiftBox3Dobj: (id) _target action: (SEL) _action key: (NSString*) key v_strGiftBox3dID: (NSString*) v_strGiftBox3dID
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_strGiftBox3dID forName: @"v_strGiftBox3dID"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"GetPickGiftBox3Dobj" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/GetPickGiftBox3Dobj" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) GetPickGiftMusicList: (id <SoapDelegate>) handler key: (NSString*) key
	{
		return [self GetPickGiftMusicList: handler action: nil key: key];
	}

	- (SoapRequest*) GetPickGiftMusicList: (id) _target action: (SEL) _action key: (NSString*) key
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"GetPickGiftMusicList" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/GetPickGiftMusicList" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) SendGift: (id <SoapDelegate>) handler key: (NSString*) key v_jsonGiftObj: (NSString*) v_jsonGiftObj
	{
		return [self SendGift: handler action: nil key: key v_jsonGiftObj: v_jsonGiftObj];
	}

	- (SoapRequest*) SendGift: (id) _target action: (SEL) _action key: (NSString*) key v_jsonGiftObj: (NSString*) v_jsonGiftObj
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonGiftObj forName: @"v_jsonGiftObj"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"SendGift" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/SendGift" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) GetGiftSumList: (id <SoapDelegate>) handler key: (NSString*) key v_jsonFreeUserPhoneNumber: (NSString*) v_jsonFreeUserPhoneNumber
	{
		return [self GetGiftSumList: handler action: nil key: key v_jsonFreeUserPhoneNumber: v_jsonFreeUserPhoneNumber];
	}

	- (SoapRequest*) GetGiftSumList: (id) _target action: (SEL) _action key: (NSString*) key v_jsonFreeUserPhoneNumber: (NSString*) v_jsonFreeUserPhoneNumber
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonFreeUserPhoneNumber forName: @"v_jsonFreeUserPhoneNumber"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"GetGiftSumList" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/GetGiftSumList" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) GetGiftFirstMedia: (id <SoapDelegate>) handler key: (NSString*) key v_jsonDLMediaOption: (NSString*) v_jsonDLMediaOption
	{
		return [self GetGiftFirstMedia: handler action: nil key: key v_jsonDLMediaOption: v_jsonDLMediaOption];
	}

	- (SoapRequest*) GetGiftFirstMedia: (id) _target action: (SEL) _action key: (NSString*) key v_jsonDLMediaOption: (NSString*) v_jsonDLMediaOption
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonDLMediaOption forName: @"v_jsonDLMediaOption"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"GetGiftFirstMedia" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/GetGiftFirstMedia" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) GetOpenGift: (id <SoapDelegate>) handler key: (NSString*) key v_jsonDLMediaOption: (NSString*) v_jsonDLMediaOption
	{
		return [self GetOpenGift: handler action: nil key: key v_jsonDLMediaOption: v_jsonDLMediaOption];
	}

	- (SoapRequest*) GetOpenGift: (id) _target action: (SEL) _action key: (NSString*) key v_jsonDLMediaOption: (NSString*) v_jsonDLMediaOption
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonDLMediaOption forName: @"v_jsonDLMediaOption"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"GetOpenGift" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/GetOpenGift" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) CancelSendGift: (id <SoapDelegate>) handler key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid
	{
		return [self CancelSendGift: handler action: nil key: key v_jsonGiftGuid: v_jsonGiftGuid];
	}

	- (SoapRequest*) CancelSendGift: (id) _target action: (SEL) _action key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonGiftGuid forName: @"v_jsonGiftGuid"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"CancelSendGift" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/CancelSendGift" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) DeleteGift: (id <SoapDelegate>) handler key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid
	{
		return [self DeleteGift: handler action: nil key: key v_jsonGiftGuid: v_jsonGiftGuid];
	}

	- (SoapRequest*) DeleteGift: (id) _target action: (SEL) _action key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonGiftGuid forName: @"v_jsonGiftGuid"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"DeleteGift" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/DeleteGift" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) UnOpenDeleteGift: (id <SoapDelegate>) handler key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid
	{
		return [self UnOpenDeleteGift: handler action: nil key: key v_jsonGiftGuid: v_jsonGiftGuid];
	}

	- (SoapRequest*) UnOpenDeleteGift: (id) _target action: (SEL) _action key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonGiftGuid forName: @"v_jsonGiftGuid"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"UnOpenDeleteGift" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/UnOpenDeleteGift" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) SetGiftStatusList: (id <SoapDelegate>) handler key: (NSString*) key v_jsonUpdateGiftStatusList: (NSString*) v_jsonUpdateGiftStatusList
	{
		return [self SetGiftStatusList: handler action: nil key: key v_jsonUpdateGiftStatusList: v_jsonUpdateGiftStatusList];
	}

	- (SoapRequest*) SetGiftStatusList: (id) _target action: (SEL) _action key: (NSString*) key v_jsonUpdateGiftStatusList: (NSString*) v_jsonUpdateGiftStatusList
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonUpdateGiftStatusList forName: @"v_jsonUpdateGiftStatusList"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"SetGiftStatusList" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/SetGiftStatusList" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) SetGiftStatus: (id <SoapDelegate>) handler key: (NSString*) key v_jsonUpdateGiftStatusModel: (NSString*) v_jsonUpdateGiftStatusModel
	{
		return [self SetGiftStatus: handler action: nil key: key v_jsonUpdateGiftStatusModel: v_jsonUpdateGiftStatusModel];
	}

	- (SoapRequest*) SetGiftStatus: (id) _target action: (SEL) _action key: (NSString*) key v_jsonUpdateGiftStatusModel: (NSString*) v_jsonUpdateGiftStatusModel
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonUpdateGiftStatusModel forName: @"v_jsonUpdateGiftStatusModel"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"SetGiftStatus" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/SetGiftStatus" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) DeleteGiftStatus: (id <SoapDelegate>) handler key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid
	{
		return [self DeleteGiftStatus: handler action: nil key: key v_jsonGiftGuid: v_jsonGiftGuid];
	}

	- (SoapRequest*) DeleteGiftStatus: (id) _target action: (SEL) _action key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonGiftGuid forName: @"v_jsonGiftGuid"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"DeleteGiftStatus" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/DeleteGiftStatus" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) QueryGiftStatus: (id <SoapDelegate>) handler key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid
	{
		return [self QueryGiftStatus: handler action: nil key: key v_jsonGiftGuid: v_jsonGiftGuid];
	}

	- (SoapRequest*) QueryGiftStatus: (id) _target action: (SEL) _action key: (NSString*) key v_jsonGiftGuid: (NSString*) v_jsonGiftGuid
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonGiftGuid forName: @"v_jsonGiftGuid"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"QueryGiftStatus" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/QueryGiftStatus" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) QueryGiftStatusList: (id <SoapDelegate>) handler key: (NSString*) key v_jsonGiftGuidList: (NSString*) v_jsonGiftGuidList
	{
		return [self QueryGiftStatusList: handler action: nil key: key v_jsonGiftGuidList: v_jsonGiftGuidList];
	}

	- (SoapRequest*) QueryGiftStatusList: (id) _target action: (SEL) _action key: (NSString*) key v_jsonGiftGuidList: (NSString*) v_jsonGiftGuidList
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonGiftGuidList forName: @"v_jsonGiftGuidList"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"QueryGiftStatusList" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/QueryGiftStatusList" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) FindFriend: (id <SoapDelegate>) handler key: (NSString*) key v_jsonFindUser: (NSString*) v_jsonFindUser
	{
		return [self FindFriend: handler action: nil key: key v_jsonFindUser: v_jsonFindUser];
	}

	- (SoapRequest*) FindFriend: (id) _target action: (SEL) _action key: (NSString*) key v_jsonFindUser: (NSString*) v_jsonFindUser
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonFindUser forName: @"v_jsonFindUser"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"FindFriend" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/FindFriend" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) RegClientChannelUri: (id <SoapDelegate>) handler key: (NSString*) key v_jsonChinnelUri: (NSString*) v_jsonChinnelUri
	{
		return [self RegClientChannelUri: handler action: nil key: key v_jsonChinnelUri: v_jsonChinnelUri];
	}

	- (SoapRequest*) RegClientChannelUri: (id) _target action: (SEL) _action key: (NSString*) key v_jsonChinnelUri: (NSString*) v_jsonChinnelUri
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonChinnelUri forName: @"v_jsonChinnelUri"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"RegClientChannelUri" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/RegClientChannelUri" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) SendTileMsg: (id <SoapDelegate>) handler key: (NSString*) key v_jsonPNModel: (NSString*) v_jsonPNModel
	{
		return [self SendTileMsg: handler action: nil key: key v_jsonPNModel: v_jsonPNModel];
	}

	- (SoapRequest*) SendTileMsg: (id) _target action: (SEL) _action key: (NSString*) key v_jsonPNModel: (NSString*) v_jsonPNModel
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonPNModel forName: @"v_jsonPNModel"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"SendTileMsg" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/SendTileMsg" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) SendToastMsg: (id <SoapDelegate>) handler key: (NSString*) key v_jsonPNModel: (NSString*) v_jsonPNModel
	{
		return [self SendToastMsg: handler action: nil key: key v_jsonPNModel: v_jsonPNModel];
	}

	- (SoapRequest*) SendToastMsg: (id) _target action: (SEL) _action key: (NSString*) key v_jsonPNModel: (NSString*) v_jsonPNModel
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonPNModel forName: @"v_jsonPNModel"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"SendToastMsg" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/SendToastMsg" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) TestToastPushNotify: (id <SoapDelegate>) handler
	{
		return [self TestToastPushNotify: handler action: nil];
	}

	- (SoapRequest*) TestToastPushNotify: (id) _target action: (SEL) _action
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		NSString* _envelope = [Soap createEnvelope: @"TestToastPushNotify" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/TestToastPushNotify" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) TestTilePushNotify: (id <SoapDelegate>) handler
	{
		return [self TestTilePushNotify: handler action: nil];
	}

	- (SoapRequest*) TestTilePushNotify: (id) _target action: (SEL) _action
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		NSString* _envelope = [Soap createEnvelope: @"TestTilePushNotify" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/TestTilePushNotify" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) TestApplePushNotify: (id <SoapDelegate>) handler
	{
		return [self TestApplePushNotify: handler action: nil];
	}

	- (SoapRequest*) TestApplePushNotify: (id) _target action: (SEL) _action
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		NSString* _envelope = [Soap createEnvelope: @"TestApplePushNotify" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/TestApplePushNotify" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) SendAPN: (id <SoapDelegate>) handler key: (NSString*) key v_jsonAPN: (NSString*) v_jsonAPN
	{
		return [self SendAPN: handler action: nil key: key v_jsonAPN: v_jsonAPN];
	}

	- (SoapRequest*) SendAPN: (id) _target action: (SEL) _action key: (NSString*) key v_jsonAPN: (NSString*) v_jsonAPN
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: key forName: @"key"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: v_jsonAPN forName: @"v_jsonAPN"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"SendAPN" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://the-asquare.com/SendAPN" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}


@end
	