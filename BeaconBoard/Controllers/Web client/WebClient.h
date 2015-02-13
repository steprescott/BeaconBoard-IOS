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

static NSString *WebClientErrorDomain  = @"me.ste.WebClientErrorDomain";
static NSString *HTTPErrorDomain       = @"me.ste.HTTPErrorDomain";
static NSString *WebClientErrorMessage  = @"WebClientErrorReason";

@interface WebClient : NSObject

@property (nonatomic, strong) NSString *userToken;

+ (WebClient *)sharedClient;

- (void)asyncLoginUsername:(NSString *)username password:(NSString *)password success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

//GET all
- (NSArray *)GETAllAttendancesError:(NSError **)error;
- (NSArray *)GETAllBeaconsError:(NSError **)error;
- (NSArray *)GETAllCourcesError:(NSError **)error;
- (NSArray *)GETAllLecturersError:(NSError **)error;
- (NSArray *)GETAllLessonsError:(NSError **)error;
- (NSArray *)GETAllModulesError:(NSError **)error;
- (NSArray *)GETAllResourcesError:(NSError **)error;
- (NSArray *)GETAllResourceTypesError:(NSError **)error;
- (NSArray *)GETAllRolesError:(NSError **)error;
- (NSArray *)GETAllRoomsError:(NSError **)error;
- (NSArray *)GETAllSessionsError:(NSError **)error;
- (NSArray *)GETAllStudentsError:(NSError **)error;
- (NSDictionary *)GETAllUsersError:(NSError **)error;
- (NSDictionary *)GETUserForRequestError:(NSError **)error;

//GET with ID
- (NSDictionary *)GETLecturerWithID:(NSString *)lecturerID error:(NSError **)error;
- (NSDictionary *)GETStudentWithID:(NSString *)studentID error:(NSError **)error;
- (NSDictionary *)GETCurrentSessionForRoomWithID:(NSString *)roomID error:(NSError **)error;

@end
