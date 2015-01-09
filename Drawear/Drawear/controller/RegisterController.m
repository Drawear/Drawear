//
//  RegisterController.m
//  Drawear
//
//  Created by 何文琦 on 1/2/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import "RegisterController.h"

@interface RegisterController ()

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonRegister:(id)sender {
    BOOL result = [profileService userRegister:self.phone.text name:self.name.text password:self.password.text];
    if (result) {
        [self performSegueWithIdentifier:@"registerToLogin" sender:self];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cannot register." message:@"Please check your register message." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        // optional - add more buttons
        [alert show];
    }
}
@end
