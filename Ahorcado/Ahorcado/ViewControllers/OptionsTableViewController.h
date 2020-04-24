//
//  OptionsTableViewController.h
//  Ahorcado
//
//  Created by Meraz on 19/04/20.
//  Copyright © 2020 Meraz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OptionsTableViewController : UITableViewController
{
    NSMutableArray* _dataArray;
    NSMutableArray* _descArray;
    NSString* _guessWord;
}

@end
NS_ASSUME_NONNULL_END
