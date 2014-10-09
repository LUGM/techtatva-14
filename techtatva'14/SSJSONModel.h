//
//  SSJSONModel.h
//  SSJSONParse
//
//  Created by Shubham Sorte on 13/08/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//  SSJSONParse SS for Shubham Sorte

#import <Foundation/Foundation.h>

@class SSJSONModel;

@protocol SSJSONModelDelegate

- (void)jsonRequestDidCompleteWithDict:(NSArray *)array model:(SSJSONModel*)JSONModel;

@end

@interface SSJSONModel : NSObject <NSURLConnectionDelegate>

@property (weak, nonatomic) id<SSJSONModelDelegate> delegate;
@property (strong)NSArray * jsonDictionary;


@property (strong)NSURL * Url;

-(void)sendRequestWithUrl:(NSURL*)Url;

- (instancetype)initWithDelegate:(id<SSJSONModelDelegate>)delegate;

@end
