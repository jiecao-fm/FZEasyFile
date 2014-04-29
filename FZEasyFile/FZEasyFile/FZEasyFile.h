//
//  FZEasyFile.h
//  FZEasyFile
//
//  Created by zhou jun on 14-4-29.
//  Copyright (c) 2014年 shannonchou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZEasyFile : NSObject

/**
 singleton pattern.
 @return the shared instance.
 */
+ (FZEasyFile *)sharedInstance;

/**
 convert the short file name to full file name. e.g. "mycache/user/icon.png" -> "/Users/zhoujun/Library/Application Support/iPhone Simulator/7.1/Applications/ABCE2119-E864-4492-A3A9-A238ADA74BE5/Documents/mycache/user/icon.png".
 @return full file name.
 */
- (NSString *)fullFileName:(NSString *)shortFileName;

/**
 test if the file exists.
 @param fileName file path and file name, e.g. "mycache/user/icon.png".
 @return YES if exists, NO otherwise.
 */
- (BOOL)isFileExists:(NSString *)fileName;

/**
 create a file
 @param fileName fileName file path and file name, e.g. "mycache/user/icon.png".
 @param shouldOverwrite YES:if the file exists then overwirte it, NO:if the file exists then do nothing
 */
- (void)createFile:(NSString *)fileName overwrite:(BOOL)shouldOverwrite;

@end
