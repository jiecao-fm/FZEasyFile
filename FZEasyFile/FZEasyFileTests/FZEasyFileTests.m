//
//  FZEasyFileTests.m
//  FZEasyFileTests
//
//  Created by zhou jun on 14-4-29.
//  Copyright (c) 2014年 shannonchou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FZEasyFile.h"

@interface FZEasyFileTests : XCTestCase

@end

static NSString *file = @"Documents/a/b.txt";
static NSString *folder = @"Documents/aFolder";

@implementation FZEasyFileTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    //////////using short file name
    NSString *fullName = [FZEasyFile fullFileName:file];
    NSLog(@"fullName of %@ is:%@", file, fullName);
    NSAssert(fullName && fullName.length > file.length, @"convert full file name failed!");
    
    [FZEasyFile createFile:file overwrite:YES];
    NSAssert([FZEasyFile isFileExists:file], @"create file failed!");

    [FZEasyFile writeFile:file contents:[@"a" dataUsingEncoding:NSUTF8StringEncoding] append:NO];
    
    NSString *contents = [NSString stringWithContentsOfFile:fullName encoding:NSUTF8StringEncoding error:nil];
    NSAssert([@"a" isEqualToString:contents], @"write file failed");
    
    [FZEasyFile writeFile:file contents:[@"b" dataUsingEncoding:NSUTF8StringEncoding] append:YES];
    contents = [NSString stringWithContentsOfFile:fullName encoding:NSUTF8StringEncoding error:nil];
    NSAssert([@"ab" isEqualToString:contents], @"append file failed");

    [FZEasyFile removeFile:file];
    NSAssert(![FZEasyFile isFileExists:file], @"remove file failed!");
    
    [FZEasyFile removeFile:@""];
    NSAssert([FZEasyFile isFileExists:@""], @"Home directory is removed, It's dangerous!");
    
    [FZEasyFile createFolder:folder];
    NSAssert([FZEasyFile isFolderExists:folder], @"create folder failed!");
    [FZEasyFile removeFile:folder];
    NSAssert(![FZEasyFile isFolderExists:folder], @"remove folder failed!");
    
    
    
    ////////////using file url
    NSURL *fileUrl = [NSURL fileURLWithPath:fullName];
    
    [FZEasyFile createFileWithFileUrl:fileUrl overwrite:YES];
    NSAssert([FZEasyFile isFileExists:file], @"create file failed!");
    
    [FZEasyFile writeFileWithFileUrl:fileUrl contents:[@"a" dataUsingEncoding:NSUTF8StringEncoding] append:NO];
    
    contents = [NSString stringWithContentsOfFile:fullName encoding:NSUTF8StringEncoding error:nil];
    NSAssert([@"a" isEqualToString:contents], @"write file failed");

    [FZEasyFile writeFileWithFileUrl:fileUrl contents:[@"b" dataUsingEncoding:NSUTF8StringEncoding] append:YES];
    contents = [NSString stringWithContentsOfFile:fullName encoding:NSUTF8StringEncoding error:nil];
    NSAssert([@"ab" isEqualToString:contents], @"append file failed");
    
    [FZEasyFile removeFileWithFileUrl:fileUrl];
    NSAssert(![FZEasyFile isFileUrlExists:fileUrl], @"remove file failed!");
    
    NSURL *folderUrl = [NSURL fileURLWithPath:folder isDirectory:YES];
    [FZEasyFile createFolderWithFileUrl:folderUrl];
    NSAssert([FZEasyFile isFolderUrlExists:folderUrl], @"create folder failed!");
    [FZEasyFile removeFileWithFileUrl:folderUrl];
    NSAssert(![FZEasyFile isFolderUrlExists:folderUrl], @"remove folder failed!");
}

@end
