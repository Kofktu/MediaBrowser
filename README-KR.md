
![title](https://github.com/younatics/MediaBrowser/blob/master/Images/MediaBrowser_w.png?raw=true)

<p align="center">
  <a href="(https://github.com/younatics/MediaBrowser/blob/master/LICENSE" target="_blank"><img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-blue.svg?style=flat"></a>
  <img alt="Swift" src="https://img.shields.io/badge/Swift-3.1-orange.svg">
  <img alt="iOS 8.1+" src="https://img.shields.io/badge/iOS-8.1%2B-blue.svg">
  <a href="https://cocoapods.org/pods/MediaBrowser" target="_blank"><img alt="CocoaPods" src="http://img.shields.io/cocoapods/v/MediaBrowser.svg"></a>
  <a href="https://younatics.github.io/MediaBrowser" target="_blank"><img alt="CocoaDocs" src="https://github.com/younatics/MediaBrowser/blob/master/docs/badge.svg"></a>
  <a href="https://github.com/Carthage/Carthage" target="_blank"><img alt="Carthage" src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"></a>
  <a href="https://github.com/Carthage/Carthage" target="_blank"><img alt="ReadMe-KR" src="https://img.shields.io/badge/한국어-리드미-red.svg"></a>
  
</p>

#### 한국어로 리드미가 작성 될 예정입니다. PR이나 커밋은 환영합니다. 

## Intoduction
🏞 **MediaBrowser** can display one or more images or videos by providing either `UIImage` objects, `PHAsset` objects, or `URLs` to library assets, web images/videos or local files. MediaBrowser handles the downloading and caching of photos from the web seamlessly. Photos can be zoomed and panned, and optional (customisable) captions can be displayed. This can also be used to allow the user to select one or more photos using either the grid or main image view.

Also, MediaBrowser use latest [SDWebImage](https://github.com/rs/SDWebImage) version for caching, motivated by [MWPhotoBrowser](https://github.com/mwaterfall/MWPhotoBrowser)

| Single Photo | Multiple Photos And Video |
| ------------- | ------------------------ |
| ![SinglePhoto](https://github.com/younatics/MediaBrowser/blob/master/Images/SinglePhoto.gif?raw=true) | ![MultiplePhotosAndVideo](https://github.com/younatics/MediaBrowser/blob/master/Images/MultiplePhotosAndVideo.gif?raw=true) |
| Multiple Photo Grid | Multiple Photo Selection |
| ![MultiplePhotoGrid](https://github.com/younatics/MediaBrowser/blob/master/Images/MultiplePhotoGrid.gif?raw=true)  | ![PhotoSelection](https://github.com/younatics/MediaBrowser/blob/master/Images/PhotoSelection.gif?raw=true)  |
| Web Photos | Web Photos Grid |
| ![WebPhotos](https://github.com/younatics/MediaBrowser/blob/master/Images/WebPhotos.gif?raw=true)  | ![WebPhotoGrid](https://github.com/younatics/MediaBrowser/blob/master/Images/WebPhotoGrid.gif?raw=true)  |

## Requirements
`MediaBrowser` is written in Swift 3. Compatible with iOS 8.1+

## Usage
### Basic

Get `MediaBrowser` and set `MediaBrowserDelegate`
```Swift 
let browser = MediaBrowser(delegate: self)
self.navigationController?.pushViewController(browser, animated: true)

//MediaBrowserDelegate
func numberOfMedia(in mediaBrowser: MediaBrowser) -> Int {
  return mediaArray.count
}
    
func media(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
  if index < mediaArray.count {
    return mediaArray[index]
  }
  return DemoData.localMediaPhoto(imageName: "MotionBookIcon", caption: "Photo at index is Wrong")
}
```

## Installation
### Cocoapods
```ruby
pod 'MediaBrowser'
```
### Carthage
```
github "younatics/MediaBrowser"
```

## References
#### Please tell me or make pull request if you use this library in your application :) 

## Author
[younatics 🇰🇷](http://younatics.github.io)

## License
**MediaBrowser** is available under the MIT license. See the LICENSE file for more info.
