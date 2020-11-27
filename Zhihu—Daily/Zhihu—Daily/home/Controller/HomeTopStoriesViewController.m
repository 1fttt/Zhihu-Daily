//
//  HomeTopStoriesViewController.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/19.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "HomeTopStoriesViewController.h"
#import "CommentViewController.h"
#import "Manager.h"
#import "FMDBManager.h"


@interface HomeTopStoriesViewController () <UIScrollViewDelegate>

@end

@implementation HomeTopStoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _select = 0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    //工具栏
    self.navigationController.toolbarHidden = NO;
    self.navigationController.toolbar.translucent = NO;

    
    _topStoriesView = [[HomeTopStoriesView alloc] initWithFrame:CGRectMake(0, 20, 414, 800)];
    //_topStoriesView = [[HomeTopStoriesView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_topStoriesView];
    //_topStoriesView.storyURLStr = [NSString stringWithFormat:@"%@", _urlStr];
    
    _topStoriesView.storyURLArray = [[NSArray alloc] init];
    _topStoriesView.storyURLArray = _urlArray;
    
    [_topStoriesView initView];
    
    _topStoriesView.extraArray = [[NSArray alloc] init];
    _topStoriesView.extraArray = _extraArray;
    
    //隐藏默认返回按钮
    //self.navigationItem.hidesBackButton = YES;
    //[self.navigationItem setHidesBackButton:YES animated:YES];
    
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //导航栏隐藏
    //[self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:_webView];
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    
    
    //self.navigationController.toolbar.tintColor = [UIColor blackColor];
    
    //返回
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui-copy-copy"] style:UIBarButtonItemStylePlain target:self action:@selector(pressBack)];
    [item1 setTintColor:[UIColor blackColor]];
    
    //评论
    [_topStoriesView initToolbarItem];
    [_topStoriesView.commentButton setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
    [_topStoriesView.commentButton addTarget:self action:@selector(pressComment) forControlEvents:UIControlEventTouchUpInside];
    

    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:_topStoriesView.commentItemView];

    
    //点赞
  
    //_topStoriesView.itemLabel.text = @"493";
    [_topStoriesView.popularityButton setImage:[UIImage imageNamed:@"zanpress"] forState:UIControlStateNormal];
    [_topStoriesView.popularityButton addTarget:self action:@selector(pressPopularity:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithCustomView:_topStoriesView.popularityItemView];
    
    
   
    //收藏
    _item4 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shoucang"] style:UIBarButtonItemStylePlain target:self action:@selector(pressShouCang:)];

    if ([self judgeCollect]) {
        [_item4 setImage:[UIImage imageNamed:@"shoucang11"]];
    } else {
        [_item4 setTintColor:[UIColor blackColor]];
        [_item4 setImage:[UIImage imageNamed:@"shoucang"]];
        
    }
    

    
    
    //分享

    UIImageView *image = [[UIImageView alloc] init];
    [image setImage:[UIImage imageNamed:@"shangchuan-2"]];
    
    UIBarButtonItem *item5 = [[UIBarButtonItem alloc] initWithCustomView:image];
    //[item5 setImage:[UIImage imageNamed:@"shangchuan-2"]];
    [item5 setTarget:self];
    [item5 setAction:@selector(pressShare)];
    [item5 setTintColor:[UIColor blackColor]];
    
    //创建自动计算宽度按钮
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    
    NSArray *arrayBtns = [NSArray arrayWithObjects:item1, btn, item2, btn, item3, btn, _item4, btn, item5, nil];
    self.toolbarItems = arrayBtns;
    

    _topStoriesView.webScrollView.delegate = self;
    
    
    
    
    
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int y = (scrollView.contentOffset.y + 10) / 800;
     
     _currentpage = y;
     
     //ExtraModel *extraModel = [[ExtraModel alloc] init];
     
     for (ExtraModel *extraModel in _extraArray) {
         if ([extraModel.cc isEqualToString:_idArray[y]]) {
             NSString *commentsStr = [NSString stringWithFormat:@"%ld", (long)extraModel.comments];
             NSString *popularityStr = [NSString stringWithFormat:@"%ld", extraModel.popularity];
             
             _topStoriesView.commentLabel.text = commentsStr;
             _topStoriesView.popularityLabel.text = popularityStr;
             
             _longCommentNumStr = [NSString stringWithFormat:@"%ld", extraModel.long_comments];
             _shortCommentNumStr = [NSString stringWithFormat:@"%ld", extraModel.short_comments];
             _commentNumStr = [NSString stringWithFormat:@"%ld", extraModel.comments];
            
             break;
         }
     }
    
    _topStoriesView.popularityButton.selected = NO;
    [_topStoriesView.popularityButton setImage:[UIImage imageNamed:@"zanpress"] forState:UIControlStateNormal];
    _topStoriesView.popularityLabel.textColor = [UIColor blackColor];
    
    if ([self judgeCollect]) {
        [_item4 setTintColor:[UIColor colorWithRed:0 green:0.47 blue:0.98 alpha:1]];
        [_item4 setImage:[UIImage imageNamed:@"shoucang11"]];
    } else {
        [_item4 setTintColor:[UIColor blackColor]];
        [_item4 setImage:[UIImage imageNamed:@"shoucang"]];
        
    }
    
    
}


//返回
- (void)pressBack {
    [self.navigationController popViewControllerAnimated:YES];
}

//评论
- (void)pressComment {
    
    CommentViewController *commentView = [[CommentViewController alloc] init];
    commentView.idstr = [[NSString alloc] initWithString:_idArray[_currentpage]];
    NSLog(@"%@", _idArray[_currentpage]);
    
    commentView.longCommentNumStr = [NSString stringWithString:_longCommentNumStr];
    commentView.shortCommentNumStr = [NSString stringWithString:_shortCommentNumStr];
    commentView.commentNumStr = [NSString stringWithFormat:_commentNumStr];
    
    [self.navigationController.toolbar setHidden:YES];
    
    [self.navigationController pushViewController:commentView animated:YES];
    
    
}

//点赞
- (void)pressPopularity:(UIButton *)button {
    
    if (button.selected == NO) {
        _topStoriesView.popularityLabel.textColor = [UIColor colorWithRed:0.1 green:0.5 blue:0.9 alpha:1];
        _topStoriesView.popularityLabel.text = [NSString stringWithFormat:@"%d", [_topStoriesView.popularityLabel.text intValue] + 1];
        [button setImage:[UIImage imageNamed:@"zan1-2"] forState:UIControlStateNormal];
        button.selected = YES;
    } else {
        _topStoriesView.popularityLabel.textColor = [UIColor blackColor];
        _topStoriesView.popularityLabel.text = [NSString stringWithFormat:@"%d", [_topStoriesView.popularityLabel.text intValue] - 1];
        [button setImage:[UIImage imageNamed:@"zanpress"] forState:UIControlStateNormal];
        button.selected = NO;
    }
    

}

//收藏
- (void)pressShouCang:(UIBarButtonItem *)button {
    if ([self judgeCollect]) {
        [button setTintColor:[UIColor blackColor]];
        [button setImage:[UIImage imageNamed:@"shoucang"]];
        FMDBManager *manager = [FMDBManager shareManager];
        if ([manager.fmdb open]) {
            [manager.fmdb executeUpdate:[NSString stringWithFormat:@"delete from collect_story where title = '%@'", _titleArray[_currentpage]]];
            [manager.fmdb close];
        } else {
            
        }
        
    } else {
        //[button setTintColor:[UIColor colorWithRed:0.1 green:0.4 blue:0.6 alpha:1] ];
        [button setTintColor:[UIColor colorWithRed:0 green:0.47 blue:0.98 alpha:1]];
        [button setImage:[UIImage imageNamed:@"shoucang11"]];
        //button.
        FMDBManager *manager = [FMDBManager shareManager];
        [manager insertTitle:_titleArray[_currentpage] andImage:_imageDataArray[_currentpage]];
    }
    
    
   
}


- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    NSLog(@"test");

    [_topStoriesView.webScrollView setContentOffset:CGPointMake(0, _currentpage * _topStoriesView.webScrollView.frame.size.height)];
    
    if (_currentpage == 0) {
        for (ExtraModel *extraModel in _extraArray) {
            if ([extraModel.cc isEqualToString:_idArray[_currentpage]]) {
                NSString *commentsStr = [NSString stringWithFormat:@"%ld", (long)extraModel.comments];
                NSString *popularityStr = [NSString stringWithFormat:@"%ld", extraModel.popularity];
                
                _topStoriesView.commentLabel.text = commentsStr;
                _topStoriesView.popularityLabel.text = popularityStr;
            }
        }
    }
    
    [self.navigationController.toolbar setHidden:NO];
    
}


//分享
- (void)pressShare {
    

}

- (BOOL)judgeCollect {
    FMDBManager *manager = [FMDBManager shareManager];
    NSArray *titleArray = [manager getTitles];
    BOOL flag = NO;
    if (titleArray.count) {
        for (NSString *str in titleArray) {
            if([str isEqualToString:_titleArray[_currentpage]]) {
                flag = YES;
                break;
            }
        }
    }
    return flag;
}


@end
