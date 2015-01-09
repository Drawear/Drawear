//
//  AddressTableViewController.h
//  Drawear
//
//  Created by 钱晟 on 15/1/9.
//  Copyright (c) 2015年 DrawearGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol changeAddrDelegate;

@interface AddressTableViewController : UITableViewController

@property (nonatomic, weak) id<changeAddrDelegate> delegate;
@property NSMutableArray* address;

@end


@protocol changeAddrDelegate <NSObject>

@optional
- (void)addrTable:(AddressTableViewController*)tableView didChangeWithString:(NSString*)address;

@end