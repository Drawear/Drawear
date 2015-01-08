//
//  HttpHelper.h
//  Drawear
//
//  Created by 何文琦 on 1/8/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpHelper : NSObject

+(void) setBaseUrl:(NSString*)url;
+(NSData *)getWithEndpoint:(NSString*) endpoint parameters:(NSDictionary*)param;
+(NSData *)postWithEndpoint:(NSString*) urlString parameters:(NSDictionary*)param;

@end
