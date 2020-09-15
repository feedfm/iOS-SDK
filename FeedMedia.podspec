
Pod::Spec.new do |s|
  s.name             = "FeedMedia"
  s.version          = "4.4.5"
  s.summary          = "FeedMedia SDK for Internet radio streaming"
  s.description      = <<-DESC
    Feed.fm allows you to legally add popular music to your mobile app with a Pandora-style
    user interface. This SDK takes care of all communication with the Feed.fm service and
    delivery of music files to the iOS device - you need only set authentication tokens
    and call play, pause, skip, like or dislike on the shared player instance.

    This pod also contains a collection of UI elements that build on top of the core library.
    Sample elements include: play/pause, skip, and like/dislike buttons that update themselves
		automatically; UILabels that marquee and display the active song; and others.

    This pod includes an example app that can be used with 'pod try FeedMedia'
    Documentation for the classes in this package can be found at

    http://demo.feed.fm/sdk/docs/ios

    For a more full featured demo app, look at https://github.com/feedfm/iOS-RadioPlayer
DESC

  s.homepage         = "https://feed.fm/"
  s.license          = 'MIT'
  s.documentation_url = 'http://demo.feed.fm/sdk/docs/ios/'
  s.author           = { "Eric Lambrecht" => "eric@feed.fm", "Arveen Kumar" => "arveen@feed.fm", "Feed Media" => "support@feed.fm" }
  s.source           = { :git => "https://github.com/feedfm/iOS-SDK.git", :tag => "v#{s.version}" }

  s.xcconfig            = { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/FeedMedia/**"' }
  s.requires_arc = true

  s.platform         = :ios, '11.0'
  s.tvos.deployment_target = '11.0'

  s.frameworks = 'AVFoundation', 'MediaPlayer', 'CoreMedia'
  
  s.default_subspec     = 'Core'

  s.subspec 'Core' do |core|
    core.preserve_paths      = 'FeedMedia.xcframework' , 'FeedMedia.dSYMs/FeedMedia.framework.ios-armv7_arm64.dSYM', 'FeedMedia.dSYMs/FeedMedia.framework.ios-i386_x86_64-simulator.dSYM' , 'FeedMedia.dSYMs/FeedMedia.framework.ios-x86_64-maccatalyst.dSYM' ,
    'FeedMedia.dSYMs/FeedMedia.framework.tvos-arm64.dSYM', 'FeedMedia.dSYMs/FeedMedia.framework.tvos-x86_64-simulator.dSYM'
    core.vendored_frameworks = 'FeedMedia.xcframework'
  end
  
end
