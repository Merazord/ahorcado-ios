//
//  GuessWordDML.m
//  Ahorcado
//
//  Created by Meraz on 19/04/20.
//  Copyright © 2020 Meraz. All rights reserved.
//

#import "GuessWordDML.h"
#import "Guessword+CoreDataClass.h"
#import "AppDelegate.h"


@implementation GuessWordDML

+ (NSManagedObjectContext *) getManagedObjectContext
{
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    return appDelegate.persistentContainer.viewContext;
}

+ (NSString *)fetchWordFromCategory: (NSString*)categoryname
{
    NSManagedObjectContext* context =[[self class] getManagedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Guessword" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category=%@", categoryname];
    [request setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"word" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error;
    NSMutableArray *mutableFetchResults = [[context executeFetchRequest:request error:&error] mutableCopy];
    NSString* retStr = nil;
    if (!mutableFetchResults)
    {
        return nil;
    }
    else
    {
        if([mutableFetchResults count] > 0)
        {
            int indexOfRandomWord = arc4random() % [mutableFetchResults count];
            Guessword *guessWordObj = [mutableFetchResults objectAtIndex:indexOfRandomWord];
            retStr = [NSString stringWithFormat:@"%@",guessWordObj.word];
        }
    }
    return retStr;
}

+ (bool)addWordWithWord:(NSString *)word category:(NSString *)category
{
    NSManagedObjectContext* context =[[self class] getManagedObjectContext];
    
    Guessword *guessWordObj = (Guessword *)[NSEntityDescription insertNewObjectForEntityForName:@"Guessword" inManagedObjectContext:context];
    
    guessWordObj.word = word;
    [guessWordObj setCategory:category];
    
    NSError *error;
    if(![context save:&error])
    {
        return false;
    }
    else
    {
        return true;
    }
}

+ (bool)deleteWord:(NSString *)wordString
{
    NSManagedObjectContext* context =[[self class] getManagedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Guessword" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"word=%@", wordString];
    [request setPredicate:predicate];
    
    NSError *error;
    NSMutableArray *mutableFetchResults = [[context executeFetchRequest:request error:&error] mutableCopy];
    if(mutableFetchResults.count > 0)
    {
        NSManagedObject *managedObject = [mutableFetchResults objectAtIndex:0];
        [context deleteObject:managedObject];
        if (![context save:&error])
        {
            return false;
        }
    }
    return true;
}

@end
