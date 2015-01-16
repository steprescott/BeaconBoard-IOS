//
//  Session+Addtions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Session+Addtions.h"
#import "ContextManager.h"

@implementation Session (Addtions)

+ (void)importSessions:(NSArray *)sessions intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [Session sqk_insertOrUpdate:sessions
                      uniqueModelKey:@"sessionID"
                     uniqueRemoteKey:@"SessionID"
                 propertySetterBlock:^(NSDictionary *dictionary, Session *managedObject) {
                     managedObject.sessionID = dictionary[@"SessionID"];
                     managedObject.scheduledDate = [dateFormatter dateFromString:dictionary[@"ScheduledDate"]];
                     managedObject.room = [Room sqk_insertOrFetchWithKey:@"roomID"
                                                                   value:dictionary[@"RoomID"]
                                                                 context:context
                                                                   error:error];
                     
                     managedObject.lesson = [Lesson sqk_insertOrFetchWithKey:@"lessonID"
                                                                       value:dictionary[@"LessonID"]
                                                                     context:context
                                                                       error:error];
                     
                     [dictionary[@"LectureIDs"] enumerateObjectsUsingBlock:^(NSString *lecureID, NSUInteger idx, BOOL *stop) {
                         //Add lectures when there is a Lecture MO
                     }];
                 }
                      privateContext:context
                               error:error];
}

@end
