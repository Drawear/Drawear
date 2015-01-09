//
//  profileService.m
//  Drawear
//
//  Created by 钱晟 on 15/1/9.
//  Copyright (c) 2015年 DrawearGroup. All rights reserved.
//

#import "profileService.h"
#import "HttpHelper.h"
#import "AddressInfo.h"
#import "Order.h"

@implementation profileService

+(BOOL)userLogin:(NSString *)phone password:(NSString *)password{
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:phone, @"phone", password, @"password", nil];
    NSData* returnData = [HttpHelper postWithEndpoint:@"Login" parameters: dict];
    NSString* result = [[NSString alloc] initWithData:returnData  encoding:NSUTF8StringEncoding];
    NSLog(@"return:%@", result);
    
    NSString* parsedResult=[result substringFromIndex:9];
    parsedResult = [parsedResult substringToIndex:5];
   
    if ([parsedResult isEqualToString:@"false"]) {
        return false;
    }else{
        return true;
    }

    return false;
}

+(BOOL)userLogin2:(NSString *)phone password:(NSString *)password{
//    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:phone, @"phone", password, @"password", nil];
//    NSData* returnData = [HttpHelper postWithEndpoint:@"Login" parameters: dict];
//    NSString* result = [[NSString alloc] initWithData:returnData  encoding:NSUTF8StringEncoding];
//    NSLog(@"return:%@", result);
//    
//    NSString* parsedResult=[result substringFromIndex:9];
//    parsedResult = [parsedResult substringToIndex:5];
//    
//    if ([parsedResult isEqualToString:@"false"]) {
//        return false;
//    }else{
//        return true;
//    }
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSString*pass=[accountDefaults stringForKey:phone];
    if([pass isEqualToString:password]){
        Profile* profile=[[Profile alloc]init];
        profile.name=@"admin";
        profile.phone=phone;
        profile.defaultAddress = 1;
        NSMutableArray* addr = [[NSMutableArray alloc] init];
        [addr addObject:[AddressInfo getExample]];
        profile.addresses = addr;
        
        NSMutableArray* orders = [[NSMutableArray alloc] init];
        [orders addObject:[Order getExample]];
        profile.orders = orders;
        
        [Profile setCurrProfile:profile];
        [profile save];
        return true;
    }
    return false;
}

+(BOOL)userRegister:(NSString *)phone name:(NSString *)name password:(NSString *)password{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSString*pass=[accountDefaults stringForKey:phone];
    if (pass==nil) {
//        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
        [accountDefaults setValue:password forKey:phone];
        return true;
    }
    return false;
}
@end
