//
//
//  BeaconBoard
//
//  Created by Ste Prescott on 15/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RequestType) {
    RequestTypeGET,
    RequestTypePOST,
    RequestTypeDELETE,
};

@interface WebClient : NSObject

+ (WebClient *)sharedClient;

- (NSArray *)GETAllBeaconsError:(NSError **)error;
- (NSArray *)GETAllCourcesError:(NSError **)error;
- (NSArray *)GETAllLessonsError:(NSError **)error;
- (NSArray *)GETAllResourcesError:(NSError **)error;
- (NSArray *)GETAllResourceTypesError:(NSError **)error;
- (NSArray *)GETAllRoomsError:(NSError **)error;
- (NSArray *)GETAllSessionsError:(NSError **)error;

@end
