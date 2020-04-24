//
//  GameViewController.h
//  Ahorcado
//
//  Created by Meraz on 19/04/20.
//  Copyright © 2020 Meraz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN


@interface GameViewController : UIViewController

{
    int _curGuessCount;
    int secondsSinceStart;
    NSArray* _titlesArray;
    AVAudioPlayer* _correctSoundPlayer;
    AVAudioPlayer* _wrongSoundPlayer;
}

@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (nonatomic, retain) NSString* guessWord;
@property (nonatomic,strong)NSTimer * timer;
@property (nonatomic,strong)NSDate * startDate;
-(void)getTime:(NSTimer*)sender;
@end

NS_ASSUME_NONNULL_END
