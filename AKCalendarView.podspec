Pod::Spec.new do |s|
  s.name         = "AKCalendarView"
  s.version      = "0.0.1"
  s.summary      = "カレンダーライブラリ"

  s.description  = <<-DESC
                   A longer description of AKCalendarView in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/akuraru/AKCalendarView"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "akuraru" => "akuraru@gmail.com" }
  s.social_media_url = "http://twitter.com/akuraru"
  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/akuraru/AKCalendarView.git", :commit => "a076f70133ba7290c9819f732cad773f43b18851" }
  s.source_files  = 'lib/**/*.{h,m}'
  s.dependency 'NSDate-Escort'
end
