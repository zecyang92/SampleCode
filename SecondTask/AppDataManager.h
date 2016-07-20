//
//  AppDataManager.h
//  SampleCode
//
//  Created by Zebin Yang on 7/20/16.
//  Copyright © 2016 Lucky . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppDataManager : NSObject
+(AppDataManager*)sharedApiHandler;

typedef void(^GetAnnouncementListApiCallBlock)(id data,NSError *error);
- (void)loadData:(GetAnnouncementListApiCallBlock)getAnnouncementListApiCallBlock;

@end
