//
//  toast.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/10/7.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import "toast.h"

@implementation toast


// 画出圆角矩形背景
static void addRoundedRectToPath(CGContextRef context, CGRect rect,
                                 float ovalWidth,float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, CGRectGetMinX(rect),
                           CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

- (id)initWithFrame:(CGRect)frame bgColor:(CGColorRef)color info:(NSString*)info{
    CGRect viewR = CGRectMake(0, 0, frame.size.width*2.5, frame.size.height*2);
    self = [super initWithFrame:viewR];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        bgcolor_ = color;
        info_ = [[NSString alloc] initWithString:info];
        fontSize_ = frame.size;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 背景0.8透明度
    CGContextSetAlpha(context, .8);
    addRoundedRectToPath(context, rect, 4.0f, 4.0f);
    CGContextSetFillColorWithColor(context, bgcolor_);
    CGContextFillPath(context);
    
    // 文字1.0透明度
    CGContextSetAlpha(context, 1.0);
    //    CGContextSetShadowWithColor(context, CGSizeMake(0, -1), 1, [[UIColor whiteColor] CGColor]);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    float x = (rect.size.width - fontSize_.width) / 5.0;
    float y = (rect.size.height - fontSize_.height) / 2.0;
    CGRect r = CGRectMake(x, y, fontSize_.width*2.0, fontSize_.height);
    
    UIFont *font = [UIFont fontWithName:@"Courier" size:kSGInfoAlert_fontSize];
    
    /// Make a copy of the default paragraph style
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByClipping;
    /// Set text alignment
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSParagraphStyleAttributeName: paragraphStyle };
    
    [info_ drawInRect:r withAttributes:attributes];
    
}

// 从上层视图移除并释放
- (void)remove{
    [self removeFromSuperview];
}

// 渐变消失
- (void)fadeAway{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    self.alpha = .0;
    [UIView commitAnimations];
    [self performSelector:@selector(remove) withObject:nil afterDelay:1];
}

+ (toast *)showInfo:(NSString *)info
            bgColor:(CGColorRef)color
             inView:(UIView *)view
           vertical:(float)height{
    
    if ([view viewWithTag:kViewTag] != nil) {
        toast *alert = (toast *)[view viewWithTag:kViewTag];
        [alert remove];
    }
    height = height < 0 ? 0 : height > 1 ? 1 : height;
    CGSize size = [info sizeWithAttributes:
                   @{NSFontAttributeName:
                         [UIFont systemFontOfSize:kSGInfoAlert_fontSize]}];
    
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    toast *alert = [[toast alloc] initWithFrame:frame bgColor:color info:info];
    alert.center = CGPointMake(view.center.x, view.frame.size.height*height);
    alert.alpha = 0;
    [view addSubview:alert];
    alert.tag = kViewTag;
    [UIView beginAnimations:nil context:nil]; [UIView setAnimationDuration:.3f];
    
    NSLog(@"@@info.length=%lu",(unsigned long)info.length);
    

    alert.alpha = 1.0;
    [UIView commitAnimations];
    
    if ((int)info.length>15) {
        
        NSLog(@"info.length>15");
        size = [info sizeWithAttributes:
                @{NSFontAttributeName:
                      [UIFont systemFontOfSize:9]}];
        
        [alert performSelector:@selector(fadeAway) withObject:nil afterDelay:2.5];
        
    }else if ((int)info.length>20){
        
        NSLog(@"info.length>20");
        size = [info sizeWithAttributes:
                @{NSFontAttributeName:
                      [UIFont systemFontOfSize:7]}];
        [alert performSelector:@selector(fadeAway) withObject:nil afterDelay:4.5];
        
    }else{
        [alert performSelector:@selector(fadeAway) withObject:nil afterDelay:1.5];
    }
    
    return alert;
}
@end
