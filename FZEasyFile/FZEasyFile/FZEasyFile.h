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
 convert the short file name to full file name. e.g. "mycache/user/icon.png" -> "/Users/zhoujun/Library/Application Support/iPhone Simulator/7.1/Applications/ABCE2119-E864-4492-A3A9-A238ADA74BE5/Documents/mycache/user/icon.png".
 @return full file name.
 */
+ (NSString *)fullFileName:(NSString *)shortFileName;

/**
 Test if the file exists.
 @param fileName file path and file name, e.g. "mycache/user/icon.png".
 @return YES if exists, NO otherwise.
 */
+ (BOOL)isFileExists:(NSString *)fileName;

/**
 Create a file. Don't care about if the file exists. This will automatically overwrite it.
 @param fileName fileName file path and file name, e.g. "mycache/user/icon.png".
 @param shouldOverwrite YES:if the file exists then overwirte it, NO:if the file exists then do nothing
 */
+ (void)createFile:(NSString *)fileName overwrite:(BOOL)shouldOverwrite;

/**
 Write contents to file. Don't care about if the file exists. This will automatically create it.
 @param fileName fileName file path and file name, e.g. "mycache/user/icon.png".
 @param contents the contents you wish to write
 @param shouldAppend YES:append contents to original file; NO:overwrite the original file
 */
+ (void)writeFile:(NSString *)fileName contents:(NSData *)contents append:(BOOL)shouldAppend;

/**
 remove a file
 @param fileName file path and file name, e.g. "mycache/user/icon.png".
 */
+ (void)removeFile:(NSString *)fileName;

@end
