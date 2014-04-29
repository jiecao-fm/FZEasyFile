FZEasyFile
==========

A easy way to create or overwrite file in sandbox

#What is it?
It’s tedious, boring and unreadable using iOS’s sdk directly to manage file. FZEasyFile provides a easy way to create or overwrite file in sandbox. If you want to create a file, you just tell FZEasyFile your file name is ”my/file/path/info.txt”, you don’t need to care about what the root directory is and whether the directory “my/file/path/” exists. Actually, the root directory is “Documents” in sandbox, “my/file/path” will be create automatically if not exists.

#Usage

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

