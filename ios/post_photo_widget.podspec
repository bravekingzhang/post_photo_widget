#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint post_photo_widget.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'post_photo_widget'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin that can send photos similar to WeChat moments 发送微信朋友圈九宫格照片'
  s.description      = <<-DESC
A new Flutter plugin that can send photos similar to WeChat moments 发送微信朋友圈九宫格照片
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
