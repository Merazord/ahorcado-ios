//
//  GameViewController.m
//  Ahorcado
//
//  Created by Meraz on 19/04/20.
//  Copyright © 2020 Meraz. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *guessWordLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hangmanImgView;
@property (weak, nonatomic) IBOutletCollection(UIButton) NSArray *btnCollection;
- (IBAction)btnAction:(id)sender;

@end

@implementation GameViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    _guessWordLabel.text = _guessWord;
    _titlesArray = [NSArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z", nil];
    
    [self createHiddenWord];
    [self setupApplicationAudio];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getTime:) userInfo:nil repeats:YES];
    _startDate = [NSDate date];
}


- (void) setupApplicationAudio {
    
    NSString *correctSoundFilePath = [[NSBundle mainBundle]pathForResource: @"correct" ofType: @"wav"];
    NSString *wrongSoundFilePath = [[NSBundle mainBundle]pathForResource: @"wrong" ofType: @"wav"];
    
    NSURL *correctURL = [[NSURL alloc] initFileURLWithPath: correctSoundFilePath];
    NSURL *wrongURL = [[NSURL alloc] initFileURLWithPath: wrongSoundFilePath];
    
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
    
    NSError *activationError = nil;
    [[AVAudioSession sharedInstance] setActive: YES error: &activationError];
    
    _correctSoundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: correctURL error: nil];
    _wrongSoundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: wrongURL error: nil];
    
    [_correctSoundPlayer prepareToPlay];
    [_wrongSoundPlayer prepareToPlay];
}

- (void)getTime:(NSTimer *)sender{
    secondsSinceStart = (NSInteger)[[NSDate date] timeIntervalSinceDate:_startDate];
    _lblTime.text=[NSString stringWithFormat:@"%i",secondsSinceStart];
}


-(void)UpdateWordWithLetter:(unichar)letter {
    BOOL found = NO;
    for (int i = 0; i < [self.guessWord length]; i++) {
        if([self.guessWord characterAtIndex:i] == letter) {
            NSMutableString * newString = [[NSMutableString alloc] initWithString:_guessWordLabel.text];
            NSRange tempRange;
            tempRange.location = i;
            tempRange.length = 1;
            [newString replaceCharactersInRange:tempRange withString:[NSString stringWithFormat: @"%C", letter]];
            _guessWordLabel.text = newString;
            found = YES;
            
            [_correctSoundPlayer play];
        }
    }
    if(found == NO) {
        
        [_wrongSoundPlayer play];
        
        _curGuessCount++;
        if(_curGuessCount <= 4) {
            _hangmanImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",_curGuessCount]];
        }
        else {
            [_timer invalidate];
            _hangmanImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",5]];
            UIAlertController *lostAlertController = [UIAlertController alertControllerWithTitle:@"¡Lo siento, perdiste!" message:[@"Tu palabra era: " stringByAppendingString :self.guessWord] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
           
           [self dismissViewControllerAnimated:YES completion:nil];
       }];
       [lostAlertController addAction:ok];

       [self presentViewController:lostAlertController animated:YES completion:nil];
            
        }
    }
    if ([self.guessWord caseInsensitiveCompare:self.guessWordLabel.text] == NSOrderedSame) {
        int final = (5-_curGuessCount)*100-secondsSinceStart;
        [_timer invalidate];
        NSString *message = [NSString stringWithFormat:@"Tu puntuación fue de: %i", final];
        UIAlertController *winAlertController = [UIAlertController alertControllerWithTitle:@"¡Felicidades ganaste!" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [winAlertController addAction:ok];
        [self presentViewController:winAlertController animated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnAction:(id)sender {
    int tag = ((UIButton *)sender).tag;
    NSString* letter = [_titlesArray objectAtIndex:tag];
    [self UpdateWordWithLetter:[letter characterAtIndex:0]];
    
    ((UIButton *)sender).enabled = false;
}

-(void) createHiddenWord {
    NSMutableString * newString = [[NSMutableString alloc] initWithString:self.guessWord];
    for (NSUInteger i = 0; i < [newString length]; i++) {
        NSRange tempRange;
        tempRange.location = i;
        tempRange.length = 1;
        [newString replaceCharactersInRange:tempRange withString:[NSString stringWithFormat: @"%s", "-"]];
    }
    _guessWordLabel.text = newString;
    _curGuessCount = 0;
    _hangmanImgView.image = [UIImage imageNamed:@"0.png"];
    for (UIButton *btnItem in _btnCollection) {
        btnItem.enabled = YES;
    }
}
@end
