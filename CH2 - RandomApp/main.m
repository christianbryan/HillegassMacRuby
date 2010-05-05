//
//  main.m
//  RandomApp
//
//  Created by Christian Bryan on 03/02/2010.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
    return macruby_main("rb_main.rb", argc, argv);
}
