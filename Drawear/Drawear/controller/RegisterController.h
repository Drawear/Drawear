//
//  RegisterController.h
//  Drawear
//
//  Created by 何文琦 on 1/2/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "profileService.h"
@interface RegisterController : UIViewController
- (IBAction)buttonRegister:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end
