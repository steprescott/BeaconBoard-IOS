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
    NSError *error;
    NSManagedObjectContext *context = [ContextManager newPrivateContext];
    
    //Beacons
    NSArray *beacons = [[WebClient sharedClient] GETAllBeaconsError:&error];
    [Beacon importBeacons:beacons intoContext:context error:&error];
    
    //Cources
    NSArray *cources = [[WebClient sharedClient] GETAllCourcesError:&error];
    [Course importCources:cources intoContext:context error:&error];
    
    //Lessons
    NSArray *lessons = [[WebClient sharedClient] GETAllLessonsError:&error];
    [Lesson importLessons:lessons intoContext:context error:&error];
    
    //Resources
    NSArray *resources = [[WebClient sharedClient] GETAllResourcesError:&error];
    [Resource importResources:resources intoContext:context error:&error];
    
    //Resoure types
    NSArray *resourceTypes = [[WebClient sharedClient] GETAllResourceTypesError:&error];
    [ResourceType importResourceTypes:resourceTypes intoContext:context error:&error];
    
    //Rooms
    NSArray *rooms = [[WebClient sharedClient] GETAllRoomsError:&error];
    [Room importRooms:rooms intoContext:context error:&error];
    
    //Sessions
    NSArray *sessions = [[WebClient sharedClient] GETAllSessionsError:&error];
    [Session importSessions:sessions intoContext:context error:&error];
    
    if(error)
    {
        NSLog(@"Error %s. %@", __PRETTY_FUNCTION__, error.localizedDescription);
    }
    else
    {
        [context save:&error];
        
        if(error)
        {
            NSLog(@"Error %s. %@", __PRETTY_FUNCTION__, error.localizedDescription);
        }
    }
}

@end
