//
//  GuessWordDML.h
//  Ahorcado
//
//  Created by Meraz on 19/04/20.
//  Copyright © 2020 Meraz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GuessWordDML : NSObject

+ (NSString *)fetchWordFromCategory: (NSString*)categoryname;
+ (bool)addWordWithWord:(NSString *)word category:(NSString *)category;
+ (bool)deleteWord:(NSString *)wordString;

@end

NS_ASSUME_NONNULL_END
