Pod::Spec.new do |s|
  s.name         = "Swime"
  s.version      = "3.0.3"
  s.summary      = "Swift MIME type checking based on magic bytes"
  s.description  = <<-DESC
    Swift check MIME type based on magic bytes. It does so by reading the given `Data` instance.
    Usage instructions are on https://github.com/sendyhalim/Swime
  DESC
  s.homepage     = "https://github.com/sendyhalim/Swime"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Sendy Halim" => "sendyhalim93@gmail.com" }
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
  s.social_media_url   = "https://github.com/sendyhalim"
  s.source       = { :git => "https://github.com/sendyhalim/Swime.git", :tag => s.version }
  s.source_files  = "Sources/**/*.{swift}"
end
