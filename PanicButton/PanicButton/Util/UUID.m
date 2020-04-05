//
//  NSString+UUID.m
//  iOrdClient
//
//  Created by Топс on 20.06.12.
//  Copyright (c) 2012 bacca.pro. All rights reserved.
//

#import "UUID.h"

@implementation UUID

+ (NSString *)uuid
{
    NSString *uuidString = nil;
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    if (uuid) {
        uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
    }
    return uuidString;
}

@end
