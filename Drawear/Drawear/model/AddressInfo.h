//
//  AddressInfo.h
//  Drawear
//
//  Created by 何文琦 on 1/9/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressInfo : NSObject<NSCoding>

@property NSString* province;
@property NSString* city;
@property NSString* street;
@property NSString* postcode;

@end
