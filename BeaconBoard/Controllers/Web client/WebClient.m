//
//  WebCliten.m
//  BeaconBoard
//
//  Created by Ste Prescott on 15/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "WebClient.h"

NSString *const APIBaseURL = @"http://api.beaconboard.co.uk";
NSString *const APIKey = @"DC3A8672-1976-4993-9DD3-C42875FF7684";

NSString *const activeUserEndPoint      = @"users/activeUser";
NSString *const attendancesEndPoint     = @"attendances";
NSString *const beaconsEndPoint         = @"beacons";
NSString *const coursesEndPoint         = @"courses";
NSString *const currentSessionEndPoint  = @"sessions/current";
NSString *const lecturersEndPoint       = @"lecturers";
NSString *const lessonsEndPoint         = @"lessons";
NSString *const modulesEndPoint         = @"modules";
NSString *const resourcesEndPoint       = @"resources";
NSString *const resourceTypesEndPoint   = @"resourceTypes";
NSString *const rolesEndPoint           = @"roles";
NSString *const roomsEndPoint           = @"rooms";
NSString *const sessionsEndPoint        = @"sessions";
NSString *const studentsEndPoint        = @"students";
NSString *const tokensEndPoint          = @"tokens";
NSString *const usersEndPoint           = @"users";

WebClient static *sharedClient;

@interface WebClient()

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation WebClient

+ (WebClient *)sharedClient
{
    static WebClient *sharedInstance = nil;
    static dispatch_once_t pred;
    
    if (sharedInstance)
    {
       return sharedInstance;
    }
    dispatch_once(&pred, ^{
        sharedInstance = [[WebClient alloc] init];
    });
    
    return sharedInstance;
}

#pragma -mark Async login

- (void)asyncLoginUsername:(NSString *)username password:(NSString *)password success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    self.operationQueue = [[NSOperationQueue alloc] init];
    
    [self.operationQueue addOperationWithBlock:^{
        NSURLRequest *request = [self requestOfType:RequestTypePOST
                                        forEndPoint:tokensEndPoint
                                     withParameters:@{@"Username" : username,
                                                      @"Password" : password}];
        
        NSError *error = nil;
        NSDictionary *responseObject = [self sendSynchronousRequest:request error:&error];
        self.userToken = responseObject[@"UserToken"];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
            if (error) {
                if (failure) {
                    failure(error);
                }
            }
            else if (success) {
                success(responseObject);
            }
        }];
    }];
}

#pragma -mark GET all

- (NSArray *)GETAllAttendancesError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:attendancesEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSArray *)GETAllBeaconsError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:beaconsEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSArray *)GETAllCourcesError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:coursesEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSArray *)GETAllLecturersError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:lecturersEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSArray *)GETAllLessonsError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:lessonsEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSArray *)GETAllModulesError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:modulesEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSArray *)GETAllResourcesError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:resourcesEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSArray *)GETAllResourceTypesError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:resourceTypesEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSArray *)GETAllRolesError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:rolesEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSArray *)GETAllRoomsError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:roomsEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSArray *)GETAllSessionsError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:sessionsEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSArray *)GETAllStudentsError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:studentsEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSDictionary *)GETAllUsersError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:usersEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSDictionary *)GETUserForRequestError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:activeUserEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

#pragma -mark GET with ID

- (NSDictionary *)GETLecturerWithID:(NSString *)lecturerID error:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:[NSString stringWithFormat:@"%@/%@", lecturersEndPoint, lecturerID]
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSDictionary *)GETStudentWithID:(NSString *)studentID error:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:[NSString stringWithFormat:@"%@/%@", studentsEndPoint, studentID]
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSDictionary *)GETCurrentSessionForRoomWithID:(NSString *)roomID error:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:[NSString stringWithFormat:@"%@?roomID=%@", currentSessionEndPoint, roomID]
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

#pragma -mark Build request

- (NSMutableURLRequest *)requestOfType:(RequestType)requestType forEndPoint:(NSString *)endPoint withParameters:(NSDictionary *)parameters
{
    NSString *webMethod = @"";
    
    switch(requestType)
    {
        case RequestTypeGET:
        {
            webMethod = @"GET";
            break;
        }
        case RequestTypePOST:
        {
            webMethod = @"POST";
            break;
        }
        case RequestTypeDELETE:
        {
            webMethod = @"DELETE";
            break;
        }
    }
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", APIBaseURL, endPoint]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];

    [request setHTTPMethod:webMethod];
    [request setValue:APIKey forHTTPHeaderField:@"ApiKey"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if(self.userToken)
    {
        [request setValue:self.userToken forHTTPHeaderField:@"UserToken"];
    }
    
    if(parameters)
    {
        NSData *body = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:NULL];
        [request setHTTPBody:body];
    }
    
    return request;
}

#pragma -mark Sending request

- (id)sendSynchronousRequest:(NSURLRequest *)request error:(NSError **)error
{
    NSHTTPURLResponse *response = nil;
    NSError *responseError;
    NSData *reponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&responseError];
    
    id JSON = reponseData != nil ? [NSJSONSerialization JSONObjectWithData:reponseData options:0 error:NULL] : nil;
    
    if(error != NULL)
    {
        if((response != nil && [response statusCode] != 200))
        {
            NSString *message = JSON[@"Message"];
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:responseError.userInfo];
            if (message)
            {
                userInfo[WebClientErrorMessage] = message;
            }
            *error = [NSError errorWithDomain:WebClientErrorDomain
                                         code:[response statusCode]
                                     userInfo:userInfo];
        }
        else
        {
            *error = responseError;
        }
    }
    
    return JSON;
}

@end
