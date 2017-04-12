//
//  StaffMember+CoreDataProperties.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 4/11/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "StaffMember.h"

NS_ASSUME_NONNULL_BEGIN

@interface StaffMember (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *fireguard;
@property (nullable, nonatomic, retain) NSNumber *other;
@property (nullable, nonatomic, retain) NSNumber *birthday;
@property (nullable, nonatomic, retain) NSNumber *manager;
@property (nullable, nonatomic, retain) NSNumber *lesson;
@property (nullable, nonatomic, retain) NSNumber *tours;
@property (nullable, nonatomic, retain) NSNumber *security;
@property (nullable, nonatomic, retain) NSNumber *greeting;
@property (nullable, nonatomic, retain) NSNumber *project;
@property (nullable, nonatomic, retain) NSNumber *floating;
@property (nullable, nonatomic, retain) NSNumber *gallery;
@property (nullable, nonatomic, retain) NSNumber *zero;
@property (nullable, nonatomic, retain) NSNumber *negOne;
@property (nullable, nonatomic, retain) NSNumber *coro;
@property (nullable, nonatomic, retain) NSNumber *trike;
@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END