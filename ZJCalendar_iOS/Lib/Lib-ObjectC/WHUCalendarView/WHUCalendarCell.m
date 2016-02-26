//
//  WHUCalendarCell.m
//  TEST_Calendar
//
//  Created by SuperNova(QQ:422596694) on 15/11/5.
//  Copyright (c) 2015年 SuperNova(QQ:422596694). All rights reserved.
//

#import "WHUCalendarCell.h"
@interface WHUCalendarCell()
@property(nonatomic,strong) CALayer* leftLineLayer;
@property(nonatomic,strong) CALayer* bottomLineLayer;
@property(nonatomic,strong) CALayer* infoLayer;
@end
@implementation WHUCalendarCell
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        self.backgroundColor=[UIColor whiteColor];
        UIView* view=[[UIView alloc] init];
        view.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:view];
        NSDictionary* viewDic2=@{@"view":view};
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(==0)-[view]-(==0)-|" options:0 metrics:nil views:viewDic2]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(==32)]" options:0 metrics:nil views:viewDic2]];
        NSLayoutConstraint* cons1=[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0];
        [self addConstraint:cons1];
        _lbl=[[UILabel alloc] init];
        _lbl.translatesAutoresizingMaskIntoConstraints=NO;
        //_lbl.font=[UIFont boldSystemFontOfSize:16.0f];
        _lbl.font=[UIFont systemFontOfSize:16.0];
        _lbl.textAlignment=NSTextAlignmentCenter;
        NSDictionary* viewDic=@{@"lbl":_lbl};
        [view addSubview:_lbl];
        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(==0)-[lbl]-(==0)-|" options:0 metrics:nil views:viewDic]];
        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(==3)-[lbl(==14)]" options:0 metrics:nil views:viewDic]];
        
        _dbl=[[UILabel alloc] init];
        _dbl.translatesAutoresizingMaskIntoConstraints=NO;
        _dbl.font=[UIFont systemFontOfSize:9.0];
        
        _dbl.textColor=[UIColor lightGrayColor];
        _dbl.textAlignment=NSTextAlignmentCenter;
        NSDictionary* viewDic1=@{@"dbl":_dbl,@"lbl":_lbl};
        [view addSubview:_dbl];
        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(==0)-[dbl]-(==0)-|" options:0 metrics:nil views:viewDic1]];
        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lbl]-(==4)-[dbl(==9)]" options:0 metrics:nil views:viewDic1]];
    }
    return self;
}


-(void)showTodayInfo{
    CGFloat midx=CGRectGetMidX(self.bounds);
    CATextLayer *label = [[CATextLayer alloc] init];
    [label setFontSize:9];
    [label setFrame:CGRectMake(midx+midx/2, 2, 10, 10)];
    [label setString:@"今"];
    label.contentsScale=[[UIScreen mainScreen] scale];
    [label setAlignmentMode:kCAAlignmentCenter];
    [label setForegroundColor:[[UIColor whiteColor] CGColor]];
    [_infoLayer addSublayer:label];

}

-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    if(highlighted){
        self.layer.backgroundColor=[UIColor colorWithRed:0 green:153.0/255 blue:51.0/255 alpha:1].CGColor;
        self.lbl.textColor=[UIColor whiteColor];
        self.dbl.textColor=[UIColor whiteColor];
    }
    else{
        self.layer.backgroundColor=[UIColor whiteColor].CGColor;
        if(_isDayInCurMonth){
            self.lbl.textColor=[UIColor blackColor];
        }
        else{
            self.lbl.textColor=[UIColor lightGrayColor];
        }
        self.dbl.textColor=[UIColor lightGrayColor];
    }
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if(selected){
        self.layer.backgroundColor=[UIColor colorWithRed:85.0/255 green:180.0/255 blue:70.0/255 alpha:1].CGColor;
        self.lbl.textColor=[UIColor whiteColor];
        self.dbl.textColor=[UIColor whiteColor];
    }
    else{
        self.layer.backgroundColor=[UIColor whiteColor].CGColor;
        if(_isDayInCurMonth){
            self.lbl.textColor=[UIColor blackColor];
        }
        else{
            self.lbl.textColor=[UIColor lightGrayColor];
        }
        self.dbl.textColor=[UIColor lightGrayColor];
    }
}

-(void)addTriLayer{
    CGFloat w=1/([UIScreen mainScreen].scale);
    CGFloat midx=CGRectGetMidX(self.bounds)-3;
    CGFloat midy=CGRectGetMidY(self.bounds)+3;
    CGFloat maxx=CGRectGetMaxX(self.bounds);
    UIBezierPath* path=[UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(midx, 0)];
    [path addLineToPoint:CGPointMake(maxx, 0)];
    [path addLineToPoint:CGPointMake(maxx, midy)];
    [path closePath];
    CAShapeLayer* layer=[CAShapeLayer layer];
    layer.contentsScale=w;
    layer.fillColor=[UIColor colorWithRed:0.25 green:0.65 blue:0.2 alpha:0.7].CGColor;
    layer.path=path.CGPath;
    [self.layer addSublayer:layer];
    self.infoLayer=layer;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w=1/([UIScreen mainScreen].scale);
    if(_rowIndex<_total-7&&_bottomLineLayer==nil){
        CALayer* hline=[CALayer layer];
        hline.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0].CGColor;
        hline.frame=CGRectMake(0,self.bounds.size.height-w, self.bounds.size.width, w);
        [self.layer addSublayer:hline];
        self.bottomLineLayer=hline;
    }
    if((_rowIndex+1)%7!=0&&_leftLineLayer==nil){
        CALayer* vline=[CALayer layer];
        vline.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0].CGColor;
        vline.frame=CGRectMake(self.bounds.size.width-w,0, w,self.bounds.size.height);
        [self.layer addSublayer:vline];
        self.leftLineLayer=vline;
    }
    if(_isToday){
        [self addTriLayer];
        [self showTodayInfo];
    }
    else{
        if(_infoLayer!=nil){
            [_infoLayer removeFromSuperlayer];
            _infoLayer=nil;
        }
    }
}
@end
