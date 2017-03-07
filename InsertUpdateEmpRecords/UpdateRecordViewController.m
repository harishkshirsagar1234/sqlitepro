//
//  UpdateRecordViewController.m
//  InsertUpdateEmpRecords
//
//  Created by Pranav Udas on 22/10/16.
//  Copyright © 2016 Student-004. All rights reserved.
//

#import "UpdateRecordViewController.h"

@interface UpdateRecordViewController ()

@end



@implementation UpdateRecordViewController

-(void) InitPage
{
    //Step 3 : Open Database
    
    if(  sqlite3_open([_dbpath UTF8String], &_db)  ==  SQLITE_OK)
    {
        
        //Step 4: Create Table
        NSString *q = [[NSString alloc] initWithFormat:@"select * from emp where ename = '%@'",_updateEName.text];
        const char * query = [q UTF8String];
        
        sqlite3_stmt *mystmt;
        //step 5: execute create table query:
        if(sqlite3_prepare(_db, query, -1, &mystmt, NULL)  == SQLITE_OK)
        {
            
            while(sqlite3_step(mystmt) == SQLITE_ROW)
            {
                //EmployeeClass *empOb = [[EmployeeClass alloc] init];
                
                 _updateENo.text= [[NSString alloc] initWithFormat:@"%d",sqlite3_column_int(mystmt, 0)];
                _updateEName.text  = [[NSString alloc] initWithFormat:@"%s",sqlite3_column_text(mystmt, 1)];
                _updateEAdress.text =[[NSString alloc] initWithFormat:@"%s",sqlite3_column_text(mystmt, 2)];
                _updatePhoneNo.text = [[NSString alloc] initWithFormat:@"%d",sqlite3_column_int(mystmt, 3)];

            }
            
        }
        else
        {
            NSLog(@"failed to read record");
        }
        sqlite3_close(_db);
    }
    else
    {
        NSLog(@"Failed to open database for insert value");
    }
    

}

-(void) GetDatabasePathForEmp
{
    NSArray *documentDirectoryContents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //step 2 : Append database name to document directory path to get exact dbpath string.
    _dbpath= [NSString stringWithFormat:@"%@/EmployeeDatabase.sqlite",[documentDirectoryContents lastObject]];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    
    if([fileManager fileExistsAtPath:_dbpath])
    {
        NSLog(@"Database already exist");
        return ;
    }
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _updateEName.text = _tempString;
    [self GetDatabasePathForEmp];
    [self InitPage];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onUpdateRecord:(id)sender
{
    //Step 3 : Open Database
    
    if(  sqlite3_open([_dbpath UTF8String], &_db)  ==  SQLITE_OK)
    {
        
        //Step 4: Create Table
        NSString *q = [[NSString alloc] initWithFormat:@"update emp set ename = '%@', eaddress = '%@' , ephoneno = '%@' where eno = '%@'",_updateEName.text,_updateEAdress.text,_updatePhoneNo.text,_updateENo.text];
        const char * query = [q UTF8String];
        
        if( sqlite3_exec(_db, query, NULL, NULL, NULL) == SQLITE_OK)
        {
            NSLog(@"Record updated");
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            NSLog(@"Failed to update the record");
        }
        sqlite3_close(_db);
    }
    {
        NSLog(@"Unable to open database while updating records");
    }
}

- (IBAction)onDeleteRecord:(id)sender
{
    //Step 3 : Open Database
    
    if(  sqlite3_open([_dbpath UTF8String], &_db)  ==  SQLITE_OK)
    {
        
        //Step 4: Create Table
        NSString *q = [[NSString alloc] initWithFormat:@"delete from emp where eno = '%@'",_updateENo.text];
        const char * query = [q UTF8String];
        
        if( sqlite3_exec(_db, query, NULL, NULL, NULL) == SQLITE_OK)
        {
            NSLog(@"Record deleted");
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            NSLog(@"Failed to delete the record");
        }
        sqlite3_close(_db);
    }
    {
        NSLog(@"Unable to open database while deleting records");
    }

}
@end
