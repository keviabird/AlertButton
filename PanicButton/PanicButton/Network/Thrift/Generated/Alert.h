/**
 * Autogenerated by Thrift Compiler (0.9.1)
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *  @generated
 */

#import <Foundation/Foundation.h>

#import "TProtocol.h"
#import "TApplicationException.h"
#import "TProtocolException.h"
#import "TProtocolUtil.h"
#import "TProcessor.h"
#import "TObjective-C.h"
#import "TBase.h"


enum AlertThriftThriftExceptionType {
  ThriftExceptionType_SERVICE_VERSION_MISMATCH = 0,
  ThriftExceptionType_AUTHENTICATION_FAILED = 1,
  ThriftExceptionType_UNDEFINED = 2
};

enum AlertThriftThriftPlatformType {
  ThriftPlatformType_IPHONE = 0,
  ThriftPlatformType_IPAD = 1,
  ThriftPlatformType_ANDROID_PHONE = 2,
  ThriftPlatformType_ANDROID_PAD = 3,
  ThriftPlatformType_WIN_PHONE = 4,
  ThriftPlatformType_WIN_PAD = 5,
  ThriftPlatformType_FAKE_TEST_CLIENT = 6
};

@interface AlertThriftThriftException : NSException <TBase, NSCoding> {
  int __typeCode;
  NSString * __displayMessage;
  NSString * __logMessage;
  NSString * __url;

  BOOL __typeCode_isset;
  BOOL __displayMessage_isset;
  BOOL __logMessage_isset;
  BOOL __url_isset;
}

#if TARGET_OS_IPHONE || (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_5)
@property (nonatomic, getter=typeCode, setter=setTypeCode:) int typeCode;
@property (nonatomic, retain, getter=displayMessage, setter=setDisplayMessage:) NSString * displayMessage;
@property (nonatomic, retain, getter=logMessage, setter=setLogMessage:) NSString * logMessage;
@property (nonatomic, retain, getter=url, setter=setUrl:) NSString * url;
#endif

- (id) init;
- (id) initWithTypeCode: (int) typeCode displayMessage: (NSString *) displayMessage logMessage: (NSString *) logMessage url: (NSString *) url;

- (void) read: (id <TProtocol>) inProtocol;
- (void) write: (id <TProtocol>) outProtocol;

- (void) validate;

#if !__has_feature(objc_arc)
- (int) typeCode;
- (void) setTypeCode: (int) typeCode;
#endif
- (BOOL) typeCodeIsSet;

#if !__has_feature(objc_arc)
- (NSString *) displayMessage;
- (void) setDisplayMessage: (NSString *) displayMessage;
#endif
- (BOOL) displayMessageIsSet;

#if !__has_feature(objc_arc)
- (NSString *) logMessage;
- (void) setLogMessage: (NSString *) logMessage;
#endif
- (BOOL) logMessageIsSet;

#if !__has_feature(objc_arc)
- (NSString *) url;
- (void) setUrl: (NSString *) url;
#endif
- (BOOL) urlIsSet;

@end

@interface AlertThriftThriftRequestBase : NSObject <TBase, NSCoding> {
  NSString * __protocolVersion;
  NSString * __deviceId;
  NSString * __userLogin;
  NSString * __authToken;
  int __clientPlatform;
  NSString * __pushToken;
  NSString * __currentLanguage;
  NSString * __clientVersion;

  BOOL __protocolVersion_isset;
  BOOL __deviceId_isset;
  BOOL __userLogin_isset;
  BOOL __authToken_isset;
  BOOL __clientPlatform_isset;
  BOOL __pushToken_isset;
  BOOL __currentLanguage_isset;
  BOOL __clientVersion_isset;
}

#if TARGET_OS_IPHONE || (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_5)
@property (nonatomic, retain, getter=protocolVersion, setter=setProtocolVersion:) NSString * protocolVersion;
@property (nonatomic, retain, getter=deviceId, setter=setDeviceId:) NSString * deviceId;
@property (nonatomic, retain, getter=userLogin, setter=setUserLogin:) NSString * userLogin;
@property (nonatomic, retain, getter=authToken, setter=setAuthToken:) NSString * authToken;
@property (nonatomic, getter=clientPlatform, setter=setClientPlatform:) int clientPlatform;
@property (nonatomic, retain, getter=pushToken, setter=setPushToken:) NSString * pushToken;
@property (nonatomic, retain, getter=currentLanguage, setter=setCurrentLanguage:) NSString * currentLanguage;
@property (nonatomic, retain, getter=clientVersion, setter=setClientVersion:) NSString * clientVersion;
#endif

- (id) init;
- (id) initWithProtocolVersion: (NSString *) protocolVersion deviceId: (NSString *) deviceId userLogin: (NSString *) userLogin authToken: (NSString *) authToken clientPlatform: (int) clientPlatform pushToken: (NSString *) pushToken currentLanguage: (NSString *) currentLanguage clientVersion: (NSString *) clientVersion;

- (void) read: (id <TProtocol>) inProtocol;
- (void) write: (id <TProtocol>) outProtocol;

- (void) validate;

#if !__has_feature(objc_arc)
- (NSString *) protocolVersion;
- (void) setProtocolVersion: (NSString *) protocolVersion;
#endif
- (BOOL) protocolVersionIsSet;

#if !__has_feature(objc_arc)
- (NSString *) deviceId;
- (void) setDeviceId: (NSString *) deviceId;
#endif
- (BOOL) deviceIdIsSet;

#if !__has_feature(objc_arc)
- (NSString *) userLogin;
- (void) setUserLogin: (NSString *) userLogin;
#endif
- (BOOL) userLoginIsSet;

#if !__has_feature(objc_arc)
- (NSString *) authToken;
- (void) setAuthToken: (NSString *) authToken;
#endif
- (BOOL) authTokenIsSet;

#if !__has_feature(objc_arc)
- (int) clientPlatform;
- (void) setClientPlatform: (int) clientPlatform;
#endif
- (BOOL) clientPlatformIsSet;

#if !__has_feature(objc_arc)
- (NSString *) pushToken;
- (void) setPushToken: (NSString *) pushToken;
#endif
- (BOOL) pushTokenIsSet;

#if !__has_feature(objc_arc)
- (NSString *) currentLanguage;
- (void) setCurrentLanguage: (NSString *) currentLanguage;
#endif
- (BOOL) currentLanguageIsSet;

#if !__has_feature(objc_arc)
- (NSString *) clientVersion;
- (void) setClientVersion: (NSString *) clientVersion;
#endif
- (BOOL) clientVersionIsSet;

@end

@interface AlertThriftThriftPingResponse : NSObject <TBase, NSCoding> {
  int64_t __serverTimestamp;
  BOOL __newVersionAvailable;
  NSString * __updateUrl;
  NSString * __updateMessage;
  BOOL __shouldCleanClientData;

  BOOL __serverTimestamp_isset;
  BOOL __newVersionAvailable_isset;
  BOOL __updateUrl_isset;
  BOOL __updateMessage_isset;
  BOOL __shouldCleanClientData_isset;
}

#if TARGET_OS_IPHONE || (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_5)
@property (nonatomic, getter=serverTimestamp, setter=setServerTimestamp:) int64_t serverTimestamp;
@property (nonatomic, getter=newVersionAvailable, setter=setNewVersionAvailable:) BOOL newVersionAvailable;
@property (nonatomic, retain, getter=updateUrl, setter=setUpdateUrl:) NSString * updateUrl;
@property (nonatomic, retain, getter=updateMessage, setter=setUpdateMessage:) NSString * updateMessage;
@property (nonatomic, getter=shouldCleanClientData, setter=setShouldCleanClientData:) BOOL shouldCleanClientData;
#endif

- (id) init;
- (id) initWithServerTimestamp: (int64_t) serverTimestamp newVersionAvailable: (BOOL) newVersionAvailable updateUrl: (NSString *) updateUrl updateMessage: (NSString *) updateMessage shouldCleanClientData: (BOOL) shouldCleanClientData;

- (void) read: (id <TProtocol>) inProtocol;
- (void) write: (id <TProtocol>) outProtocol;

- (void) validate;

#if !__has_feature(objc_arc)
- (int64_t) serverTimestamp;
- (void) setServerTimestamp: (int64_t) serverTimestamp;
#endif
- (BOOL) serverTimestampIsSet;

#if !__has_feature(objc_arc)
- (BOOL) newVersionAvailable;
- (void) setNewVersionAvailable: (BOOL) newVersionAvailable;
#endif
- (BOOL) newVersionAvailableIsSet;

#if !__has_feature(objc_arc)
- (NSString *) updateUrl;
- (void) setUpdateUrl: (NSString *) updateUrl;
#endif
- (BOOL) updateUrlIsSet;

#if !__has_feature(objc_arc)
- (NSString *) updateMessage;
- (void) setUpdateMessage: (NSString *) updateMessage;
#endif
- (BOOL) updateMessageIsSet;

#if !__has_feature(objc_arc)
- (BOOL) shouldCleanClientData;
- (void) setShouldCleanClientData: (BOOL) shouldCleanClientData;
#endif
- (BOOL) shouldCleanClientDataIsSet;

@end

@interface AlertThriftThrifAlertLocationRequest : NSObject <TBase, NSCoding> {
  AlertThriftThriftRequestBase * __commonBase;
  double __latitude;
  double __longtitude;

  BOOL __commonBase_isset;
  BOOL __latitude_isset;
  BOOL __longtitude_isset;
}

#if TARGET_OS_IPHONE || (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_5)
@property (nonatomic, retain, getter=commonBase, setter=setCommonBase:) AlertThriftThriftRequestBase * commonBase;
@property (nonatomic, getter=latitude, setter=setLatitude:) double latitude;
@property (nonatomic, getter=longtitude, setter=setLongtitude:) double longtitude;
#endif

- (id) init;
- (id) initWithCommonBase: (AlertThriftThriftRequestBase *) commonBase latitude: (double) latitude longtitude: (double) longtitude;

- (void) read: (id <TProtocol>) inProtocol;
- (void) write: (id <TProtocol>) outProtocol;

- (void) validate;

#if !__has_feature(objc_arc)
- (AlertThriftThriftRequestBase *) commonBase;
- (void) setCommonBase: (AlertThriftThriftRequestBase *) commonBase;
#endif
- (BOOL) commonBaseIsSet;

#if !__has_feature(objc_arc)
- (double) latitude;
- (void) setLatitude: (double) latitude;
#endif
- (BOOL) latitudeIsSet;

#if !__has_feature(objc_arc)
- (double) longtitude;
- (void) setLongtitude: (double) longtitude;
#endif
- (BOOL) longtitudeIsSet;

@end

@protocol AlertThriftThriftAlertService <NSObject>
- (AlertThriftThriftPingResponse *) ping: (AlertThriftThriftRequestBase *) request;  // throws AlertThriftThriftException *, TException
- (void) authorize: (AlertThriftThriftRequestBase *) request;  // throws AlertThriftThriftException *, TException
- (void) alert: (AlertThriftThrifAlertLocationRequest *) request;  // throws AlertThriftThriftException *, TException
- (void) location: (AlertThriftThrifAlertLocationRequest *) request;  // throws AlertThriftThriftException *, TException
@end

@interface AlertThriftThriftAlertServiceClient : NSObject <AlertThriftThriftAlertService> {
  id <TProtocol> inProtocol;
  id <TProtocol> outProtocol;
}
- (id) initWithProtocol: (id <TProtocol>) protocol;
- (id) initWithInProtocol: (id <TProtocol>) inProtocol outProtocol: (id <TProtocol>) outProtocol;
@end

@interface AlertThriftThriftAlertServiceProcessor : NSObject <TProcessor> {
  id <AlertThriftThriftAlertService> mService;
  NSDictionary * mMethodMap;
}
- (id) initWithThriftAlertService: (id <AlertThriftThriftAlertService>) service;
- (id<AlertThriftThriftAlertService>) service;
@end

@interface AlertThriftAlertConstants : NSObject {
}
@end