//
//  TabNavigationController.m
//  ASHI
//
//  Created by Jenpasit P. on 12/13/2558 BE.
//  Copyright © 2558 Location. All rights reserved.
//

#import "TabNavigationController.h"

@interface TabNavigationController ()

@end

@implementation TabNavigationController


- (void)setAppearanceNavigationController {
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.18 green:0.62 blue:0.99 alpha:1.0]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor]}];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAppearanceNavigationController];
    // Do any additional setup after loading the view.
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

@end
