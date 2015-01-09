//
//  DrawCompleteController.m
//  Drawear
//
//  Created by 钱晟 on 15/1/9.
//  Copyright (c) 2015年 DrawearGroup. All rights reserved.
//

#import "DrawCompleteController.h"

@interface DrawCompleteController ()
@property (strong, nonatomic) UIImage *image;

@end

@implementation DrawCompleteController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.shirt.image = self.image;
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"createOrder"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Prepare to create an order." message:@"Please check your information." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        // optional - add more buttons
        [alert show];
        
        UIViewController* view = segue.destinationViewController;
        [view setValue:self.image forKey:@"image"];

    }
}

@end
