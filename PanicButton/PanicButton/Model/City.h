//
//  City.h
//  PanicButton
//
//  Created by Елена Грачева on 03.04.15.
//  Copyright (c) 2015 BACCA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface City : NSManagedObject

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * en;
@property (nonatomic, retain) NSString * ru;

@end
