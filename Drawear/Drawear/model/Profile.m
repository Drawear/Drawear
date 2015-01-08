//
//  Profile.m
//  Drawear
//
//  Created by 何文琦 on 1/8/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import "Profile.h"
static Profile* currProfile=nil;

@implementation Profile

+(Profile*) getCurrProfile
{
    return currProfile;
}

+(void) setCurrProfile:(Profile*) profile
{
    currProfile=[[Profile alloc] init];
    //set values
}

@end
