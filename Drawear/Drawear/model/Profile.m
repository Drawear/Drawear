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
#define oOrders @"orders"
#define oAddress @"otherAddress"
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
    [encoder encodeObject:self.addresses forKey:oAddress];
    [encoder encodeObject:self.orders forKey:oOrders];
    [encoder encodeObject:self.name forKey:oNameKey];
    [encoder encodeObject:self.phone forKey:oPhoneKey];
    [encoder encodeInt:self.defaultAddress forKey:oAddrKey];

}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.name= [decoder decodeObjectForKey:oNameKey];
        self.defaultAddress=[decoder decodeIntForKey:oAddrKey];
        self.phone=[decoder decodeObjectForKey:oPhoneKey];
        self.addresses = [decoder decodeObjectForKey:oAddress];
        self.orders = [decoder decodeObjectForKey:oOrders];
    }
    return self;
}

- (void)save{
    NSString *documentPath       = [self getDocumentPath];
    NSString *arrayFilePath      = [documentPath stringByAppendingPathComponent:@"profile.plist"];
    BOOL isSuccess=NO;
    isSuccess= [NSKeyedArchiver archiveRootObject:self toFile:arrayFilePath];
    if (isSuccess) {
        NSLog(@"Success");
    }else{
        NSLog(@"False");
    }
    
}

-(void)loadSavedData{
    // 获取文件路径
    NSString *documentPath       = [self getDocumentPath];
    NSString *arrayFilePath      = [documentPath stringByAppendingPathComponent:@"profile.plist"];
    
    // 恢复对象
    currProfile  = [NSKeyedUnarchiver unarchiveObjectWithFile:arrayFilePath];
    
    
}

- (NSString *)getDocumentPath {
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = documents[0];
    return documentPath;
}

@end
