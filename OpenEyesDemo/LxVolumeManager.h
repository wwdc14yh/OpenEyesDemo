//
//  LxVolumeManager.h
//  LxVolumeManagerDemo
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#define LX_UNAVAILABLE(msg) __attribute__((unavailable(msg)))

@interface LxVolumeManager : NSObject

+ (CGFloat)currentVolume;
+ (void)setVolume:(CGFloat)volume;

+ (void)mute;
+ (void)unmute;

+ (void)beginObserveVolumeChange:(void (^)(CGFloat volume))volumeChangeCallBack;
+ (void)stopObserveVolumeChange;

#pragma mark - Unavailable

- (instancetype)init LX_UNAVAILABLE("LxVolumeManager cannot be initialized!");
- (instancetype)initWithCoder:(NSCoder *)aDecoder LX_UNAVAILABLE("LxVolumeManager cannot be initialized!");

@end
