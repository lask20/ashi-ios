//
//  HelpMenu.h
//  ASHI
//
//  Created by Nuttapong Kittichaiwattanakul on 12/11/2558 BE.
//  Copyright © 2558 Location. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface NotiData : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *priority;
@property (strong, nonatomic) NSString *details;
@property (strong, nonatomic) NSArray *geoValues;
@property (strong, nonatomic) NSDate *createdAt;

- (id)initWithPFObject:(PFObject *)object;
//- (MKPointAnnotation *)getAnnotationWithPFObject;

@end
