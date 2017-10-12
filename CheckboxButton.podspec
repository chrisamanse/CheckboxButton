Pod::Spec.new do |s|

  s.name         = "CheckboxButton"
  s.version      = "3.1.1"
  s.summary      = "A checkbox button UI component for iOS built with Swift"
  s.description  = "A checkbox button UI component for iOS built with Swift. `CheckboxButton` is simply a subclass of `UIControl`."

  s.homepage     = "https://github.com/chrisamanse/CheckboxButton"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Chris Amanse" => "christopheramanse@gmail.com" }
  s.social_media_url   = "http://twitter.com/ChrisAmanse"

  s.platform = :ios, "8.0"
  s.source       = { :git => "https://github.com/chrisamanse/CheckboxButton.git", :tag => "#{s.version}" }
  s.source_files  = "CheckboxButton", "CheckboxButton/**/*.{h,swift}"
  s.requires_arc = true

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
end
