
Pod::Spec.new do |s|
  s.name             = "FeedMedia"
  s.version          = "4.2.4-beta"
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
  s.author           = { "Eric Lambrecht" => "eric@feed.fm", "Arveen Kumar" => "arveen@feed.fm", "Feed Media" => "support@feed.fm" }
  s.source           = { :git => "https://github.com/feedfm/iOS-SDK.git", :tag => "v#{s.version}" }
  s.documentation_url = 'http://demo.feed.fm/sdk/docs/ios/'

  s.requires_arc = true

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '11.0'

  # common source files/dependencies
  s.dependency "MarqueeLabel", "~> 3.1.4"
	s.source_files = [ 'Sources/*.{m,h}', 'Core/Feed*.h', 'Core/FM*.h' ]
	s.public_header_files = [ 'Sources/*.h', 'Core/Feed*.h', 'Core/FM*.h' ]

  # ios-specific source files
	s.ios.source_files = [ 'Sources/ios/*.{m,h}', 'Core/CWStatusBarNotification.h' ]
	s.ios.public_header_files = [ 'Sources/ios/*.h', 'Core/CWStatusBarNotification.h' ]

  # tvos-specific source fles
	s.tvos.source_files = 'Sources/tvos/*.{m,h}'
	s.tvos.public_header_files = 'Sources/tvos/*.h'

  s.ios.vendored_library =  'Core/libFeedMediaCore.a'
  s.tvos.vendored_library = 'Core/libFeedMediaCore-tv.a'

  s.frameworks = 'AVFoundation', 'MediaPlayer', 'CoreMedia'

end
