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

+ (FZEasyFile *)sharedInstance {
    if (!instance) {
        @synchronized (FZEasyFile.class){
            if (!instance) {
                instance = [[FZEasyFile alloc] init];
            }
        }
    }
    return instance;
}

- (NSString *)fullFileName:(NSString *)shortFileName {
    //search the "document" path
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    NSString *file = [documentDirectory stringByAppendingPathComponent:shortFileName];
    return file;
}

- (BOOL)isFileExists:(NSString *)fileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *file = [self fullFileName:fileName];
    return [fileManager fileExistsAtPath:file];
}

- (void)createFile:(NSString *)fileName overwrite:(BOOL)shouldOverwrite {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //create file directory, include multilayer directory
    NSRange lastTag = [fileName rangeOfString:@"/" options:NSBackwardsSearch];
    if (lastTag.location != NSNotFound && lastTag.location != 0) {
        NSString *shortDir = [fileName substringToIndex:lastTag.location];
        NSString *fullDir = [self fullFileName:shortDir];
        NSLog(@"full directory: %@", fullDir);
        if (![fileManager fileExistsAtPath:fullDir]) {
            [fileManager createDirectoryAtPath:fullDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    
    NSString *file = [self fullFileName:fileName];
    NSLog(@"full file name:%@", file);
    
    //file not exists or want to overwrite it
    if (shouldOverwrite || ![fileManager fileExistsAtPath:file]) {
        BOOL suc = [fileManager createFileAtPath:file contents:nil attributes:nil];
        NSLog(@"create file(%@) %@", file, suc ? @"successfully" : @"failed");
    }
}

@end