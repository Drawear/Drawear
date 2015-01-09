//
//  Line.m
//  DrawTutorial
//
//  Created by Sidney on 1/9/15.
//  Copyright (c) 2015 Sidney. All rights reserved.
//

#import "Line.h"

@implementation Line

@synthesize begin,end,color;

-(id)init
{
    self = [super init];
    if (self) {
        [self setColor:[UIColor blackColor]];
    }
    return self;
}

@end
