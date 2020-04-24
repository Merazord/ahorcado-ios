//
//  AppDelegate.h
//  Ahorcado
//
//  Created by Meraz on 19/04/20.
//  Copyright © 2020 Meraz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <AVFoundation/AVFoundation.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) AVAudioPlayer * player;
@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

