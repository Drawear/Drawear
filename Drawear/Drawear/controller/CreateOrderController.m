//
//  CreateOrderController.m
//  Drawear
//
//  Created by 钱晟 on 15/1/9.
//  Copyright (c) 2015年 DrawearGroup. All rights reserved.
//

#import "CreateOrderController.h"
#import "Profile.h"
#import "AddressInfo.h"
#import "Order.h"

@interface CreateOrderController ()
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;

@property (weak, nonatomic) IBOutlet UILabel *labelPhone;
@property UIImage* image;
@property int addIndex;
@end

@implementation CreateOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Profile* profile = [Profile getCurrProfile];
    self.labelName.text = profile.name;
    self.labelPhone.text = profile.phone;
    
    NSMutableArray* addresses = profile.addresses;
    self.addIndex = profile.defaultAddress;
    
    for (int i = 0; i < [addresses count]; i++) {
        AddressInfo* currentAdd = [addresses objectAtIndex:i];
        if (self.addIndex == currentAdd.addID) {
            self.labelAddress.text = currentAdd.getAdd;
        }
    }
    
    self.labelAddress.numberOfLines = 0;//表示label可以多行显示
    
    self.labelAddress.frame = CGRectMake(self.labelAddress.frame.origin.x, self.labelAddress.frame.origin.y, self.labelAddress.frame.size.width, self.labelAddress.frame.size.height);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"changeAddr"]) {
        AddressTableViewController* controller=[segue destinationViewController];
        controller.delegate=self;
    }
}

- (IBAction)createOrder:(id)sender {
    Order* newOrder = [[Order alloc] init];
    newOrder.picture = self.image;
    newOrder.address = self.addIndex;
    newOrder.size = @"M";
    newOrder.status = 1;
    newOrder.date = [NSDate date];
    
    Profile* profile = [Profile getCurrProfile];
    NSMutableArray* orders = profile.orders;
    [orders addObject:newOrder];
    
}

#pragma mark - changeAddrDelegate

- (void)addrTable:(AddressTableViewController*)tableView didChangeWithString:(NSString*)address{
    
    self.labelAddress.text = address;
    
}


@end
