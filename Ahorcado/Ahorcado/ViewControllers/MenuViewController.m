//
//  MenuViewController.m
//  Ahorcado
//
//  Created by Meraz on 19/04/20.
//  Copyright © 2020 Meraz. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()
- (IBAction)showOptionsTableView:(id)sender;
- (IBAction)showScoresView:(id)sender;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showOptionsTableView:(id)sender {
    [self performSegueWithIdentifier:@"sgOptions" sender:self];

}

- (IBAction)showScoresView:(id)sender {
    [self performSegueWithIdentifier:@"sgScores" sender:self];

}








@end
