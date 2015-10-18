//
//  ViewController.m
//  DatebasePackage
//
//  Created by Mac on 15/10/18.
//  Copyright (c) 2015年 hbbdsqd. All rights reserved.
//

#import "ViewController.h"
#import "HTTPRequest.h"
#import "Book.h"
#import "BookCell.h"
#import "DatabaseManager.h"
#import "Utility.h"

@interface ViewController ()

/**
 *  保存图书信息
 */
@property (nonatomic, strong) NSMutableArray *books;

@end

@implementation ViewController

- (NSMutableArray *)books
{
    if (!_books)
    {
        _books = [NSMutableArray array];
    }
    
    return _books;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
    
    //注册单元格
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BookCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    
    //没有网络，从数据库读取
    if (![Utility isNetWorkReachility])
    {
        NSLog(@"---- 没有网络，从数据库读取");
        
        //从数据库里面读数据
        NSArray *array = [[DatabaseManager databaseManager] queryAllObjectsFromDatabaseWithClass:[Book class]];
        
        
        [self.books addObjectsFromArray:array];
        
    }
    else
    {
        NSLog(@"---- 有网络，从网络获取");
        
        //请求数据
        [self requestDataFromNetWork];
    }
    
    
}

/**
 *  发送数据请求
 */
- (void)requestDataFromNetWork
{
    HTTPRequest *request = [[HTTPRequest alloc] initWithUrl:[NSURL URLWithString:@"https://api.douban.com/v2/book/search?q=s"]];
    //设置成功回调
    [request setHTTPRequestFinishBlock:^(HTTPRequest *request) {
        [self parseBookDataWithData:request.responseData];
    }];
    //发送异步请求
    [request startHttpRequest];
}

/**
 *  解析和封装数据模型
 *
 *  @param data <#data description#>
 */
- (void)parseBookDataWithData:(NSData *)data
{
    //清空旧数据
    [[DatabaseManager databaseManager] deleteAllObjectsFromDatabaseWithClass:[Book class]];
    
    //1.解析
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    //2.封装数据模型
    NSArray *jsonArr = jsonDic[@"books"];
    
    for (NSDictionary *dic in jsonArr)
    {
        Book *book = [[Book alloc] init];
        /*
         for (NSString *key in dic)
         {
         [book setValue:dic[key] forKey:key];
         }
         */
        [book setValuesForKeysWithDictionary:dic];
        
        //插入数据到数据库
        [[DatabaseManager databaseManager] insertObjectToDatabaseWithObject:book];
        
        //添加到数据源
        [self.books addObject:book];
        
        
        // NSLog(@"title:%@ ---- publish:%@ ---- large:%@",book.title,book.publisher,book.large);
        
    }
    
    //3.刷新界面
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.books.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (self.books.count > 0)
    {
        Book *book = self.books[indexPath.row];
        
        //赋值
        cell.book = book;
        
    }
    
    return cell;
}


@end
