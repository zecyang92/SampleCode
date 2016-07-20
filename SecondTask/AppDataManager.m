//
//  AppDataManager.m
//  SampleCode
//
//  Created by Zebin Yang on 7/20/16.
//  Copyright © 2016 Lucky . All rights reserved.
//
#define GET_Service_Provider @"http://94.56.199.34/EMC/IPDP/ipdpb.ashx?TemplateName=Promotions_ipad.htm&p=Common.Announcements&Handler=News&AppName=EMC&Type=News&F=J"

#import "AppDataManager.h"
static AppDataManager *apiHandler;
@implementation AppDataManager
+(AppDataManager*)sharedApiHandler{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (!apiHandler) {
            apiHandler = [[AppDataManager alloc] init];
            
        }
    });
    
    return apiHandler;
}

- (void)loadData:(GetAnnouncementListApiCallBlock)getAnnouncementListApiCallBlock{
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:[self getURLRequestForServiceList] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            getAnnouncementListApiCallBlock(nil,error);
        }else{
            
            NSError *jsonError = nil;
            id responsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            getAnnouncementListApiCallBlock(responsedData,error);
        }
        
    }] resume];
    
    
}
#pragma mark - NSURLRequest
- (NSURLRequest*)getURLRequestForServiceList{
    
    NSURL *url = [NSURL URLWithString:GET_Service_Provider];
    
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:180];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    return request;
}
@end
