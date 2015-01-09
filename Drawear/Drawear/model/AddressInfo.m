//
//  AddressInfo.m
//  Drawear
//
//  Created by 何文琦 on 1/9/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import "AddressInfo.h"
#define oAddressID @"addressID"
#define oProvinceKey @"province"
#define oCityKey @"city"
#define oStreetKey @"street"
#define oPostcodeKey @"postcode"

@implementation AddressInfo

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt:self.addressID forKey:oAddressID];
    [encoder encodeObject:self.province forKey:oProvinceKey];
    [encoder encodeObject:self.city forKey:oCityKey];
    [encoder encodeObject:self.street forKey:oStreetKey];
    [encoder encodeObject:self.postcode forKey:oPostcodeKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.addressID = [decoder decodeIntForKey:oAddressID];
        self.province= [decoder decodeObjectForKey:oProvinceKey];
        self.city=[decoder decodeObjectForKey:oCityKey];
        self.street=[decoder decodeObjectForKey:oStreetKey];
        self.postcode=[decoder decodeObjectForKey:oPostcodeKey];
    }
    return self;
}

@end
