//
//  PKSettingsDownloader.h
//  settings
//
//  Created by Atul M on 14/08/16.
//  Copyright © 2016 CARLOS CABANERO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKSettingsFileDownloader : NSObject
+ (void)downloadFileAtUrl:(NSString*)urlString withCompletionHandler:(void(^)(NSString *filePath, NSError *error))completionHandler;

@end
