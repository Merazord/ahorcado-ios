//
//  MyCustomCell.h
//  Ahorcado
//
//  Created by Meraz on 19/04/20.
//  Copyright © 2020 Meraz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface MyCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblMain;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;

@end

NS_ASSUME_NONNULL_END
