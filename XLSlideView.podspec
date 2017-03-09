Pod::Spec.new do |s|
  s.name         = "XLSlideView"
  s.version      = "1.0"
  s.summary      = "XLSlideView is a multi-UIViewController management container."
  s.description  = "XLSlideView offers two different styles, including XLCornerSlideView and XLLineSlideView."
  s.homepage     = "https://github.com/cctomato/XLSlideView"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "cctomato" => "cyq_1103@live.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/cctomato/XLSlideView", :tag => "#{s.version}" }

  s.source_files  = "XLSlideView/*.{h,m}"

  s.requires_arc = true

end
