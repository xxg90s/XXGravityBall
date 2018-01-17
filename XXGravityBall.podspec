#
#  Be sure to run `pod spec lint XXGravityBall.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "XXGravityBall"
  s.version      = "1.0.0"
  s.license      = "MIT"
  s.summary      = "通过UIDynamic与CoreMotion实现mobike我的贴纸动画效果"
  s.homepage     = "https://github.com/xxg90s/XXGravityBall"
  s.source       = { :git => "https://github.com/xxg90s/XXGravityBall.git", :tag => "#{s.version}" }
  s.source_files = "XXGravityBall/XXGravityBall/XXGravityBall/*.{h,m}"
  s.requires_arc = true
  s.platform     = :ios, "7.0"
  s.frameworks   = "UIKit", "Foundation", "CoreMotion"
  s.author             = { "xxg90s" => "xxg90s@163.com" }
  s.social_media_url   = "https://github.com/xxg90s"

end
