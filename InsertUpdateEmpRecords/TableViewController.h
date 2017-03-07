//
//  TableViewController.h
//  InsertUpdateEmpRecords
//
//  Created by Student-004 on 21/10/16.
//  Copyright © 2016 Student-004. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface TableViewController : UITableViewController

@property (nonatomic,nonnull)NSMutableArray *empRecord;
@property (nonatomic,retain) NSString *dbpath;
@property sqlite3 *db;
-(void) GetDatabasePathForEmp;
-(void) InitPage;

@end
