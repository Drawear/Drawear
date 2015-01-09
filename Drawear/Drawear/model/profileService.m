//
//  profileService.m
//  Drawear
//
//  Created by 钱晟 on 15/1/9.
//  Copyright (c) 2015年 DrawearGroup. All rights reserved.
//

#import "profileService.h"
#import "HttpHelper.h"

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

@end
