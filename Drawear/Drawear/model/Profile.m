//
//  Profile.m
//  Drawear
//
//  Created by 何文琦 on 1/8/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import "Profile.h"
#define oNameKey @"name"
#define oPhoneKey @"phone"
#define oAddrKey @"address"
static Profile* currProfile=nil;

@implementation Profile

+(Profile*) getCurrProfile
{
    return currProfile;
}

+(void) setCurrProfile:(Profile*) profile
{
    currProfile=[[Profile alloc] init];
    currProfile.phone=profile.phone;
    currProfile.name=profile.name;
    currProfile.defaultAddress=profile.defaultAddress;
}

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:oNameKey];
    [encoder encodeObject:self.phone forKey:oPhoneKey];
    [encoder encodeInt:self.defaultAddress forKey:oAddrKey];

}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.name= [decoder decodeObjectForKey:oNameKey];
        self.defaultAddress=[decoder decodeIntForKey:oAddrKey];
        self.phone=[decoder decodeObjectForKey:oPhoneKey];

    }
    return self;
}

@end
