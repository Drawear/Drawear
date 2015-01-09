//
//  Order.h
//  Drawear
//
//  Created by 何文琦 on 1/9/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AddressInfo.h"
@interface Order : NSObject

@property NSString* pictureName;
@property AddressInfo* address;
@property UIImage* picture;
@property NSString* requirement;
@property NSString* size;
@property int status;

@end
