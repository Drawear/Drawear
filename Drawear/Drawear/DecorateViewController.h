//
//  DecorateViewController.h
//  Drawear
//
//  Created by 何文琦 on 1/9/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POHorizontalList.h"
#import "POHorizontalListDelegate.h"
@protocol addItemDelegate;



@interface DecorateViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,POHorizontalListDelegate> {
    NSMutableArray *itemArray;
        NSMutableArray *freeList;
    NSMutableArray *paidList;
    NSMutableArray *grossingList;
}

@property (nonatomic, assign) id<addItemDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end

@protocol addItemDelegate <NSObject>

- (void) didAddItem:(UIImage*) image;

@end