# lita-aws-cloudfront
[![Gem Version](https://badge.fury.io/rb/lita-aws-cloudfront.svg)](https://badge.fury.io/rb/lita-aws-cloudfront)
[![Code Climate](https://codeclimate.com/github/unhappychoice/lita-aws-cloudfront/badges/gpa.svg)](https://codeclimate.com/github/unhappychoice/lita-aws-cloudfront)
[![codecov](https://codecov.io/gh/unhappychoice/lita-aws-cloudfront/branch/master/graph/badge.svg)](https://codecov.io/gh/unhappychoice/lita-aws-cloudfront)
[![Libraries.io dependency status for GitHub repo](https://img.shields.io/librariesio/github/unhappychoice/lita-aws-cloudfront.svg)](https://libraries.io/github/unhappychoice/lita-aws-cloudfront)
![](http://ruby-gem-downloads-badge.herokuapp.com/lita-aws-cloudfront?type=total)
![GitHub](https://img.shields.io/github/license/unhappychoice/lita-aws-cloudfront.svg)

`lita-aws-cloudfront` allows you to manage AWS CloudFront by commands. 

## Installation

Add lita-aws-cloudfront to your Lita instance's Gemfile:

``` ruby
gem "lita-aws-cloudfront"
```

## Configuration
Set environment variables below.

```
AWS_REGION=us-east-1
AWS_ACCESS_KEY_ID=xxxx
AWS_SECRET_ACCESS_KEY=xxxx
```

or use config

```
Lita.config.handlers.aws_cloudfront.aws_region = 'us-east-1'
Lita.config.handlers.aws_cloudfront.aws_access_key_id = 'xxxx'
Lita.config.handlers.aws_cloudfront.aws_secret_access_key = 'xxxx'
```

## Usage

```bash
lita cloudfront distributions
lita cloudfront invalidations ${distribution_id}
lita cloudfront invalidate ${distribution_id} ${path or '/*' if path is empty} 
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/unhappychoice/lita-aws-cloudfront. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Lita::AWS::CloudFront project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/unhappychoice/lita-aws-cloudfront/blob/master/CODE_OF_CONDUCT.md).
