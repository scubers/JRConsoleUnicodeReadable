Pod::Spec.new do |s|

    s.name                  = "JRConsoleUnicodeReadable"
    s.version="1.0.7"
    s.summary               = "make xcode 8 console log unicode to readable format"

    s.homepage              = "https://github.com/scubers"
    s.license               = { :type => "MIT", :file => "LICENSE" }

    s.author                = { "jrwong" => "jr-wong@qq.com" }
    s.ios.deployment_target = "8.0"
    s.source                = { :git => "https://github.com/scubers/JRConsoleUnicodeReadable.git", :tag => "#{s.version}" }


    s.source_files          = "JRConsoleUnicodeReadable/classes/**/*.{h,m}"
    s.public_header_files   = "JRConsoleUnicodeReadable/classes/**/*.h"

end
