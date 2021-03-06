//
//  OrderTableViewController.m
//  Drawear
//
//  Created by 何文琦 on 1/8/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import "OrderTableViewController.h"
#import "Profile.h"

@interface OrderTableViewController ()

@end

@implementation OrderTableViewController

- (void)viewDidLoad {
//    Order* o1=[[Order alloc]init];
//    o1.pictureName=@"picture1";
//    o1.count=1;
//    Order* o2=[[Order alloc]init];
//    o2.pictureName=@"picture2";
//    o2.count=2;
//    Order* o3=[[Order alloc]init];
//    o3.pictureName=@"picture3";
//    o3.count=3;
    
    self.orders=[Profile getCurrProfile].orders;
//    NSLog(@"count: %d",self.orders.count);
//    self.orders = [NSMutableArray arrayWithObjects:o1,o2,o3, nil];
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.orders.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = [indexPath section];
    Order* order=[self.orders objectAtIndex:section];
    
    if (indexPath.row==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderRightCell" forIndexPath:indexPath];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        cell.textLabel.text=[formatter stringFromDate:order.date];
        cell.textLabel.textColor=[UIColor lightGrayColor];
        cell.detailTextLabel.text=@"";
        return cell;
    }else if(indexPath.row==1){
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"orderSubtitleCell"];
        cell.imageView.image=[UIImage imageNamed:order.pictureName];
        cell.textLabel.text=order.pictureName;
        cell.detailTextLabel.text=[NSString stringWithFormat:@"x%d",order.count];
        return cell;
    }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderRightCell" forIndexPath:indexPath];
        cell.textLabel.text=[NSString stringWithFormat:@"Total Price: $%d",order.count*50];
        cell.textLabel.textColor=[UIColor colorWithRed:234.0/255.0 green:113.0/255.0 blue:114.0/255.0 alpha:1.0];
        cell.detailTextLabel.text=@"Delete";
        cell.detailTextLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;//边框颜色,要为CGColor
        cell.detailTextLabel.layer.borderWidth = 1;//边框宽度
        cell.detailTextLabel.layer.cornerRadius = 10;
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==1) {
        return 100;
    }
    return 50;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
