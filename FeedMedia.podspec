
Pod::Spec.new do |s|
  s.name             = "FeedMedia"
  s.version          = "4.0.4"
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
  s.author           = { "Eric Lambrecht" => "eric@feed.fm", "Feed Media" => "support@feed.fm" }
  s.source           = { :git => "https://github.com/feedfm/iOS-SDK.git", :tag => "v#{s.version}" }
  s.documentation_url = 'http://demo.feed.fm/sdk/docs/ios/'

  s.requires_arc = true

  s.platform     = :ios, '9.0'

  #
  # core library is needed everywhere
  #

  s.vendored_library = 'Core/libFeedMediaCore.a'
  s.source_files = 'Core/*.h'
  s.public_header_files = 'Core/*.h'
  s.frameworks = 'AVFoundation', 'MediaPlayer', 'CoreMedia'


  #
  # UI ViewControllers and Assets
  #

  s.subspec 'UI' do |sp|
    sp.dependency "MarqueeLabel", "~> 3.0.3"
		sp.source_files = 'UI/*.{m,h}', 'Core/*.h'
		sp.public_header_files = 'UI/*.h', 'Core/*.h'
    sp.vendored_library = 'Core/libFeedMediaCore.a'
		sp.resource_bundles = {
			'FeedMedia' => [ 'Assets/**/*.png' ]
		}
    sp.frameworks = 'AVFoundation', 'MediaPlayer', 'CoreMedia'
  end

end
