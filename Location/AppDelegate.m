//
//  LocationAppDelegate.m
//  Location
//
//  Created by Rick
//  Copyright (c) 2014 Location. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@implementation AppDelegate{
    
}

- (void)setAppearanceTabBarController {
    //Changing Color of Tab Bar
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:0.18 green:0.62 blue:0.99 alpha:1.0]];
    //StateSelected should be different, you should add this code
    [UITabBarItem.appearance setTitleTextAttributes:
     @{NSForegroundColorAttributeName : [UIColor whiteColor]}
                                           forState:UIControlStateSelected];
    
    
}

- (void)setApperanceTableViewController {
    //[[UITableView appearance] setBackgroundColor:[UIColor colorWithRed:0.93 green:0.96 blue:0.99 alpha:1.0]];
    //[[UITableViewCell appearance] setBackgroundColor:[UIColor colorWithRed:0.93 green:0.96 blue:0.99 alpha:1.0]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // reset badge
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    if (currentInstallation.badge != 0) {
        currentInstallation.badge = 0;
        [currentInstallation saveEventually];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setAppearanceTabBarController];
    [self setApperanceTableViewController];
    
    [Parse enableLocalDatastore];
    
    [Parse setApplicationId:@"p8k9QuDshK6V5fJ6MG1deZ7Oj41KwMxdYGHt8wW7"
                  clientKey:@"pYMakVuJYP18ofh12BxLMrA2jPLh0EJ3mMx0sz3L"];
    
    [PFUser enableAutomaticUser];
    
    PFACL *defaultACL = [PFACL ACL];
    
    // If you would like all objects to be private by default, remove this line.
    //[defaultACL setPublicReadAccess:YES];
    
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    // Register for Push Notitications
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    
    
    

    
     UIAlertController *alert;
    
    //We have to make sure that the Background App Refresh is enable for the Location updates to work in the background.
    if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied){
        
        alert = [UIAlertController alertControllerWithTitle:@""
                                          message:@"The app doesn't work without the Background App Refresh enabled. To turn it on, go to Settings > General > Background App Refresh"
                                         preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handel your yes please button action here
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                    }];
        [alert addAction:okButton];
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
        
    } else if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted) {

        alert = [UIAlertController alertControllerWithTitle:@""
                                          message:@"The functions of this app are limited because the Background App Refresh is disable."
                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handel your yes please button action here
                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                   }];
        [alert addAction:okButton];
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
        
    } else {
        [PFConfig getConfigInBackgroundWithBlock:^(PFConfig *config, NSError *error) {
            NSTimeInterval time = 60;
            if (!error) {
                NSLog(@"Yay! Config was fetched from the server.");
                
            } else {
                NSLog(@"Failed to fetch. Using Cached Config.");
                config = [PFConfig currentConfig];
                
            }
            time = [config[@"LocationUpdateTime"] doubleValue];
            
            
            self.locationTracker = [[LocationTracker alloc]init];
            [self.locationTracker startLocationTracking];
            
            //Send the best location to server every 60 seconds
            //You may adjust the time interval depends on the need of your app.
            NSLog(@"time %f",time);
            self.locationUpdateTimer =
            [NSTimer scheduledTimerWithTimeInterval:time
                                             target:self
                                           selector:@selector(updateLocation)
                                           userInfo:nil
                                            repeats:YES];
            
            
            
        }];
        
        
        
    }
    
    return YES;
}

-(void)updateLocation {
    NSLog(@"updateLocation");
    [self.locationTracker updateLocationToServer];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
