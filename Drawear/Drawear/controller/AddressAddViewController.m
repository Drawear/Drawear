//
//  AddressAddViewController.m
//  Drawear
//
//  Created by 钱晟 on 15/1/9.
//  Copyright (c) 2015年 DrawearGroup. All rights reserved.
//

#import "AddressAddViewController.h"
#import "AddressTableViewController.h"
#import "Profile.h"
@interface AddressAddViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *textProvince;
@property (weak, nonatomic) IBOutlet UITextField *textCity;
@property (weak, nonatomic) IBOutlet UITextField *textStreet;
@property (weak, nonatomic) IBOutlet UITextField *textPostcode;

@end

@implementation AddressAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if(sender!=self.doneButton) return;
    self.addr=[[AddressInfo alloc] init];
    self.addr.province=@"test";
    self.addr.city=@"test";
    self.addr.street=@"teststreet";
    self.addr.postcode=@"310011";
   
//    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)buttonCancle:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)buttonDone:(id)sender {
    self.addr=[[AddressInfo alloc] init];
    self.addr.province=self.textProvince.text;
    self.addr.city=self.textCity.text;
    self.addr.street=self.textStreet.text;
    self.addr.postcode=self.textPostcode.text;
    
    Profile* profile = [Profile getCurrProfile];
    [profile.addresses addObject:self.addr];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
