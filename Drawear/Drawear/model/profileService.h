//
//  profileService.h
//  Drawear
//
//  Created by 钱晟 on 15/1/9.
//  Copyright (c) 2015年 DrawearGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Profile.h"
@interface profileService : NSObject

+ (BOOL) userLogin: (NSString*) phone password:(NSString*) password;
+ (BOOL) userLogin2: (NSString*) phone password:(NSString*) password;
+ (BOOL) userRegister:(NSString*)phone name:(NSString*)name password:(NSString*)password ;
@end


