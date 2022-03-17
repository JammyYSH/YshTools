#
# Be sure to run `pod lib lint YshTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YshTools'
  s.version          = '0.1.0'
  s.summary          = '测试用的YshTools,'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  淡淡烟雨淡淡愁,淡淡明月上西楼,淡淡胭脂淡淡酒,淡淡酒解淡淡愁
                       DESC

  s.homepage         = 'https://github.com/JammyYSH/YshTools'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '994701002@qq.com' => '994701002@qq.com' }
  s.source           = { :git => 'https://github.com/JammyYSH/YshTools.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'YshTools/Classes/**/*'
  
#   s.resource_bundles = {
#     'YshTools' => ['YshTools/Assets/*.png']
#   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
