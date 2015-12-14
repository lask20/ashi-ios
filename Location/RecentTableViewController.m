//
//  RecentTableViewController.m
//  ASHI
//
//  Created by Nuttapong Kittichaiwattanakul on 12/11/2558 BE.
//  Copyright © 2558 Location. All rights reserved.
//

#import "RecentTableViewController.h"
#import "NotiData.h"
#import "NotiDataList.h"

@interface RecentTableViewController ()

@end

@implementation RecentTableViewController {
    NotiDataList *notiData;

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"clock"];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self reload];
    [refreshControl endRefreshing];
}

- (void)reload {
    [self setupData];
    [self.tableView reloadData];
}

- (void)setupData {
    notiData = [NotiDataList defaultNotiData];
}



- (void)setupUI {
    self.title = @"Recents";
    self.navigationItem.title = @"All ASHI Notifications";
    //[[UIView appearance] setTintColor:[UIColor whiteColor]];
    // Display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self reload];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [notiData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recentCell" forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:@"recentCell"];
        
    }
    
    [self setupCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)setupCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NotiData *notidatas = [notiData notiDataAtIndex:indexPath.row];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"hh:mm dd-MM-YY"];
    NSString *head = [NSString stringWithFormat:@"%@ @ %@", notidatas.fullname, [dateformatter stringFromDate:notidatas.createdAt]];
    cell.textLabel.text = head;
    cell.detailTextLabel.text = notidatas.message;
    //cell.textLabel.textColor = [UIColor whiteColor];
    //cell.detailTextLabel.textColor = [UIColor whiteColor];
    [cell setBackgroundColor:[UIColor clearColor]];
    if ([notidatas.priority containsString:@"Critical"]) {
        [cell setBackgroundColor:[UIColor colorWithRed:0.92 green:0.13 blue:0.13 alpha:1.0]];
    } else if ([notidatas.priority containsString:@"High"]) {
        [cell setBackgroundColor:[UIColor colorWithRed:0.95 green:0.54 blue:0.14 alpha:1.0]];
    } else if ([notidatas.priority containsString:@"Medium"]) {
        [cell setBackgroundColor:[UIColor colorWithRed:0.87 green:0.80 blue:0.16 alpha:1.0]];
    } else if ([notidatas.priority containsString:@"Low"]) {
        [cell setBackgroundColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0]];
    }
    
    //cell.DetailLabel.text = notidatas.message;
    //cell.DateLabel.text = [dateformatter stringFromDate:diary.diaryDate];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor whiteColor];
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
