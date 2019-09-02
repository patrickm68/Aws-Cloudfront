# lita-aws-cloudfront
[![Gem Version](https://badge.fury.io/rb/lita-aws-cloudfront.svg)](https://badge.fury.io/rb/lita-aws-cloudfront)
[![Code Climate](https://codeclimate.com/github/unhappychoice/lita-aws-cloudfront/badges/gpa.svg)](https://codeclimate.com/github/unhappychoice/lita-aws-cloudfront)
[![Libraries.io dependency status for GitHub repo](https://img.shields.io/librariesio/github/unhappychoice/lita-aws-cloudfront.svg)](https://libraries.io/github/unhappychoice/lita-aws-cloudfront)
![](http://ruby-gem-downloads-badge.herokuapp.com/-aws-cloudfront?type=total)
![GitHub](https://img.shields.io/github/license/unhappychoice/-aws-cloudfront.svg)

`lita-aws-cloudfront` allows you to manage AWS CloudFront by commands. 

## Installation

Add lita-aws-cloudfront to your Lita instance's Gemfile:

``` ruby
gem "lita-aws-cloudfront"
```

## Configuration


## Usage

```bash
lita cloudfront distributions
lita cloudfront invalidations ${distribution_id}
lita cloudfront invalidate ${distribution_id} ${path or '/*' if path is empty} 
```
