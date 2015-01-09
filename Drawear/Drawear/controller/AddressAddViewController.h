//
//  AddressAddViewController.h
//  Drawear
//
//  Created by 钱晟 on 15/1/9.
//  Copyright (c) 2015年 DrawearGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressInfo.h"
@interface AddressAddViewController : UIViewController
- (IBAction)buttonCancle:(id)sender;

- (IBAction)buttonDone:(id)sender;
@property AddressInfo* addr;

@end
