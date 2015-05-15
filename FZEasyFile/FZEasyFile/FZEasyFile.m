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
    BOOL dir;
    return [fileManager fileExistsAtPath:file isDirectory:&dir];
}

+ (BOOL)isFileUrlExists:(NSURL *)fileUrl {
    if (!fileUrl || [self isBlankString:fileUrl.path]) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:fileUrl.path];
}

+ (BOOL)isFolderExists:(NSString *)shortName {
    NSString *fullName = [self fullFileName:shortName];
    NSURL *fileUrl = [NSURL fileURLWithPath:fullName];
    return [self isFolderUrlExists:fileUrl];
}

+ (BOOL)isFolderUrlExists:(NSURL *)folderUrl {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dir;
    [fileManager fileExistsAtPath:folderUrl.path isDirectory:&dir];
    return dir;
}


+ (void)createFile:(NSString *)fileName overwrite:(BOOL)shouldOverwrite {
    NSString *fullName = [self fullFileName:fileName];
    NSURL *fileUrl = [NSURL fileURLWithPath:fullName];
    [self createFileWithFileUrl:fileUrl overwrite:shouldOverwrite];
}

+ (void)createFolder:(NSString *)shortName {
    NSString *fullName = [self fullFileName:shortName];
    NSURL *fileUrl = [NSURL fileURLWithPath:fullName];
    [self createFolderWithFileUrl:fileUrl];
}

+ (void)createFileWithFileUrl:(NSURL *)fileUrl overwrite:(BOOL)shouldOverwrite {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //create file directory, include multilayer directory
    NSString *fullDir = fileUrl.URLByDeletingLastPathComponent.path;
    if (![fileManager fileExistsAtPath:fullDir]) {
        [fileManager createDirectoryAtPath:fullDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //file not exists or want to overwrite it
    if (shouldOverwrite || ![fileManager fileExistsAtPath:fileUrl.path]) {
        BOOL suc = [fileManager createFileAtPath:fileUrl.path contents:nil attributes:nil];
        NSLog(@"create file(%@) %@", fileUrl.path, suc ? @"successfully" : @"failed");
    }
}

+ (void)createFolderWithFileUrl:(NSURL *)fileUrl {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //create file directory, include multilayer directory
    [fileManager createDirectoryAtPath:fileUrl.path withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (void)removeFile:(NSString *)fileName {
    if ([self isBlankString:fileName]) {
        NSLog(@"You really want to remove the home directory? I guess you not!");
        return;
    }
    NSString *file = [self fullFileName:fileName];
    NSURL *url = [NSURL fileURLWithPath:file];
    [self removeFileWithFileUrl:url];
}

+ (void)removeFileWithFileUrl:(NSURL *)fileUlr {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:fileUlr.path error:nil];
}

+ (void)writeFile:(NSString *)fileName contents:(NSData *)contents append:(BOOL)shouldAppend {
    NSString *fullName = [FZEasyFile fullFileName:fileName];
    NSURL *fileUrl = [NSURL fileURLWithPath:fullName];
    [self writeFileWithFileUrl:fileUrl contents:contents append:shouldAppend];
}

+ (void)writeFileWithFileUrl:(NSURL *)fileUrl contents:(NSData *)contents append:(BOOL)shouldAppend {
    if (![self isFileUrlExists:fileUrl] || !shouldAppend) {
        [self createFileWithFileUrl:fileUrl overwrite:YES];
    }
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:fileUrl.path];
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:contents];
    [fileHandle closeFile];
}


+ (BOOL) isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    return NO;
    
}

@end