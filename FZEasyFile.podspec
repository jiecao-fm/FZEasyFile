Pod::Spec.new do |s|

  s.name         = "FZEasyFile"
  s.version      = "0.0.1"
  s.summary      = "An easy way to create, overwrite and remove file in sandbox."

  s.description  = <<-DESC
#What is it?
An easy way to create, overwrite and remove file in sandbox.
It’s tedious, boring and unreadable to use iOS’s sdk to manage file directly. FZEasyFile provides an easy way to create or overwrite file in sandbox. If you want to create a file, you just tell FZEasyFile your file name, which is "my/file/path/info.txt". You don’t need to care about what the root directory is or whether the directory "my/file/path/" exists. 
                   DESC

  s.homepage     = "https://github.com/jiecao-fm/FZEasyFile"
  s.license      = "MIT"
  s.author             = { "Shannon" => "zhoujun@jiecao.fm" }
  s.source       = { :git => "https://github.com/jiecao-fm/FZEasyFile", :tag => "v0.0.1" }
  s.source_files  = "Classes", "FZEasyFile/**/*.{h,m}"
  s.exclude_files = "FZEasyFileTests/"
  s.requires_arc = true
end
