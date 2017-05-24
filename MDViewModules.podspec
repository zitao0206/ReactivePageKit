

Pod::Spec.new do |s|
  s.name         = "MDViewModules"
  s.version      = "0.0.1"
  s.summary      = "基于UIView的模块化组件"
  s.description  = <<-DESC
                   DESC

  s.homepage     = "https://github.com/lizitao000/MDViewModules.git"
  s.license      = "MIT (example)"
  s.author             = { "ztli" => "zitao.li@dianping.com" }
  s.source       = { :git => "http://EXAMPLE/MDViewModules.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.platform = :ios, "8.0"
  s.dependency "ReactiveCocoa"

end
