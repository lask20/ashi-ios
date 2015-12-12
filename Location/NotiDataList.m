//
//  SettingsMenu.m
//  ASHI
//
//  Created by Nuttapong Kittichaiwattanakul on 12/11/2558 BE.
//  Copyright © 2558 Location. All rights reserved.
//

#import "NotiDataList.h"
#import "NotiData.h"

@implementation NotiDataList {
    NSArray *notiAnnotation;
    NSArray *notiLists;
}

- (id)initWithDefaultData {
    self = [super init];
    if (self) {
        [self setupData];
    }
    return self;
}

- (NotiData *)notiDataAtIndex:(NSUInteger)index {
    return notiLists[index];
}

- (NSUInteger)count {
    return notiLists.count;
}

- (void)setupData {
    PFQuery *query = [PFQuery queryWithClassName:@"NotiData"];
    [query addDescendingOrder:@"createdAt"];
    NSArray *objects = [query findObjects];
    NSMutableArray *tmp = [NSMutableArray array];
    for (PFObject *object in objects) {
        [tmp addObject:[[NotiData alloc] initWithPFObject:object]];
    }
    notiLists = [NSArray arrayWithArray:tmp];
}

//- (NSArray *)getNotiDataAnnotation {
//    NSMutableArray *AnnotationTmp = [NSMutableArray array];
//    for (NotiData *notiTmp in notiLists) {
//        [AnnotationTmp addObject:[notiTmp getAnnotationWithPFObject]];
//    }
//    [notiAnnotation] = [NSArray arrayWithArray:AnnotationTmp];
//    return notiAnnotation;
//}

+ (id)defaultNotiData {
    return [[[self class] alloc] initWithDefaultData];
}

@end
