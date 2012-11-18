//
//  MMStudent.h
//  MMTableMadness
//
//  Created by Don Bora on 11/14/12.
//  Copyright (c) 2012 Don Bora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MMClass;

@interface MMStudent : NSManagedObject

@property (nonatomic, retain) NSString * addressLineOne;
@property (nonatomic, retain) NSString * addressLineTwo;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * postalCode;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) MMClass *mmclass;

@end
