#
# Be sure to run `pod lib lint FFPersistanceService.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FFPersistanceService'
  s.version          = '0.1.2'
  s.summary          = 'Lightweight object saving'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A framework that makes it super easy to save objects in `UserDefaults` and `Keychain`
or in any conforming persistance service.
                       DESC

  s.homepage         = 'https://github.com/fr3qfly/FFPersistanceService'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'BalazsSzamody' => 'fr3qfly@gmail.com' }
  s.source           = { :git => 'https://github.com/fr3qfly/FFPersistanceService.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.3'
  s.swift_version = '4.2'
  s.source_files = 'Sources/**/*'
  
  # s.resource_bundles = {
  #   'FFPersistanceService' => ['FFPersistanceService/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
