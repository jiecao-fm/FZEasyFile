//
//  FZEasyFile.m
//  FZEasyFile
//
//  Created by zhou jun on 14-4-29.
//  Copyright (c) 2014年 shannonchou. All rights reserved.
//

#import "FZEasyFile.h"

@implementation FZEasyFile

static FZEasyFile *instance;

+ (NSString *)fullFileName:(NSString *)shortFileName {
    NSString *documentDirectory = NSHomeDirectory();
    NSString *file = [documentDirectory stringByAppendingPathComponent:shortFileName];
    return file;
}

+ (BOOL)isFileExists:(NSString *)fileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *file = [self fullFileName:fileName];
    return [fileManager fileExistsAtPath:file];
}

+ (void)createFile:(NSString *)fileName overwrite:(BOOL)shouldOverwrite {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //create file directory, include multilayer directory
    NSRange lastTag = [fileName rangeOfString:@"/" options:NSBackwardsSearch];
    if (lastTag.location != NSNotFound && lastTag.location != 0) {
        NSString *shortDir = [fileName substringToIndex:lastTag.location];
        NSString *fullDir = [self fullFileName:shortDir];
        if (![fileManager fileExistsAtPath:fullDir]) {
            [fileManager createDirectoryAtPath:fullDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    
    NSString *file = [self fullFileName:fileName];
    
    //file not exists or want to overwrite it
    if (shouldOverwrite || ![fileManager fileExistsAtPath:file]) {
        BOOL suc = [fileManager createFileAtPath:file contents:nil attributes:nil];
        NSLog(@"create file(%@) %@", file, suc ? @"successfully" : @"failed");
    }
}

+ (void)removeFile:(NSString *)fileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *file = [self fullFileName:fileName];
    [fileManager removeItemAtPath:file error:nil];
}

+ (void)writeFile:(NSString *)fileName contents:(NSData *)contents append:(BOOL)shouldAppend {
    if (![self isFileExists:fileName] || !shouldAppend) {
        [self createFile:fileName overwrite:YES];
    }
    NSString *fullName = [FZEasyFile fullFileName:fileName];
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:fullName];
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:contents];
    [fileHandle closeFile];
}

@end