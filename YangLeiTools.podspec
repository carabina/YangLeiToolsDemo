Pod::Spec.new do |s|
    s.name         = 'YangLeiTools'
    s.version      = '1.0.2'
    s.summary      = 'An easy way to use pull-to-refresh'
    s.homepage     = 'https://github.com/yangLeiBoy/YangLeiToolsDemo'
    s.license      = 'MIT'
    s.authors      = {'yangLei' => '1024006431@qq.com'}
    s.platform     = :ios, '7.0'
    s.source       = {:git => 'https://github.com/yangLeiBoy/YangLeiToolsDemo.git', :tag => s.version}
    s.source_files = 'YangLeiToolsDemo/YangLeiTools/*.{h,m}'
    s.requires_arc = true
    s.dependency 'AFNetworking', '~> 3.1.0'  #需要用的第三方
    s.dependency 'SVProgressHUD', '~> 2.0.3'  #需要用的第三方

    # s.framework  = "SomeFramework" #可以指定你需要的framework 由于我这里是一个简单的demo，所以这里没有指定
    # s.frameworks = "SomeFramework", "AnotherFramework"
end
