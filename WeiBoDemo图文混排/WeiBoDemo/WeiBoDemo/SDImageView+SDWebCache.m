//
//  UIImageView+SDWebCache.m
//  SDWebData
//
//  Created by stm on 11-7-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SDImageView+SDWebCache.h"
#import "CustomObject.h"
@implementation UIImageView(SDWebCacheCategory)

- (void)setImageWithURL:(NSURL *)url
{
	[self setImageWithURL:url refreshCache:NO];
}

- (void)setImageWithURL:(NSURL *)url refreshCache:(BOOL)refreshCache
{
	[self setImageWithURL:url refreshCache:refreshCache placeholderImage:nil];
}

- (UIImage *)setImageWithURL:(NSURL *)url refreshCache:(BOOL)refreshCache placeholderImage:(UIImage *)placeholder
{
    self.image = placeholder;
    if (url)
    {
        if ([[CustomObject sharedCustomObject] isExistImage:url]) {
            self.image = [[CustomObject sharedCustomObject]getImage:url];
        }
        else{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData * data = [[NSData alloc]initWithContentsOfURL:url];
                UIImage *image = [[UIImage alloc]initWithData:data];
                if (data != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[CustomObject sharedCustomObject] addImage:image key:url];
                        self.image = image;
                    });
                    [data release];
                }
                   [image release];
            });
        }
    }
    return nil;
}
-(UIImage *)getImageWithUrl:(NSURL *)url refreshCache:(BOOL)refreshCache placeholderImage:(UIImage *)placeholder
{
     __block UIImage *Rtimage=placeholder;
    if (url)
    {
        if ([[CustomObject sharedCustomObject] isExistImage:url]) {
            Rtimage = [[CustomObject sharedCustomObject]getImage:url];
        }
        else{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData * data = [[NSData alloc]initWithContentsOfURL:url];
                UIImage *image = [[UIImage alloc]initWithData:data];
                if (data != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[CustomObject sharedCustomObject] addImage:image key:url];
                        Rtimage = image;
                    });
                    [data release];
                }
                [image release];
            });
        }
    }
    return Rtimage;
}
@end
