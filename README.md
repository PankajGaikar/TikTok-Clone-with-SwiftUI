# VideoBrowser

Target - Build an app which will allow user to browse and play videos. (Vertical scrolling for categories and Horizontal scrolling to browse video in mentioned category)

#

# Output 

![Video Browser Demo](https://github.com/PankajGaikar/VideoBrowser/blob/master/Demo/VideoBrowser.gif)

#

# Architecture 
* Design Pattern - MVVM
* Vertical Scroll - TableView
* Horizontal Scroll - CollectionView inside TableViewCell
* VideoScroll - Via UIPageViewController
* Video Playback - AVPlayerViewController
#

## Completed tasks
- [x] Implement Vertical and Horizontal scrolling in `Explore screen`.
- [x] Show video thumbnail on `Explore screen` for video
- [x] Selected Video will play in new screen (call it `Player Screen`). User should be able
to scroll up/down in `Player screen` to play previous/next video from same category
##
## Future scope
- [ ] Show Animated Transition as Photos app to move  
  - [ ] from `Explore screen` to `Player screen` (On Video cell tap) 
  - [ ] move back from `Player screen` to `Explore screen` (On swipe right)
##

