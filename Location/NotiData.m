//
//  HelpMenu.m
//  ASHI
//
//  Created by Nuttapong Kittichaiwattanakul on 12/11/2558 BE.
//  Copyright © 2558 Location. All rights reserved.
//

#import "NotiData.h"

@implementation NotiData

static const NSString *kId = @"id";
static const NSString *kTitle = @"message";
static const NSString *kPiority = @"priority";
static const NSString *kDetails = @"details";
static const NSString *kFullname= @"fullname";

- (id)initWithPFObject:(PFObject *)object {
    self = [super init];
    if (self) {
        self.id = object.objectId;
        self.message = object[@"message"];
        self.priority = object[@"priority"];
        self.details = object[@"details"];
        self.createdAt = object.createdAt;
        self.fullname = object[@"fullName"];
    }
    return self;
}

//-(DiaryMKPointAnnotation *)getAnnotationWithPFObject{
//    DiaryMKPointAnnotation *point = [[DiaryMKPointAnnotation alloc]init];
//    point.title = self.title;
//    point.subtitle = self.locationName;
//    point.coordinate = CLLocationCoordinate2DMake(self.locationGeoPoint.latitude,self.locationGeoPoint.longitude);
//    point.diary = self;
//    return point;
//}

@end

