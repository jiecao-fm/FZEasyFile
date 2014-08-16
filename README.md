FZEasyFile
==========

An easy way to create, write and remove file in sandbox.

#What is it?
It’s tedious, boring and unreadable to use iOS’s sdk to manage file directly. FZEasyFile provides an easy way to create or overwrite file in sandbox. If you want to create a file, you just tell FZEasyFile your file name, which is "my/file/path/info.txt". You don’t need to care about what the root directory is or whether the directory "my/file/path/" exists. 

Actually, the root directory is "Documents" in sandbox, "my/file/path" will be create automatically if not exists.

#Usage
###Import the source files
Drag "FZEasyFile.h" and "FZEasyFile.m" to your project. And import .h file in your source file:
```objective-c
#import "FZEasyFile.h"
```

###Test whether the file exists
```objective-c
[EasyFile isFileExists:@"my/file/path/info.txt"]
```

###Create a new file
```objective-c
[EasyFile createFile:"my/file/path/info.txt" overwrite:NO];
```

###Write file (overwrite/append)
```objective-c
[FZEasyFile writeFile:"my/file/path/info.txt" contents:[@"a" dataUsingEncoding:NSUTF8StringEncoding] append:NO];
[FZEasyFile writeFile:"my/file/path/info.txt" contents:[@"b" dataUsingEncoding:NSUTF8StringEncoding] append:YES];
```
After these calling the content of the file is "ab".

###Remove file or path
```objective-c
[FZEasyFile removeFile:"my/file/path/info.txt"];
[FZEasyFile removeFile:"my/file/path"];
```

###Translate short file name to full one
```objective-c
NSString *fullName = [EasyFile fullFileName:"my/file/path/info.txt"];
```
After getting the full name, you can pass it to other API, such as NSInputStream:
```objective-c
NSInputStream *input = [NSInputStream inputStreamWithFileAtPath:fullName];
```

#Comparison
Here I paste two paragraphs of code. Respectively, one using traditional way, the other using FZEasyFile.
Creat a new file in traditional way:
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
[EasyFile createFile:fileName overwrite:NO];
NSOutputStream *output = [NSOutputStream outputStreamToFileAtPath:[EasyFile fullFileName:fileName] append:NO];
```

##Contact
Email me : [zhoujun@jiecao.fm](mailto:zhoujun@jiecao.fm)

##License
MIT License. See the `LICENSE` file.
