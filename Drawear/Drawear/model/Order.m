//
//  Order.m
//  Drawear
//
//  Created by 何文琦 on 1/9/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import "Order.h"
#define oNameKey @"pictureName"
#define oAddrKey @"address"
#define oPictureKey @"picture"
#define oRequirementKey @"requirement"
#define oSizeKey @"size"
#define oCountKey @"count"
#define oStatusKey @"status"
#define oDate @"date"

@implementation Order

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.pictureName forKey:oNameKey];
    [encoder encodeInt:self.address forKey:oAddrKey];
    [encoder encodeObject:self.picture forKey:oPictureKey];
    [encoder encodeObject:self.requirement forKey:oRequirementKey];
    [encoder encodeObject:self.size forKey:oSizeKey];
    [encoder encodeInt:self.count forKey:oCountKey];
    [encoder encodeInt:self.status forKey:oStatusKey];
    [encoder encodeObject:self.date forKey:oDate];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.date = [decoder decodeObjectForKey:oDate];
        self.pictureName= [decoder decodeObjectForKey:oNameKey];
        self.address=[decoder decodeIntForKey:oAddrKey];
        self.picture=[decoder decodeObjectForKey:oPictureKey];
        self.requirement=[decoder decodeObjectForKey:oRequirementKey];
        self.size=[decoder decodeObjectForKey:oSizeKey];
        self.count=[decoder decodeIntForKey:oCountKey];
        self.status=[decoder decodeIntForKey:oStatusKey];
    }
    return self;
}

+(Order*) getExample{
    Order* order = [[Order alloc] init];
    order.pictureName = @"juhua";
    order.address = 1;
    order.picture = [UIImage imageNamed:@"juhua.jpg"];
    order.size = @"M";
    order.status = 1;
    order.count = 1;
    order.date = [NSDate date];
    
    return order;
}


@end
