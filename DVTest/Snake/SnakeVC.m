//
//  SecondViewController.m
//  DVTest
//
//  Created by psy on 13-9-24.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "SnakeVC.h"

struct Position {
    int x;
    int y;
};
typedef struct Position Position;

CG_INLINE Position
 makepp(int x, int y)
{
    Position p;
    p.x = x;
    p.y = y;
    return p;
}


@implementation SnakeVC {
    int viewWidth;
    int viewHeight;
    int speed;
    int cellWidth;
    
    NSTimer *timer;
    NSMutableArray *itemsArray;
    Position *path;
    int pathLength;
    BOOL isHold;
    int snakeIndex;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    itemsArray = [NSMutableArray array];
    path = malloc(sizeof(Position) * 1000);
    isHold = YES;
    cellWidth = 10;
    viewWidth = 4;
    viewHeight = 4;
    
    [self resetGameStatus];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(updateSnake)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)dealloc {
    [timer invalidate];
    timer = nil;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self resetLabel];
}

#pragma mark - IBAction

- (IBAction)sliderValueChanged:(UISlider*)sender {
    int value = (int)sender.value;
    
    switch (sender.tag) {
        case 100:
            viewWidth = value%2==0 ? value : value + 1 ;
            break;
        case 101:
            viewHeight = value;
            break;
        case 102:
            speed = value;
            break;
        default:
            break;
    }
    
    [self resetLabel];
}

- (IBAction)statusChanged {
    isHold = !isHold;
}

- (IBAction)resetGameStatus {
    self.panel.frame = CGRectMake(20, 200, viewWidth * cellWidth, viewHeight * cellWidth);
    self.panel.backgroundColor = [UIColor blackColor];
    isHold = YES;
    
    snakeIndex = 0;
    pathLength = 0;
    
    [self resetLabel];
    
    for (UIView *tmpView in itemsArray) {
        [tmpView removeFromSuperview];
    }
    [itemsArray removeAllObjects];
    
    
    for (int i=0; i<viewWidth; i++) {
        for (int j=1; j<viewHeight; j++) {
            Position pp;
            if (i%2==0) {
                pp = makepp(i, j);
            } else {
                pp = makepp(i, viewHeight - j);
            }
            path[pathLength++] = pp;
        }
    }
    
    for (int i=viewWidth-1; i>=0; i--) {
        path[pathLength++] = makepp(i, 0);
    }
    
    UIImageView *uu = [self createItem];
    [itemsArray addObject:uu];
    [self.panel addSubview:uu];
}

#pragma mark - private method

- (void)resetLabel {
    NSString *str = [NSString stringWithFormat:@"宽 %d - 高 %d - 速 %d",viewWidth,viewHeight,speed];
    _label.text = str;
}

- (void)updateSnake {
    if (isHold) {
        return;
    }
    
    // checkif crash
    
    // checkif eat new cell
    
    
    // checkif create new cell
    
    if (snakeIndex == 0 && itemsArray.count < pathLength) {
        //add一个cell
        UIImageView *uu = [self createItem];
        [itemsArray addObject:uu];
        [self.panel addSubview:uu];
    }
    
    
    // move
    
    for (int i=0; i<itemsArray.count; i++) {
        UIView *uu = [itemsArray objectAtIndex:i];
        [self resetCell:uu pos:snakeIndex - i];
    }
    
    snakeIndex ++;
    snakeIndex = snakeIndex % pathLength;

}

- (void)resetCell:(UIView*)cell pos:(int)pos {
    pos = pos <0 ? pathLength + pos: pos;
    pos = pos > pathLength ? pos - pathLength : pos;
    
    CGPoint point = CGPointMake(cellWidth * path[pos].x + cellWidth/2, cellWidth * path[pos].y + cellWidth/2);
    cell.center = point;

}

- (UIImageView*)createItem {
    UIImageView* tmpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cellWidth-2, cellWidth-2)];
//    tmpImageView.image = [UIImage imageNamed:@"cell"];
    tmpImageView.backgroundColor = [UIColor whiteColor];
    return tmpImageView;
}

@end
