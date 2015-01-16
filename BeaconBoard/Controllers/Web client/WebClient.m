//
//  WebCliten.m
//  BeaconBoard
//
//  Created by Ste Prescott on 15/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "WebClient.h"

NSString *const APIBaseURL = @"http://api.beaconboard.co.uk/api";
NSString *const APIKey = @"API_KEY";

NSString *const beaconEndPoint       = @"beacon";
NSString *const courseEndPoint       = @"course";
NSString *const lessonEndPoint       = @"lesson";
NSString *const resourceEndPoint     = @"resource";
NSString *const resourceTypeEndPoint = @"resourceType";
NSString *const roomEndPoint         = @"room";
NSString *const sessionEndPoint      = @"session";

NSString *const WebClientErrorDomain = @"me.ste.WebClientErrorDomain";
NSString *const HTTPErrorDomain      = @"me.ste.HTTPErrorDomain";
NSString *const WebClientErrorReason = @"WebClientErrorReason";

WebClient static *sharedClient;

@interface WebClient()

@property (nonatomic, strong) NSString *userToken;

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

#pragma -mark GET All

- (NSArray *)GETAllBeaconsError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:beaconEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSArray *)GETAllCourcesError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:courseEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSArray *)GETAllLessonsError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:lessonEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSArray *)GETAllResourcesError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:resourceEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSArray *)GETAllResourceTypesError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:resourceTypeEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSArray *)GETAllRoomsError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:roomEndPoint
                                 withParameters:nil];
    return [self sendSynchronousRequest:request error:error];
}

- (NSArray *)GETAllSessionsError:(NSError **)error
{
    NSURLRequest *request = [self requestOfType:RequestTypeGET
                                    forEndPoint:sessionEndPoint
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
            NSString *reason = JSON[@"Reason"];
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:responseError.userInfo];
            if (reason)
            {
                userInfo[WebClientErrorReason] = reason;
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
