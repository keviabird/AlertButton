//
//  ConnectionUnreachableException.m
//  PanicButton
//
//  Created by Елена Грачева on 08.04.15.
//  Copyright (c) 2015 BACCA. All rights reserved.
//

#import "ConnectionUnreachableException.h"

@implementation ConnectionUnreachableException

- (id) init
{
    return [super initWithName: @"ConnectionUnreachableException" reason: @"unknown" userInfo: nil];
}

@end
