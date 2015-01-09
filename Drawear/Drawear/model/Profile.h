//
//  Profile.h
//  Drawear
//
//  Created by 何文琦 on 1/8/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Profile : NSObject<NSCoding>

@property NSString* phone;
@property NSString* name;
@property int defaultAddress;

+(Profile*) getCurrProfile;
+(void) setCurrProfile:(Profile*) profile;

@end
