//
//  AddressInfo.m
//  Drawear
//
//  Created by 何文琦 on 1/9/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import "AddressInfo.h"
#define oAddID @"addID"
#define oProvinceKey @"province"
#define oCityKey @"city"
#define oStreetKey @"street"
#define oPostcodeKey @"postcode"

@implementation AddressInfo

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt:self.addID forKey:oAddID];
    [encoder encodeObject:self.province forKey:oProvinceKey];
    [encoder encodeObject:self.city forKey:oCityKey];
    [encoder encodeObject:self.street forKey:oStreetKey];
    [encoder encodeObject:self.postcode forKey:oPostcodeKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.addID = [decoder decodeIntForKey:oAddID];
        self.province= [decoder decodeObjectForKey:oProvinceKey];
        self.city=[decoder decodeObjectForKey:oCityKey];
        self.street=[decoder decodeObjectForKey:oStreetKey];
        self.postcode=[decoder decodeObjectForKey:oPostcodeKey];
    }
    return self;
}

-(NSString*) getAdd{
    return [NSString stringWithFormat:@"%@,%@,%@, 邮编%@", self.province, self.city, self.street, self.postcode];
}

+(AddressInfo*) getExample{
    AddressInfo* add = [[AddressInfo alloc] init];
    add.addID = 1;
    add.province = @"上海市";
    add.city = @"长宁区";
    add.street = @"蔡伦路1433号";
    add.postcode = @"201203";
    
    return add;
}

@end
