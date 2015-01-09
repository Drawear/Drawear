//
//  ViewController.m
//  Drawear
//
//  Created by 何文琦 on 1/1/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import "LoginController.h"
#import "profileService.h"

@interface LoginController ()
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonLogin:(UIButton *)sender {
    bool result = [profileService userLogin:self.phone.text password:self.password.text];
    if (result) {
        [self performSegueWithIdentifier:@"loginToMain" sender:self];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cannot login." message:@"Please check your login message." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        // optional - add more buttons
        [alert show];
    }

}

@end
