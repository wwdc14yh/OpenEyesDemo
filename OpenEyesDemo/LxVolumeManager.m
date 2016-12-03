//
//  LxVolumeManager.m
//  LxVolumeManagerDemo
//

#import "LxVolumeManager.h"
#import <MediaPlayer/MPMusicPlayerController.h>

@implementation LxVolumeManager

static id _volumeChangeObserve;
static CGFloat _savedVolume;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"

+ (CGFloat)currentVolume
{
    return [MPMusicPlayerController iPodMusicPlayer].volume;
}

+ (void)setVolume:(CGFloat)volume
{
    volume = MIN(1, MAX(0, volume));
    [MPMusicPlayerController iPodMusicPlayer].volume = volume;
}

+ (void)mute
{
    _savedVolume = [self currentVolume];
    [self setVolume:0];
}

+ (void)unmute
{
    [self setVolume:MAX(_savedVolume, 1/16.0)];
}

+ (void)beginObserveVolumeChange:(void (^)(CGFloat volume))volumeChangeCallBack
{
    [[MPMusicPlayerController iPodMusicPlayer] beginGeneratingPlaybackNotifications];
    _volumeChangeObserve = [[NSNotificationCenter defaultCenter]
                            addObserverForName:MPMusicPlayerControllerVolumeDidChangeNotification
                                        object:nil
                                         queue:nil
                                    usingBlock:^(NSNotification *note) {
                                        
                                        MPMusicPlayerController * musicPlayerController = note.object;                                        
                                        volumeChangeCallBack(musicPlayerController.volume);
                                    }];
}

+ (void)stopObserveVolumeChange
{
    [[MPMusicPlayerController iPodMusicPlayer] endGeneratingPlaybackNotifications];
    [[NSNotificationCenter defaultCenter]removeObserver:_volumeChangeObserve name:MPMusicPlayerControllerVolumeDidChangeNotification object:nil];
    _volumeChangeObserve = nil;    
}

#pragma clang diagnostic pop

@end
