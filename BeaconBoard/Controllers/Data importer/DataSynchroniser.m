//
//  DataImporter.m
//  BeaconBoard
//
//  Created by Ste Prescott on 15/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "DataSynchroniser.h"
#import "WebClient.h"
#import "ContextManager.h"

@implementation DataSynchroniser

+ (void)syncData
{
    [DataSynchroniser syncDataWithUsername:nil];
}

+ (void)syncDataWithUsername:(NSString *)username
{
    NSError *error;
    NSManagedObjectContext *context = [ContextManager newPrivateContext];
    
    //Attandances
    NSArray *attendances = [[WebClient sharedClient] GETAllAttendancesError:&error];
    [Attendance importAttendances:attendances intoContext:context error:&error];
    
    //Beacons
    NSArray *beacons = [[WebClient sharedClient] GETAllBeaconsError:&error];
    [Beacon importBeacons:beacons intoContext:context error:&error];
    
    //Cources
    NSArray *cources = [[WebClient sharedClient] GETAllCourcesError:&error];
    [Course importCources:cources intoContext:context error:&error];
    
    //Lecturers
    //Pass in the username so we can tell what user is logged in without the need for any more infomation
    NSArray *lecturers = [[WebClient sharedClient] GETAllLecturersError:&error];
    [Lecturer importLecturers:lecturers intoContext:context withActiveUsername:username error:&error];
    
    //Lessons
    NSArray *lessons = [[WebClient sharedClient] GETAllLessonsError:&error];
    [Lesson importLessons:lessons intoContext:context error:&error];
    
    //Resources
    NSArray *resources = [[WebClient sharedClient] GETAllResourcesError:&error];
    [Resource importResources:resources intoContext:context error:&error];
    
    //Resoure types
    NSArray *resourceTypes = [[WebClient sharedClient] GETAllResourceTypesError:&error];
    [ResourceType importResourceTypes:resourceTypes intoContext:context error:&error];
    
    //Roles
    NSArray *roles = [[WebClient sharedClient] GETAllRolesError:&error];
    [Role importRoles:roles intoContext:context error:&error];
    
    //Rooms
    NSArray *rooms = [[WebClient sharedClient] GETAllRoomsError:&error];
    [Room importRooms:rooms intoContext:context error:&error];
    
    //Sessions
    NSArray *sessions = [[WebClient sharedClient] GETAllSessionsError:&error];
    [Session importSessions:sessions intoContext:context error:&error];
    
    //Students
    //Pass in the username so we can tell what user is logged in without the need for any more infomation
    NSArray *students = [[WebClient sharedClient] GETAllStudentsError:&error];
    [Student importStudents:students intoContext:context withActiveUsername:username error:&error];
    
    //Clean up. Delete all objects that have not been sent down from the web service.
    //This is to remove entities that might have been deleted on the web side but have previously been downloaded.
    [Attendance deleteAllInvalidAttendancesInContext:context];
    [Beacon deleteAllInvalidBeaconsInContext:context];
    [Course deleteAllInvalidCoursesInContext:context];
    [Lecturer deleteAllInvalidLecturersInContext:context];
    [Lesson deleteAllInvalidLessonsInContext:context];
    [Resource deleteAllInvalidResourcesInContext:context];
    [ResourceType deleteAllInvalidResourceTypesInContext:context];
    [Role deleteAllInvalidRolesInContext:context];
    [Room deleteAllInvalidRoomsInContext:context];
    [Session deleteAllInvalidSessionInContext:context];
    [Student deleteAllInvalidStudentsInContext:context];
    
    if(error)
    {
        NSLog(@"Error %s. %@", __PRETTY_FUNCTION__, error.localizedDescription);
    }
    else
    {
        //Save the changes to core data
        [context save:&error];
        
        if(error)
        {
            NSLog(@"Error %s. %@", __PRETTY_FUNCTION__, error.localizedDescription);
        }
    }
}

@end
