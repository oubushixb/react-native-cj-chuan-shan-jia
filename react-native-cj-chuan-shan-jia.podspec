require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-cj-chuan-shan-jia"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-cj-chuan-shan-jia
                   DESC
  s.homepage     = "https://github.com/oubushixb/react-native-cj-chuan-shan-jia"
  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }
  s.authors      = { "Your Name" => "yourname@email.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/oubushixb/react-native-cj-chuan-shan-jia.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,swift}"
  s.requires_arc = true

  s.dependency "React"
  s.dependency 'Bytedance-UnionAD', '~> 2.5.1.5'
  # ...
  # s.dependency "..."
end

