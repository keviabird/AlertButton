//
//  SyncroService.h
//  PanicButton
//
//  Created by Елена Грачева on 02.04.15.
//  Copyright (c) 2015 BACCA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AlertThriftThriftPingResponse;

@interface SynchroService : NSObject

+(AlertThriftThriftPingResponse *)ping;
+(void)authorize;
+(void)location;
+(void)alert;

@end
