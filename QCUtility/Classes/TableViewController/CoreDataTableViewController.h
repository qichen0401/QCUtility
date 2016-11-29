//
//  CoreDataTableViewController.h
//  CoreDataTableViewDemo
//
//  Created by Qi Chen on 11/21/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CoreDataTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

typedef NS_ENUM(NSUInteger, SectionTitleType) {
    SectionTitleNone,
    SectionTitleName,
    SectionTitleIndex,
};

@property (nonatomic, strong, nonnull) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) bool supportDelete;
@property (nonatomic) SectionTitleType sectionTitleType;

- (void)initializeFetchedResultsControllerWithEntityName:(nonnull NSString *)entityName sortDescriptors:(nonnull NSArray<NSSortDescriptor *> *)sortDescriptors managedObjectContext:(nonnull NSManagedObjectContext *)context sectionNameKeyPath:(nullable NSString *)sectionNameKeyPath cacheName:(nullable NSString *)cacheName;

//override
- (void)registerForCellReuseIdentifier;
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)configureCell:(nonnull id)cell atIndexPath:(nonnull NSIndexPath *)indexPath;

@end
