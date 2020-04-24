//
//  ViewController.m
//  Ahorcado
//
//  Created by Meraz on 19/04/20.
//  Copyright © 2020 Meraz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    float wi, hi;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    wi = self.view.frame.size.width - 40;
    hi = wi * 300 / 1280;
    self.imvLogo.alpha = 0;
    self.imvLogo.frame = CGRectMake(20, self.view.frame.size.height, wi, wi * 300 / 1280);
}

-(void)viewDidAppear:(BOOL)animated{
    [UIView animateWithDuration:4 animations:^{
        self.imvLogo.alpha = 1;
        self.imvLogo.frame = CGRectMake(20, (self.view.frame.size.height - self->hi)/2, self->wi, self->wi * 300 / 1280);
    } completion:^(BOOL finished) {
        [self performSegueWithIdentifier:@"sgSplash" sender:self];
    }];
}

@end
