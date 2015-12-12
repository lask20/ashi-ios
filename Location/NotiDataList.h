//
//  SettingsMenu.h
//  ASHI
//
//  Created by Nuttapong Kittichaiwattanakul on 12/11/2558 BE.
//  Copyright © 2558 Location. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
@class NotiData;

@interface NotiDataList : NSObject

- (id)initWithDefaultData;
- (NotiData *) notiDataAtIndex:(NSUInteger)index;
- (NSUInteger) count;
- (NSArray *) getNotiDataAnnotation;
+ (id)defaultNotiData;

@end
