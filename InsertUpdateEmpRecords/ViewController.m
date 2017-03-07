//
//  ViewController.m
//  InsertUpdateEmpRecords
//
//  Created by Student-004 on 21/10/16.
//  Copyright © 2016 Student-004. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)OnSaveButtonClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *eno;
@property (weak, nonatomic) IBOutlet UITextField *ename;
@property (weak, nonatomic) IBOutlet UITextField *eaddress;
@property (weak, nonatomic) IBOutlet UITextField *ephoneno;

@end

@implementation ViewController

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
    // Do any additional setup after loading the view, typically from a nib.
    [self GetDatabasePathForEmp];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)OnSaveButtonClick:(id)sender
{
    int no  = [_eno.text intValue];
    const char *name = [_ename.text UTF8String];
    const char *address = [_eaddress.text UTF8String];
    int phno = [_ephoneno.text intValue];
    
    
    
    //Step 3 : Open Database
    
    if(  sqlite3_open([_dbpath UTF8String], &_db)  ==  SQLITE_OK)
    {
        
        //Step 4: Create Table
        NSString *queryFormat = [[NSString alloc] initWithFormat:@"insert into emp values(%d,'%s','%s',%d)",no,name,address,phno];
        
        NSLog(@"%@",queryFormat);
        const char * query = [queryFormat UTF8String];
        //step 5: execute create table query:
        if(sqlite3_exec(_db, query, NULL, NULL, NULL)== SQLITE_OK)
        {
            NSLog(@"record inserted");
        }
        else
        {
            NSLog(@"failed to insert record");
        }
        sqlite3_close(_db);
    }
    else
    {
        NSLog(@"Failed to open database for insert value");
    }

    
    
    
    [self.navigationController popViewControllerAnimated:YES ];
}
@end
