//
//  ViewController.m
//  Drawear
//
//  Created by 何文琦 on 1/1/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()

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
    [self performSegueWithIdentifier:@"loginToMain" sender:self];
}

@end
