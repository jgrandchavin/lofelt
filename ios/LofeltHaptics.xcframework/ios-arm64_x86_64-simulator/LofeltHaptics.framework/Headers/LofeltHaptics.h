#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

//! Project version number for LofeltHaptics.
FOUNDATION_EXPORT double LofeltHapticsVersionNumber;

//! Project version string for LofeltHaptics.
FOUNDATION_EXPORT const unsigned char LofeltHapticsVersionString[];

//! Custom error domain
extern NSString *_Nonnull const LofeltErrorDomain;

/*!
    @class      LofeltHaptics
    @brief      The LofeltHaptics class
    @discussion Defines the API of Lofelt SDK for iOS.
    @author     Joao Freire, James Kneafsey, Thomas McGuire
    @copyright  © 2020 Lofelt. All rights reserved.
*/
@interface LofeltHaptics : NSObject
{
    void *_controller;
}

/*! @abstract       Checks if the iPhone meets the minimum requirements
    @discussion     This allows for a runtime check on iPhones  that  won't
                    meet the requirements for Lofelt Haptics.
            
    @return         Whether the iPhone supports or not Lofelt Haptics
 */
+ (BOOL)deviceMeetsMinimumRequirement;

- (instancetype)init NS_UNAVAILABLE;

/*! @abstract       Creates an instance of LofeltHaptics.
    @discussion     There should only be one instance of `LofeltHaptics` created in a given application.
    @param error    If the initalization fails, this will be set to a valid NSError describing the error.
*/
- (nullable instancetype)initAndReturnError:(NSError **)error API_AVAILABLE(ios(13)) NS_SWIFT_NAME(init());

/*! @abstract       Loads a haptic clip from string data.
    @discussion     The data must be in a valid Lofelt JSON format.
                    If a haptic clip is currently playing, it will be stopped.
    @param data     The Lofelt JSON format string.
    @param error    If the load operation fails, this will be set to a valid NSError describing the error.
    @return         Whether the operation succeeded
*/
- (BOOL)load:(NSString *_Nonnull)data error:(NSError *_Nullable *_Nullable)error API_AVAILABLE(ios(13));

/*! @abstract       Plays a loaded haptic clip.
    @discussion     The data must be preloaded using @c load() .
                    Only one haptic clip can play at a time.
                    Playback will start from the beginning of the haptic clip, or from the seek
                    position if seek() has been called before.
                    Calling play() if the clip is already playing has no effect.
    @param error    If the play operation fails, this will be set to a valid NSError describing the error.
    @return         Whether the operation succeeded
*/
- (BOOL)play:(NSError *_Nullable *_Nullable)error API_AVAILABLE(ios(13));

/*! @abstract       Stops the haptic clip that is currently playing.
    @discussion     The call is ignored if no clip is loaded or no clip is playing.
    @param error    If the stop operation fails, this will be set to a valid NSError describing the error.
    @return         Whether the operation succeeded
 */
- (BOOL)stop:(NSError *_Nullable *_Nullable)error API_AVAILABLE(ios(13));

/*! @abstract       Jumps to a time position in the haptic clip
    @discussion     The playback state (playing or stopped) will not be changed unless seeking
                    beyond the end of the haptic clip. Seeking beyond the end of the clip will stop
                    playback.
                    Seeking to a negative position will seek to the beginning of the clip (and playback
                    state will not change).
    @param time     The new position within the clip, as seconds from the beginning of the clip
    @param error    If the seek operation fails, this will be set to a valid NSError describing the error.
    @return         Whether the operation succeeded
 */
- (BOOL)seek:(float)time error:(NSError *_Nullable *_Nullable)error API_AVAILABLE(ios(13));

/*! @abstract       Returns the duration of the loaded clip
    @discussion     It will return 0.0 for an invalid clip
    @return         Duration of the loaded clip
 */
- (float)getClipDuration;

/*! @abstract           Attaches an AVAudioNode as a source for real-time audio to haptics.
    @discussion         Haptic output will begin as soon as audio starts playing.
    @param audioNode    Any audio source with base type AVAudioNode.
    @param error        If the attachAudioSource operation fails, this will be set to a valid NSError describing the error.
    @return             Whether the operation succeeded
 */
- (BOOL)attachAudioSource:(AVAudioNode *)audioNode error:(NSError *_Nullable *_Nullable)error API_AVAILABLE(ios(13));

@end

NS_ASSUME_NONNULL_END
