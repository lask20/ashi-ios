//
//  SettingsTableViewController.m
//  ASHI
//
//  Created by Nuttapong Kittichaiwattanakul on 12/11/2558 BE.
//  Copyright © 2558 Location. All rights reserved.
//

#import "SettingsTableViewController.h"

@interface SettingsTableViewController () {
    NSDictionary *settingItems;
    NSArray *settingSectionTitles;
    NSMutableArray *arSelectedRows;
}
@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Settings";
    settingItems = @{@"Select Priority to show": @[@"All Priority", @"Low", @"Medium", @"High", @"Critical"]};
    settingSectionTitles = [settingItems allKeys];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"settings"];
    self.tableView.allowsMultipleSelection = NO;
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User",];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [settingSectionTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *sectionTitle = [settingSectionTitles objectAtIndex:section];
    NSArray *sectionSettings = [settingItems objectForKey:sectionTitle];
    return [sectionSettings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell" forIndexPath:indexPath];
    // Configure the cell
    NSString *sectionTitle = [settingSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionSettings = [settingItems objectForKey:sectionTitle];
    cell.textLabel.text = [sectionSettings objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    if([arSelectedRows containsObject:indexPath]) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    } else {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    return cell;
}

//- (NSArray *)getSelections {
//    NSMutableArray *selections = [[NSMutableArray alloc] init];
//    for(NSIndexPath *indexPath in arSelectedRows) {
//        [selections addObject:[[settingItems objectForKey:@"Select Priority to show"][row] objectAtIndex:indexPath.row]];
//    }
//    return selections;
//}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [settingSectionTitles objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    for (UITableViewCell *cell in [tableView visibleCells]) {
    //        cell.accessoryType = UITableViewCellAccessoryNone;
    //    }
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    long row = indexPath.row;
    
    if(cell.accessoryType == UITableViewCellAccessoryNone){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [currentInstallation addUniqueObject:[settingItems objectForKey:@"Select Priority to show"][row] forKey:@"channels"];
        [arSelectedRows addObject:indexPath];
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [currentInstallation removeObject:[settingItems objectForKey:@"Select Priority to show"][row] forKey:@"channels"];
        [arSelectedRows removeObject:indexPath];
    }
    [currentInstallation saveInBackground];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSLog(@"%lu", (unsigned long) self.getSelections.count);
//    [self.tableView reloadData];
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
//    /* Create custom view to display section header... */
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
//    [label setFont:[UIFont boldSystemFontOfSize:12]];
//    NSString *sectionTitle = [settingSectionTitles objectAtIndex:section];
//    /* Section header is in 0th index... */
//    [label setText:sectionTitle];
//    [view addSubview:label];
//    [view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]]; //your background color...
//    return view;
//}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//}

@end
