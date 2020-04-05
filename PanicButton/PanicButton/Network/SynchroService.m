//
//  SyncroService.m
//  PanicButton
//
//  Created by Елена Грачева on 02.04.15.
//  Copyright (c) 2015 BACCA. All rights reserved.
//

#import "SynchroService.h"
#import "Alert.h"
#import "Const.h"
#import "THTTPClient.h"
#import "TBinaryProtocol.h"
#import "Reachability.h"
#import "ConnectionUnreachableException.h"

#define PROTOCOL_VERSION @"alert_2015-03-18_001"
#define URL @"https://gw.baccasoft.ru:9443/alert_dev/"

@implementation SynchroService

+(AlertThriftThriftRequestBase *)getBase {
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *minorVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSString *login = [NSString stringWithFormat:@"%@%@", [[NSUserDefaults standardUserDefaults] objectForKey:NAME_CODE], [[NSUserDefaults standardUserDefaults] objectForKey:NAME_PHONE]];
    AlertThriftThriftRequestBase *base = [[AlertThriftThriftRequestBase alloc] initWithProtocolVersion:PROTOCOL_VERSION deviceId:[[NSUserDefaults standardUserDefaults] objectForKey:NAME_UUID] userLogin:login authToken:[[NSUserDefaults standardUserDefaults] objectForKey:NAME_SYSTEM_ID] clientPlatform:ThriftPlatformType_IPHONE pushToken:nil currentLanguage:language clientVersion:minorVersion];
    return base;
}

+(AlertThriftThrifAlertLocationRequest *)getLocationRequest {
    AlertThriftThrifAlertLocationRequest *request = [[AlertThriftThrifAlertLocationRequest alloc] initWithCommonBase:[self getBase] latitude:[[[NSUserDefaults standardUserDefaults] objectForKey:NAME_LATITUDE] doubleValue] longtitude:[[[NSUserDefaults standardUserDefaults] objectForKey:NAME_LONGTITUDE] doubleValue]];
    return request;
}

+(AlertThriftThriftAlertServiceClient *)getClient {
    NSURL *url = [NSURL URLWithString:[URL stringByAppendingString:@"thrift"]];
    THTTPClient *transport = [[THTTPClient alloc] initWithURL:url userAgent:@"iClient" timeout:180];
    TBinaryProtocol *protocol = [[TBinaryProtocol alloc] initWithTransport:transport strictRead:YES strictWrite:YES];
    return [[AlertThriftThriftAlertServiceClient alloc] initWithProtocol:protocol];
}

+(AlertThriftThriftPingResponse *)ping {
    NSLog(@"Send ping starting");
    [self checkReachability];
    AlertThriftThriftAlertServiceClient *client = [self getClient];
    @try {
        AlertThriftThriftPingResponse *result = [client ping:[self getBase]];
        NSLog(@"Send ping finished");
        return result;
    } @catch (AlertThriftThriftException *exception) {
        [self processThriftException:exception inServiceNamed:@"ping"];
    }
}

+(void)authorize {
    NSLog(@"Send authorize starting");
    [self checkReachability];
    AlertThriftThriftAlertServiceClient *client = [self getClient];
    @try {
        [client authorize:[self getBase]];
    } @catch (AlertThriftThriftException *exception) {
        [self processThriftException:exception inServiceNamed:@"authorize"];
    }
    NSLog(@"Send authorize finished");
}

+(void)location {
    NSLog(@"Send location starting");
    [self checkReachability];
    AlertThriftThriftAlertServiceClient *client = [self getClient];
    @try {
        [client location:[self getLocationRequest]];
    } @catch (AlertThriftThriftException *exception) {
        [self processThriftException:exception inServiceNamed:@"location"];
    }
        NSLog(@"Send location finished");
    }

+(void)alert {
    NSLog(@"Send alert starting");
    [self checkReachability];
    AlertThriftThriftAlertServiceClient *client = [self getClient];
    @try {
    [client alert:[self getLocationRequest]];
    } @catch (AlertThriftThriftException *exception) {
        [self processThriftException:exception inServiceNamed:@"alert"];
    }
    NSLog(@"Send alert finished");
}

+(void)checkReachability {
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
        ConnectionUnreachableException *ex = [[ConnectionUnreachableException alloc] init];
        @throw ex;
    }
}

+(void)processThriftException:(AlertThriftThriftException *)e inServiceNamed:(NSString *)name {
    NSLog(@"Error in %@: %@", name, e.logMessage);
    if (e.typeCode == ThriftExceptionType_AUTHENTICATION_FAILED) {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:NAME_CODE];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:NAME_PHONE];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:NAME_SYSTEM_ID];
    }
    @throw e;
}

@end
