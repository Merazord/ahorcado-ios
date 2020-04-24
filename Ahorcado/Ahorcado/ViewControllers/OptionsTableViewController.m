//
//  OptionsTableViewController.m
//  Ahorcado
//
//  Created by Meraz on 19/04/20.
//  Copyright © 2020 Meraz. All rights reserved.
//


#import "OptionsTableViewController.h"
#import "GuessWordDML.h"
#import "GameViewController.h"
#import "MyCustomCell.h"

@interface OptionsTableViewController ()
- (IBAction)menuBtnAction:(id)sender;
@end

@implementation OptionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"Facil", @"Medio", @"Dificil", nil];
    
    _descArray = [[NSMutableArray alloc] initWithObjects:@"Selecciona esta opción para  jugar en modo fácil", @"Selecciona esta opción para jugar en modo medio", @"Selecciona esta opción para jugar en modo difícil", nil];
    
    [self loadWordsIntoDatabase];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    cell.lblMain.text = [_dataArray objectAtIndex:indexPath.row];
    cell.lblDescription.text = [_descArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}

- (void)tableView:(UITableView * )tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* selectedCategory = [_dataArray objectAtIndex:indexPath.row];
    _guessWord = [GuessWordDML fetchWordFromCategory:selectedCategory ];
    [GuessWordDML deleteWord:_guessWord];

    [self performSegueWithIdentifier:@"sgGame" sender:self];
}



- (IBAction)menuBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void) loadWordsIntoDatabase
{
    if ([GuessWordDML fetchWordFromCategory:@"Facil"] == nil)
    {
        NSString *easyPath = [[NSBundle mainBundle] pathForResource:@"Facil" ofType:@"plist"];
        NSMutableArray *easyArray = [[NSMutableArray alloc] initWithContentsOfFile:easyPath];
        for (int i=0; i<easyArray.count; i++)
        {
            NSString* curWord = (NSString *)[easyArray objectAtIndex:i];
            [GuessWordDML addWordWithWord:curWord category:@"Facil"];
        }
        NSString *mediumPath = [[NSBundle mainBundle] pathForResource:@"Medio" ofType:@"plist"];
        NSMutableArray *mediumArray = [[NSMutableArray alloc] initWithContentsOfFile:mediumPath];
        for (int i=0; i<mediumArray.count; i++)
        {
            NSString* curWord = (NSString *)[mediumArray objectAtIndex:i];
            [GuessWordDML addWordWithWord:curWord category:@"Medio"];
        }
        NSString *difficultPath = [[NSBundle mainBundle] pathForResource:@"Dificil" ofType:@"plist"];
        NSMutableArray *difficultArray = [[NSMutableArray alloc] initWithContentsOfFile:difficultPath];
        for (int i=0; i<difficultArray.count; i++)
        {
            NSString* curWord = (NSString *)[difficultArray objectAtIndex:i];
            [GuessWordDML addWordWithWord:curWord category:@"Dificil"];
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"sgGame"])
    {
        GameViewController *gameVC = [segue destinationViewController];
        gameVC.guessWord = _guessWord;
    }
}

@end
