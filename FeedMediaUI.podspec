
Pod::Spec.new do |s|
  s.name             = "FeedMediaUI"
  s.version          = "1.0.0"
  s.summary          = "UI elements that interact with the 'FeedMedia' pod to retrieve and play music"
  s.description      = <<-DESC
    This is a collection of UI elements that build on top of the 'FeedMedia' cocoapod that
    accesses the Feed.fm music service. Sample elements include: play/pause, skip, and like/dislike
    buttons that update themselves automatically; UILabels that marquee and display the active
    song; and others.

    This pod includes an example app that can be used with 'pod try FeedMediaUI'

    Class documentation is available at http://demo.feed.fm/sdk/docs/ios/ui

    For a more full featured demo app, look at https://github.com/feedfm/iOS-RadioPlayer

    If you are using this in a Swift project, use the 'FeedMediaUI/Swift' subspec and
    make sure your Podfile has 'use_frameworks!' declared.

                       DESC

  s.homepage         = "https://feed.fm/"
  s.license          = 'MIT'
  s.author           = { "Eric Lambrecht" => "eric@feed.fm", "Feed Media" => "support@feed.fm" }
  s.source           = { :git => "https://github.com/feedfm/iOS-UI-SDK.git", :tag => "v#{s.version}" }
  s.documentation_url = 'http://demo.feed.fm/sdk/docs/ios/ui/'

  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'FeedMediaUI' => ['Pod/Assets/**/*.png']
  }

  s.dependency "MarqueeLabel", "~> 2.7.9"

  s.subspec 'ObjC' do |sp|
    sp.platform     = :ios, '7.0'
    sp.dependency "FeedMedia/ObjC", "~> 2.4.13"
  end

  s.subspec 'Swift' do |sp|
    sp.platform     = :ios, '8.0'
    sp.dependency "FeedMedia/Swift", "~> 2.4.13"
  end

end
