//
//  UpdateRecordViewController.h
//  InsertUpdateEmpRecords
//
//  Created by Pranav Udas on 22/10/16.
//  Copyright © 2016 Student-004. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface UpdateRecordViewController : UIViewController

@property (nonatomic,retain) NSString *tempString;
@property (weak, nonatomic) IBOutlet UITextField *updateENo;
@property (weak, nonatomic) IBOutlet UITextField *updateEName;
@property (weak, nonatomic) IBOutlet UITextField *updateEAdress;
@property (weak, nonatomic) IBOutlet UITextField *updatePhoneNo;
-(void) InitPage;

-(void) GetDatabasePathForEmp;
@property (nonatomic,retain) NSString *dbpath;
@property sqlite3 *db;
- (IBAction)onUpdateRecord:(id)sender;

- (IBAction)onDeleteRecord:(id)sender;

@end
