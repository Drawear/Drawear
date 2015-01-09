//
//  DecorateViewController.m
//  Drawear
//
//  Created by 何文琦 on 1/9/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import "DecorateViewController.h"
#import "POHorizontalList.h"
@interface DecorateViewController ()

@end


@implementation DecorateViewController
@synthesize delegate = _delegate;

- (void)viewDidLoad {
    ListItem *item1 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Model.png"] text:@"Weather"];
    ListItem *item2 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Model.png"] text:@"Shopping"];
    ListItem *item3 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Model.png"] text:@"E-Trade"];
    ListItem *item4 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Model.png"] text:@"Voice Recorder"];
    ListItem *item5 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Model.png"] text:@"News Reader"];
    ListItem *item6 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Model.png"] text:@"Game Pack"];
    ListItem *item7 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Model.png"] text:@"Game Pack"];
    ListItem *item8 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Model.png"] text:@"Game Pack"];
    ListItem *item9 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Model.png"] text:@"Game Pack"];
    ListItem *item10 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Model.png"] text:@"Game Pack"];
    
    freeList = [[NSMutableArray alloc] initWithObjects: item1, item2, item3, item4, item5, item6, item7, item8,item9, item10,nil];
   
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *title = @"";
    POHorizontalList *list=[[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, 768.0, 160.0) title:title items:freeList];;
    
    title = @"Top Free";
    
    [list setDelegate:self];
    [cell.contentView addSubview:list];
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    NSLog(@"segue");
}


#pragma mark  POHorizontalListDelegate

- (void) didSelectItem:(ListItem *)item {
//    NSLog(@"Horizontal List Item %@ selected", item.imageTitle);
    [_delegate didAddItem:item.image];
}

@end
