#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Codedeck'
  s.version          = '0.0.1'
  s.summary          = 'A Swift library for interfacing with the Elgato Stream Deck'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                       A Swift library for interfacing with and creating custom
                       functionality with the Elgato Stream Deck!
                       DESC

  s.homepage         = 'https://github.com/Sherlouk/Codedeck'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'James Sherlock'
  s.source           = { :git => 'https://github.com/Sherlouk/Codedeck.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/JamesSherlouk'

  s.platform = :osx
  s.osx.deployment_target = "10.10"

  s.subspec 'HIDSwift' do |hid|
    hid.source_files = 'Sources/HIDSwift/**/*'
  end

  s.subspec 'Core' do |deck|
    deck.dependency 'Codedeck/HIDSwift'
    deck.source_files = 'Sources/Codedeck/**/*'
  end

  s.default_subspec = 'Core'

  # s.resource_bundles = {
  #   '${POD_NAME}' => ['${POD_NAME}/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'Cocoa'
  # s.dependency 'AFNetworking', '~> 2.3'
end
