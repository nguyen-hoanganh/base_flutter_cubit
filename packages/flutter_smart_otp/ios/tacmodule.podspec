#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint tacmodule.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'tacmodule'
  s.version          = '1.0.2'
  s.summary          = 'THD Tech TAC Smart OTP Samples.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'https://thdtech.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'THD Tech' => 'hieulv@thdtech.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
