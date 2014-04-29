FZEasyFile
==========

A easy way to create or overwrite file in sandbox

#What is it?
It’s tedious, boring and unreadable using iOS’s sdk directly to manage file. FZEasyFile provides a easy way to create or overwrite file in sandbox. If you want to create a file, you just tell FZEasyFile your file name is ”my/file/path/info.txt”, you don’t need to care about what the root directory is and whether the directory “my/file/path/” exists. 

Actually, the root directory is “Documents” in sandbox, “my/file/path” will be create automatically if not exists.

#Usage
###Import the source files
Drag “FZEasyFile.h” and “FZEasyFile.m” to your project. And import .h file in your source file:
```objective-c
#import "FZEasyFile.h"
```

###Get the instance
FZEasyFile is written in singleton pattern. Anywhere you want to use it, just call the static method:
```objective-c
    FZEasyFile *easyFile = [FZEasyFile sharedInstance];
```
###Test whether the file exists
```objective-c
- (BOOL)isFileExists:(NSString *)fileName;
```

###Create a new file
```objective-c
- (void)createFile:(NSString *)fileName overwrite:(BOOL)shouldOverwrite;
```

###Translate short file name to full one
```objective-c
- (NSString *)fullFileName:(NSString *)shortFileName;
```
After getting the full name, you can pass it to other api to use, such as NSInputStream:
```objective-c
    NSInputStream *input = [NSInputStream inputStreamWithFileAtPath:[easyFile fullFileName:@“my/file/path/info.txt”]];
```

#Comparison
Here I paste two paragraphs of code. Respectively, one using traditional way, the other one using FZEasyFile.
creat a new file in traditional way:
```objective-c
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //获取document路径,括号中属性为当前应用程序独享
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    //查找文件夹，如果不存在，就创建一个文件夹
    NSString *dir = [documentDirectory stringByAppendingPathComponent:@SAVEDIR];
    NSLog(@"cache dir %@", dir);
    if(![fileManager fileExistsAtPath:dir])
    {
        if(![fileManager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil])
        {
            NSLog(@"create dir:(%@) error", dir);
            return;
        }
    }
    
    //定义记录文件全名以及路径的字符串filePath
    NSString *filePath = [dir stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"/%@", filename]];

    //查找文件，如果不存在，就创建一个文件
    NSData *data = [lHtml dataUsingEncoding:NSUTF8StringEncoding];
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createFileAtPath:filePath contents:data attributes:nil];
    }
```
creat a new file using FZEasyFile:
```objective-c
    NSString *path = [NSString stringWithFormat:@"%@/%@", uid, @pbcache_file_pbmsgs];
    FZEasyFile *easyFile = [FZEasyFile sharedInstance];
    [easyFile createFile:path overwrite:NO];
    
    NSOutputStream *output = [NSOutputStream outputStreamToFileAtPath:[easyFile fullFileName:path] append:NO];
```

##Contact
Email me:[zhoujun@jiecao.fm](mailto:zhoujun@jiecao.fm)

##License
MIT License. See the `LICENSE` file.
