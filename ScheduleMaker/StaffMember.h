//
//  StaffMember.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 4/11/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

// Insert code here to declare functionality of your managed object subclass
@interface StaffMember : NSManagedObject

+ (StaffMember *)searchStaffMembersByName:(NSString *)name;
+ (void)addStaffMemberFromDictionary:(NSDictionary *)staffMemberInfo;
+ (void)editStaffMemberFromDictionary:(NSDictionary *)staffMemberInfo;
+ (void)deleteStaffMemberWithName:(NSString *)name;
+ (NSArray *)getContentsOfDatabase;
+ (NSArray *)searchStaffMembersBeginningWith:(NSString *)substring;
+ (NSInteger)getNumberOfEntries;

@end

NS_ASSUME_NONNULL_END

#import "StaffMember+CoreDataProperties.h"